from __future__ import annotations

import argparse
import json
import re
from html import unescape
from urllib.parse import urljoin
from urllib.request import Request, urlopen

from lxml import html


def clean(text: str) -> str:
    return " ".join(unescape(text).split())


def issue_url(slug: str) -> str:
    return f"https://vjs.ac.vn/jst/issue/view/{slug.lower()}"


def slug_from_args(args: argparse.Namespace) -> str:
    if args.slug:
        return args.slug.lower()
    if args.volume is None or args.number is None:
        raise SystemExit("Provide --slug or both --volume and --number")
    return f"vol{args.volume}n{args.number}"


def parse_page_range(text: str) -> tuple[int | None, int | None]:
    match = re.search(r"(\d+)\s*[\u2013-]\s*(\d+)", text)
    if not match:
        return None, None
    return int(match.group(1)), int(match.group(2))


def find_contents_url(doc: html.HtmlElement, base_url: str) -> str | None:
    for anchor in doc.xpath("//a"):
        text = clean(" ".join(anchor.xpath(".//text()")))
        href = anchor.get("href")
        if href and text.lower() == "contents":
            return urljoin(base_url, href)
    for anchor in doc.xpath("//a"):
        href = anchor.get("href")
        if href and href.rstrip("/").endswith("/toc"):
            return urljoin(base_url, href)
    return None


def find_pdf_download_url(page_url: str) -> str | None:
    request = Request(page_url, headers={"User-Agent": "Mozilla/5.0"})
    page = urlopen(request, timeout=30).read()
    if page.startswith(b"%PDF-"):
        return page_url
    doc = html.fromstring(page)
    for anchor in doc.xpath("//a"):
        text = clean(" ".join(anchor.xpath(".//text()"))).lower()
        href = anchor.get("href")
        if href and ("pdf" in text or "download" in text or "pdf" in href.lower() or "download" in href.lower()):
            return urljoin(page_url, href)
    return None


def count_pdf_pages(pdf_url: str) -> int:
    request = Request(pdf_url, headers={"User-Agent": "Mozilla/5.0"})
    data = urlopen(request, timeout=30).read()
    if not data.startswith(b"%PDF-"):
        raise ValueError(f"Not a PDF: {pdf_url}")
    return len(re.findall(rb"/Type\s*/Page\b", data))


def fetch(slug: str) -> dict:
    url = issue_url(slug)
    request = Request(url, headers={"User-Agent": "Mozilla/5.0"})
    page = urlopen(request, timeout=30).read()
    doc = html.fromstring(page)

    title = clean(" ".join(doc.xpath("//h1//text()")))
    published = clean(
        " ".join(
            doc.xpath(
                "//*[contains(concat(' ', normalize-space(@class), ' '), ' published ')]"
                "//*[contains(concat(' ', normalize-space(@class), ' '), ' value ')]//text()"
            )
        )
    )

    articles = []
    for article in doc.xpath(
        "//*[contains(concat(' ', normalize-space(@class), ' '), ' obj_article_summary ')]"
    ):
        article_title = clean(" ".join(article.xpath(".//h3[contains(@class, 'title')]/a//text()")))
        authors = clean(
            " ".join(
                article.xpath(
                    ".//*[contains(concat(' ', normalize-space(@class), ' '), ' block_announcements_article_content ')]//text()"
                )
            )
        )
        pages = clean(
            " ".join(
                article.xpath(
                    ".//*[contains(concat(' ', normalize-space(@class), ' '), ' pages ')]//text()"
                )
            )
        )
        if not article_title or not authors:
            continue
        article_title = article_title.replace("SiO 2", "SiO2").replace("TiO 2", "TiO2")
        start, end = parse_page_range(pages)
        articles.append(
            {
                "authors": authors,
                "title": article_title,
                "line": f"{authors} - {article_title}",
                "pages": pages,
                "start_page": start,
                "end_page": end,
            }
        )

    first_page = next((a["start_page"] for a in articles if a["start_page"] is not None), None)
    last_page = next((a["end_page"] for a in reversed(articles) if a["end_page"] is not None), None)
    article_pages = (last_page - first_page + 1) if first_page is not None and last_page is not None else None
    contents_url = find_contents_url(doc, url)
    contents_download_url = None
    contents_pages = None
    warnings = []
    if contents_url:
        try:
            contents_download_url = find_pdf_download_url(contents_url)
            if contents_download_url:
                contents_pages = count_pdf_pages(contents_download_url)
            else:
                warnings.append(f"Could not find PDF download URL from Contents page: {contents_url}")
        except Exception as exc:
            warnings.append(f"Could not count Contents PDF pages: {exc}")
    else:
        warnings.append("Could not find Contents link on issue page")
    contract_total_pages = (
        article_pages + contents_pages
        if article_pages is not None and contents_pages is not None
        else None
    )

    return {
        "slug": slug,
        "url": url,
        "title": title,
        "published": published,
        "article_count": len(articles),
        "first_article_page": first_page,
        "last_article_page": last_page,
        "article_page_span": article_pages,
        "contents_url": contents_url,
        "contents_download_url": contents_download_url,
        "contents_pages": contents_pages,
        "contract_total_pages": contract_total_pages,
        "warnings": warnings,
        "articles": articles,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description="Fetch VJST issue metadata and article list.")
    parser.add_argument("--slug", help="Issue slug, e.g. vol64n3")
    parser.add_argument("--volume", type=int, help="Volume number, e.g. 64")
    parser.add_argument("--number", type=int, help="Issue number, e.g. 3")
    parser.add_argument("--pretty", action="store_true", help="Pretty-print JSON")
    args = parser.parse_args()

    data = fetch(slug_from_args(args))
    print(json.dumps(data, ensure_ascii=False, indent=2 if args.pretty else None))


if __name__ == "__main__":
    main()
