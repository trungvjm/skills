---
name: vjst-contract-issue
description: Create or update Vietnam Journal of Science and Technology (VJST) issue contract paperwork and payment files from issue identifiers such as "Vol. 64 No. 3", "vol64n3", or "số 3"; use for generating the 5 DOCX professional-service contracts, the issue payment request XLSX, filling VJST article titles/authors from vjs.ac.vn, assigning contract numbers, applying VJST payment rules, and fixing DOCX/XLSX formatting for VJST contract issue folders.
---

# VJST Contract Issue

Use this skill when the user asks to make VJST contract paperwork for a journal issue. The normal output is a subfolder such as `VOL64N3` containing 5 DOCX contracts and a payment request XLSX.

## Core Paths

- Base folder: `G:\My Drive\VJST\02-Thanh toan\2026\02-Hop dong chuyen mon`
- Prefer the latest user-approved issue folder as the formatting template. As of this skill creation, the canonical finalized template set is `VOL64N3` in the base folder.
- Older root DOCX files are useful as content references, but they may not include the latest user formatting corrections.

## Issue Intake

When the user provides an issue such as `Vol. 64 No. 3`, parse:

- Volume: `64`
- Issue number: `3`
- Issue slug: `vol64n3`
- Output folder: `VOL64N3`
- Issue URL: `https://vjs.ac.vn/jst/issue/view/vol64n3`

Use `scripts/fetch_issue.py` to fetch published date, article titles/authors, article count, article page span, the web `Contents` PDF page count, and the calculated contract total page count. Verify the count against the user if it conflicts with their stated count.

Contract page count rule: total pages = article page span + pages in the issue `Contents` file on the web. For example, VJST Vol. 64 No. 3 has article pages 395-593 (199-page span) and the `Contents` PDF has 2 pages, so total pages = 201. If `scripts/fetch_issue.py` cannot fetch or count the `Contents` PDF, ask the user or verify manually before calculating money.

## Contract Set

Each issue has 5 contracts:

| Order | Work | Rate | Basis | Recipient |
|---|---:|---:|---|---|
| 1 | Soạn thảo, định dạng | 50.000 đ/trang | pages | Trần Ngọc Trung |
| 2 | Hiệu đính tiếng Anh | 70.000 đ/trang | pages | depends on issue number parity |
| 3 | Biên tập kỹ thuật | 30.000 đ/trang | pages | Trần Ngọc Trung |
| 4 | Đọc duyệt lần cuối | 45.000 đ/trang | pages | GS.TS. Thái Hoàng |
| 5 | Metadata | 600.000 đ/bài | article count | Trần Ngọc Trung |

Contract number pattern:

```text
start = 5 * (issue_number - 1) + 1
contracts = start..start+4
```

For No. 3, this is `11..15`. Format contract references as `Số 11-HĐ/TCKHCN` and `số 11-HĐ/TCKHCN`, not `Số: 11/HĐ-TCKHCN`.

## Recipient Rules

Read `references/payees.md` before generating or editing recipient information.

Critical rule for the English editing contract:

- Even issue numbers: `Ông GS.TSKH. Nguyễn Xuân Phúc`
- Odd issue numbers: `Ông TS. Trần Hồng Hà`

Apply the chosen English editor consistently in the contract body, liquidation/minutes, handover, payment workload table, report, and signature/name lines.

## Dates

Avoid Saturdays and Sundays for contract signing, handover, nghiệm thu, thanh lý, and payment dates.

Default date heuristic:

- Start date: first working day on or after day `02` of the first month in the issue period.
- End/liquidation date: published date from VJST, adjusted to the next working day if it falls on a weekend.

For VJST 2026 bi-monthly issues:

- No. 1: Jan-Feb
- No. 2: Mar-Apr
- No. 3: May-Jun
- No. 4: Jul-Aug
- No. 5: Sep-Oct
- No. 6: Nov-Dec

If the user gives explicit dates, still check weekend status and warn or adjust with a concrete date.

## DOCX Formatting Requirements

Use the latest approved DOCX files as templates and patch content carefully:

- Replace national header with `ĐẢNG CỘNG SẢN VIỆT NAM`.
- Remove `Độc lập - Tự do - Hạnh phúc`.
- Set `ĐẢNG CỘNG SẢN VIỆT NAM` to font size 13 (`w:sz=26`).
- Add or preserve a centered `*` below the journal heading block.
- Use Vietnamese money separators in DOCX text: `10.050.000`, not `10,050,000`.
- Keep the article list in the reports as `Author - Title`, one article per paragraph.
- Remove stale Word fields/symbols when replacing full paragraphs; leftover `w:sym` can render as ``.

When editing DOCX directly, update all `word/*.xml` parts that contain document text, then verify with XML extraction.

## Payment XLSX Requirements

Use the latest approved payment XLSX as the visual/layout template when possible.

For the payment request:

- Include contracts `start..start+4`.
- Use `contract_total_pages` from `scripts/fetch_issue.py` as `<pages>`.
- Keep `F16:F19` as the visible page count.
- Money formulas should use literal page/article counts, not `F` references:
  - `G16 = 50000*1*<pages>`
  - `G17 = 70000*1*<pages>`
  - `G18 = 30000*1*<pages>`
  - `G19 = 45000*1*<pages>`
  - `G20 = 600000*1*<article_count>`
  - `D22 = SUM(G16:G20)`
- Keep `B23` as fixed Vietnamese text, not a custom function, to avoid `#NAME?`.
- Remove `xl/calcChain.xml` and its relationships/content-type entries after XML edits.
- Preserve layout fixes: merge `B16:E20` by row, merge `B23:H23`, wrap text, and set enough row height for payment lines.

If the user wants Excel to calculate and show Vietnamese separators, leave money cells numeric/formula-based and tell them to set Excel separators: decimal `,`, thousands `.`.

## Validation Checklist

Before responding:

- Verify every output DOCX opens as a ZIP and has no stale issue strings, old contract numbers, old dates, or old payee names.
- Verify DOCX money text uses dots.
- Verify article count in reports matches VJST/user value.
- Verify `ĐẢNG CỘNG SẢN VIỆT NAM` appears in each header and old national/motto strings are gone.
- Verify payment XLSX formulas, cached values, layout merges, and absence of `calcChain`.
- If a target file is locked, write a clearly named fallback file and tell the user.
