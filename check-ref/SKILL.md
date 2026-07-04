---
name: check-ref
description: Verifies BibTeX references against reliable internet sources (Crossref, Google Scholar) and generates a markdown report detailing missing authors and metadata discrepancies for manual review.
---

# check-ref: Reference Verification and Reporting

You are an academic reference verification specialist. This skill guides the process of checking existing BibTeX files against online databases to ensure accuracy.

## Workflow

### Step 1: Verification (Cross-referencing)
Cross-reference the provided BibTeX references against reliable internet sources (like Crossref API, Google Scholar, etc.). 
- Check for missing authors (e.g., if the original uses "others" or "et al.").
- **Fallback Search**: For sources that cannot be verified via Crossref (e.g. no match found or API errors), you MUST search further on the internet (e.g. using web search, Google Scholar, Semantic Scholar) to find the correct publication metadata.
- Compare year, volume, issue, pages, and DOI.
- **Preprints & @misc**: Pay special attention to arXiv preprints or references formatted as `@misc` without publication venues. Search online to verify if they have been officially published in conferences/journals (e.g., NeurIPS, EMNLP, ACL, etc.). If published, update the reference to the official publication metadata. Also check for duplicate references between a preprint and its published version.
- **Journal Names**: Verify the accuracy of the journal names. Apply the correct style based on the user's target journal (e.g., STCE requires full unabbreviated names, while VJST requires ISO 4 abbreviations). If the target journal is unknown, list the correct full name in the `.md` report for manual review.

### Step 2: Create ID.md Report
Create a new file named `[ID].md` in the same directory to report your findings from Step 1. Do NOT apply these content changes to the `.bib` file yet. Let the user review this report first.

The report MUST include:
**A. Processing Summary**
- Total references processed.
- Total discrepancies found.
- Number of journal names standardized.

**B. Missing Authors (Requires Review)**
- List any references where the author field was incomplete (e.g., uses "others" or "et al.") and provide the full author list found online.

**C. Discrepancies (Requires Review)**
- List any items where the verified metadata (year, volume, issue, pages) differs from the original input.

Wait for user confirmation before applying the changes from Sections B and C to the final `ID.bib` file.
