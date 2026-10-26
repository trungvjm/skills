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

### Rule Registry
Read [RULES.md](RULES.md) for the complete list of rule IDs (`STCE-BIB-*`) and verification methods.

### Step 1: Format and Create ID.bib (Formatting ONLY)
Create a new file named `[ID].bib` in the `Bib` directory. Apply ONLY the following formatting rules (`STCE-BIB-CORE-001`: **Do NOT modify the content/metadata** like fixing a wrong year or adding missing authors).

- **Split and Number (`STCE-BIB-KEY-001`)**: Detect each separate reference. Preserve the original order. Use numeric citation keys starting from 1: `@article{1, ...}`, `@article{2, ...}`
- **Title Casing (`STCE-BIB-TXT-001`)**: The `title` field must be formatted in "normal case" (sentence case), meaning only the first letter of the title, the first letter after a colon, and proper nouns/acronyms are capitalized. Italicized terms (like species names) must use `\textit{}`.
- **Author Spacing (`STCE-BIB-AUTH-001`)**: Ensure author initials have a space after each period. For example, change `Asmone, A.S.` to `Asmone, A. S.`
- **Vietnamese "Đ" (`STCE-BIB-AUTH-002`)**: If an author's name contains the symbol `Đ` or `đ`, convert it to `{\DJ}` or `{\dj}` ONLY in the `author` field.
- **Vietnamese Unicode (`STCE-BIB-TXT-002`)**: For documents in Vietnamese, preserve the original Vietnamese Unicode font and formatting for all other fields.

- **Entry Type Conversions**:
  - `@article` (`STCE-BIB-TYPE-001`): remains unchanged. Prioritize the `doi` field if available.
  - `@book` and `@inproceedings` / `@inproceeding` (`STCE-BIB-TYPE-002`): remain unchanged in entry type. However, if a `doi` field is present, it MUST be converted into a `url` field (e.g., convert `doi = {10.1007/123}` to `url = {https://doi.org/10.1007/123}`) and the original `doi` field should be removed.
  - `@techreport` (`STCE-BIB-TYPE-003`): change to `@manual`. Keep `author`, `title`, `year`, and `url` (if present) unchanged. Put all other remaining information into the `address` field.
  - `@incollection` (`STCE-BIB-TYPE-004`): change to `@inproceedings` (`@inproceeding`).
  - `@misc` (`STCE-BIB-TYPE-005`): change to `@manual`.
  - **Standards in Civil Engineering (`STCE-BIB-STD-001`, `STCE-BIB-STD-002`)**:
    - Convert standard documents to `@manual`. Put the series code (e.g., `BS EN 1052-1:1999`, `TCVN 14334:2025`, `ASTM C618-12`) into the `note` field (`STCE-BIB-STD-001`).
    - **Year removal when `note` contains the year (`STCE-BIB-STD-002`)**: If the standard code in `note` already includes the publication year (e.g., `:2025`, `:1999`, `-12`, `-21`), **MUST omit the `year` field** so `STCE/stce.bst` does not print the year twice (e.g., avoiding `TCVN 14334:2025 (2025).`). Only keep `year` if `note` does not contain a year.
    - Keep `title` and `url` (if present) unchanged; put all other remaining information (issuing organization, location) into the `address` field.

**CRITICAL: Self-Correction Check**
Before finishing, you MUST double-check your generated `[ID].bib` file against ALL `STCE-BIB-*` rules above (especially `STCE-BIB-TXT-001` sentence case, `STCE-BIB-AUTH-001` initial spacing, `STCE-BIB-TYPE-002` DOI-to-URL conversion for books/proceedings, and `STCE-BIB-STD-002` omitting `year` when `note` already contains the year).
