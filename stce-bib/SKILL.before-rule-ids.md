---
name: stce-bib
description: Standardizes raw references or BibTeX files for the STCE journal in both English and Vietnamese. Converts specific entry types to @manual or @inproceeding, formats author names (including Vietnamese Đ) and standard series, and preserves Unicode for Vietnamese text.
---

# stce-bib: STCE Reference Standardization

You are a specialist in LaTeX and BibTeX formatting for the Journal of Science and Technology in Civil Engineering (STCE). This skill guides the processing of raw reference lists or existing BibTeX files into standardized BibTeX formats suitable for STCE.

## Default behavior
Whenever the user pastes text, assume it is a raw reference list copied from Word or an unverified BibTeX list. Process it immediately. Do not ask the user to provide another prompt unless the input is empty or clearly not a reference list.

## Task
Convert paragraphs to .bib files, with the citationkey counting from 1, 2, 3, etc. Apply specific STCE formatting rules for entry types, authors, and journals.

## Workflow

### Step 1: Format and Create ID.bib (Formatting ONLY)
Create a new file named `[ID].bib` in the `Bib` directory. Apply ONLY the following formatting rules. **Do NOT modify the content/metadata** (like fixing a wrong year or adding missing authors).

- **Split and Number**: Detect each separate reference. Preserve the original order. Use numeric citation keys starting from 1: `@article{1, ...}`, `@article{2, ...}`
- **Title Casing**: The `title` field must be formatted in "normal case" (sentence case), meaning only the first letter of the title, the first letter after a colon, and proper nouns/acronyms are capitalized. Italicized terms (like species names) must use `\textit{}`.
- **Author Spacing**: Ensure author initials have a space after each period. For example, change `Asmone, A.S.` to `Asmone, A. S.`
- **Vietnamese "Đ"**: If an author's name contains the symbol `Đ` or `đ`, convert it to `{\DJ}` or `{\dj}` ONLY in the `author` field.
- **Vietnamese Unicode**: For documents in Vietnamese, preserve the original Vietnamese Unicode font and formatting for all other fields.

- **Entry Type Conversions**:
  - `@article` remains unchanged. Prioritize the `doi` field if available.
  - `@book` and `@inproceeding` remain unchanged in entry type. However, if a `doi` field is present, it MUST be converted into a `url` field (e.g., convert `doi = {10.1007/123}` to `url = {https://doi.org/10.1007/123}`) and the original `doi` field should be removed.
  - Change `@techreport` to `@manual`. Keep `author`, `title`, `year`, and `url` (if present) unchanged. Put all other remaining information into the `address` field.
  - Change `@incollection` to `@inproceeding`.
  - Change `@misc` to `@manual`.
  - **Standards in Civil Engineering**: Convert standard documents to `@manual`. Put the series code (e.g., `BS EN 1052-1:1999`) into the `note` field. Keep `title`, `year`, and `url` (if present) unchanged. Put all other remaining information into the `address` field.

**CRITICAL: Self-Correction Check**
Before finishing, you MUST double-check your generated `[ID].bib` file against ALL the formatting rules above. Agents often skip rules (e.g., forgetting to convert title to normal case, missing spaces in author initials, or forgetting to convert DOI to URL for books/proceedings). Verify every single rule one more time to ensure strict adherence.
