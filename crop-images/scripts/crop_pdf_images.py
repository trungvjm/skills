#!/usr/bin/env python3
"""Render PDF pages and crop figure bounding boxes."""

from __future__ import annotations

import argparse
import csv
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

try:
    from PIL import Image, ImageDraw
except ImportError:  # pragma: no cover - exercised only on missing dependency
    Image = None
    ImageDraw = None


def run(cmd: list[str]) -> None:
    subprocess.run(cmd, check=True)


def need_tool(name: str) -> str:
    path = shutil.which(name)
    if not path:
        raise SystemExit(f"missing required tool: {name}")
    return path


def page_path(work_dir: Path, page: int) -> Path:
    for candidate in (
        work_dir / f"page-{page:02d}.png",
        work_dir / f"page-{page:03d}.png",
        work_dir / f"page-{page}.png",
    ):
        if candidate.exists():
            return candidate
    raise FileNotFoundError(f"rendered page not found for page {page}")


def render_pdf(pdf: Path, work_dir: Path, dpi: int) -> list[Path]:
    need_tool("pdftoppm")
    work_dir.mkdir(parents=True, exist_ok=True)
    run(["pdftoppm", "-r", str(dpi), "-png", str(pdf), str(work_dir / "page")])
    pages = sorted(work_dir.glob("page-*.png"))
    if not pages:
        raise SystemExit("pdftoppm produced no page PNGs")
    return pages


def make_contact_sheet(images: list[Path], out_path: Path, thumb: str = "420x") -> bool:
    magick = shutil.which("magick")
    if not magick or not images:
        return False
    out_path.parent.mkdir(parents=True, exist_ok=True)
    run([
        magick,
        "montage",
        *map(str, images),
        "-thumbnail",
        thumb,
        "-label",
        "%f",
        "-tile",
        "2x",
        "-geometry",
        "+12+34",
        str(out_path),
    ])
    return True


def load_boxes(path: Path) -> list[dict]:
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, list):
        raise SystemExit("bbox JSON must be a list")
    for item in data:
        if "page" not in item or "bbox" not in item:
            raise SystemExit("each bbox item needs page and bbox")
        if len(item["bbox"]) != 4:
            raise SystemExit("bbox must have four values")
    return data


def crop_boxes(work_dir: Path, out_dir: Path, boxes: list[dict], dpi: int) -> list[dict]:
    if Image is None or ImageDraw is None:
        raise SystemExit("missing Pillow; install it or use the Codex bundled Python runtime")

    out_dir.mkdir(parents=True, exist_ok=True)
    rows: list[dict] = []

    for idx, item in enumerate(boxes, start=1):
        name = item.get("name") or item.get("short_name") or f"F{idx}"
        page = int(item["page"])
        bbox = [int(v) for v in item["bbox"]]
        source = page_path(work_dir, page)
        image = Image.open(source).convert("RGB")
        width, height = image.size
        x0, y0, x1, y1 = bbox
        x0 = max(0, min(x0, width))
        x1 = max(0, min(x1, width))
        y0 = max(0, min(y0, height))
        y1 = max(0, min(y1, height))
        if x1 <= x0 or y1 <= y0:
            raise SystemExit(f"invalid bbox for {name}: {bbox}")

        crop_file = f"{name}.png"
        image.crop((x0, y0, x1, y1)).save(out_dir / crop_file)
        rows.append({
            "short_name": name,
            "page": page,
            "dpi": dpi,
            "page_image": source.name,
            "page_width": width,
            "page_height": height,
            "bbox": [x0, y0, x1, y1],
            "crop_file": crop_file,
            "caption": item.get("caption", ""),
        })

    return rows


def write_manifests(out_dir: Path, rows: list[dict]) -> None:
    fields = [
        "short_name",
        "page",
        "dpi",
        "page_image",
        "page_width",
        "page_height",
        "bbox",
        "crop_file",
        "caption",
    ]
    with (out_dir / "figures_manifest.csv").open("w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(fh, fieldnames=fields)
        writer.writeheader()
        for row in rows:
            out = row.copy()
            out["bbox"] = ",".join(map(str, row["bbox"]))
            writer.writerow(out)

    (out_dir / "figures_manifest.json").write_text(
        json.dumps(rows, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


def annotate_pages(work_dir: Path, out_dir: Path, rows: list[dict]) -> None:
    if Image is None or ImageDraw is None:
        return
    for page in sorted({int(row["page"]) for row in rows}):
        image = Image.open(page_path(work_dir, page)).convert("RGB")
        draw = ImageDraw.Draw(image)
        for row in [r for r in rows if int(r["page"]) == page]:
            x0, y0, x1, y1 = row["bbox"]
            draw.rectangle((x0, y0, x1, y1), outline=(220, 0, 0), width=8)
            draw.text((x0 + 12, max(0, y0 - 42)), row["short_name"], fill=(220, 0, 0))
        image.save(out_dir / f"annotated_page-{page:02d}.png")


def self_check() -> None:
    if Image is None:
        raise SystemExit("missing Pillow")
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        work_dir = root / "pages"
        out_dir = root / "out"
        work_dir.mkdir()
        Image.new("RGB", (100, 80), "white").save(work_dir / "page-01.png")
        rows = crop_boxes(
            work_dir,
            out_dir,
            [{"name": "F1", "page": 1, "bbox": [10, 20, 50, 70], "caption": "demo"}],
            300,
        )
        write_manifests(out_dir, rows)
        assert (out_dir / "F1.png").exists()
        assert Image.open(out_dir / "F1.png").size == (40, 50)
        assert (out_dir / "figures_manifest.csv").exists()
    print("self-check OK")


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pdf", nargs="?", type=Path)
    parser.add_argument("--dpi", type=int, default=300)
    parser.add_argument("--work-dir", type=Path, default=Path("work/pages"))
    parser.add_argument("--out-dir", type=Path, default=Path("outputs/crops"))
    parser.add_argument("--bbox-json", type=Path)
    parser.add_argument("--render-only", action="store_true")
    parser.add_argument("--self-check", action="store_true")
    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    args = parse_args(argv)
    if args.self_check:
        self_check()
        return 0
    if not args.pdf:
        raise SystemExit("pdf path is required unless --self-check is used")
    if not args.pdf.exists():
        raise SystemExit(f"PDF not found: {args.pdf}")

    pages = render_pdf(args.pdf, args.work_dir, args.dpi)
    make_contact_sheet(pages, args.out_dir / "pages_contact_sheet.png")
    if args.render_only or not args.bbox_json:
        print(f"rendered {len(pages)} pages to {args.work_dir}")
        print(f"page contact sheet: {args.out_dir / 'pages_contact_sheet.png'}")
        return 0

    boxes = load_boxes(args.bbox_json)
    rows = crop_boxes(args.work_dir, args.out_dir, boxes, args.dpi)
    write_manifests(args.out_dir, rows)
    annotate_pages(args.work_dir, args.out_dir, rows)
    make_contact_sheet([args.out_dir / row["crop_file"] for row in rows], args.out_dir / "crops_contact_sheet.png")
    print(f"cropped {len(rows)} images to {args.out_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
