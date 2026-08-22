---
name: check-ref
description: Verifies BibTeX references against reliable internet sources (Crossref, Google Scholar) and generates a markdown report detailing missing authors and metadata discrepancies for manual review.
---

# check-ref: Reference Verification and Reporting

You are an academic reference verification specialist. This skill guides the process of checking existing BibTeX files against online databases to ensure accuracy.

## Workflow

### 0. Core Principle: NO GUESSING
- **CRITICAL**: You MUST NOT guess or hallucinate any information. When cross-referencing, if a matching result is highly questionable or fuzzy (e.g., completely different DOI, unrelated title), do NOT blindly accept and replace the original data. You must report discrepancies and wait for user approval.

### Step 1: Verification (Cross-referencing)
**CRITICAL WORKFLOW**: You must perform verification in two distinct stages:
1. **Google Scholar Verification (For ALL references)**: First, you MUST cross-check the information for ALL provided references (e.g. using the `search_web` tool targeting Google Scholar). Verify the title, authors, year, and venue match what Google Scholar reports.
2. **Crossref Verification (For references with DOIs)**: After verifying with Google Scholar, you MUST then cross-check against the Crossref API ONLY for the articles that have a valid DOI.
  - **CRITICAL - DOI Sources**: Not all DOIs are registered on Crossref (e.g., arXiv DOIs starting with `10.48550/arXiv...` belong to DataCite). If Crossref fails to find a DOI or returns a completely mismatched title (fuzzy match error), do NOT blindly accept it. You MUST verify the DOI via other sources like DataCite API, `dx.doi.org`, or Google Scholar.

During these checks, pay attention to the following:
- Check for missing authors (e.g., if the original uses "others" or "et al.").
- Compare year, volume, issue, pages, and DOI.
- **Technical Requirement for Scripts**: If you write a Python script to query the Crossref API, do NOT use Python's default `urllib` library, as it often fails with HTTP/2 (Cloudflare) errors (e.g. `BadStatusLine: HTTP/2.0`). Instead, you MUST use `curl` via `subprocess.run` to execute the API calls safely.
- **Preprints & @misc**: Pay special attention to arXiv preprints, Research Square, or references formatted as `@misc` without publication venues.
  - **CRITICAL**: For preprints, you MUST explicitly check the Crossref metadata for the `relation.is-preprint-of` field. If this field exists, it points to the official published DOI. You must fetch the metadata for that published DOI and use it instead.
  - Search online to verify if they have been officially published in conferences/journals if the `relation` field is missing. Also check for duplicate references between a preprint and its published version.
- **Journal Names**: Verify the accuracy of the journal names. Apply the correct style based on the user's target journal (e.g., STCE requires full unabbreviated names, while VJST requires ISO 4 abbreviations). If the target journal is unknown, list the correct full name in the `.md` report for manual review.

### Step 2: Create ID.md Report
Create a new file named `[ID].md` in the same directory to report your findings from Step 1. Do NOT apply these content changes to the `.bib` file yet. Let the user review this report first.

The report MUST be a single ordered list, following the exact reference order `[1]`, `[2]`, `[3]`, etc. Do NOT group findings into separate sections by problem type.

For every reference, write one item containing:
- A clear status: **Đã đầy đủ**, **Cần kiểm tra**, **Thiếu [field]**, **Sai khác [field]**, or **Chưa xác minh được**.
- The specific fields checked: title, authors, year, venue, volume, issue, pages, DOI/URL, edition, or publisher, as applicable.
- The exact discrepancy or missing data. Never guess a correction. If an online result is truncated, fuzzy, or refers to another edition/version, state that explicitly and do not replace the original metadata.
- A source label identifying what verified the item: **Google Scholar**, **Crossref**, **DataCite**, **DOI resolver**, publisher/official source, or a combination. If a source was unavailable or blocked by CAPTCHA, say so.

Use concise wording, for example:

`[1] Đã đầy đủ. Title, authors, year, venue and DOI match. Nguồn: Google Scholar + Crossref.`

`[2] Thiếu 1 tác giả: online source lists ...; original lists .... Nguồn: Google Scholar + Crossref. Chờ approval.`

`[3] Chưa xác minh được. Google Scholar returned no result/CAPTCHA; no DOI for Crossref.`

The ordered list must cover **all** references, including references with no discrepancy. At the end, add only one short status line stating that the `.bib` file has not been changed and that approval is required before applying discrepancies or missing-author findings.
