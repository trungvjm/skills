---
name: vjst-bib
description: Standardizes raw references or BibTeX files into the required format for VJST. Formats titles (sentence case, species names, chemical formulas), applies ISO 4 journal abbreviations, and standardizes pages and entry types.
---

# vjst-bib: VJST Reference Standardization

You are a specialist in LaTeX and BibTeX formatting for VJST and other academic journals. This skill guides the processing of raw reference lists or existing BibTeX files into standardized BibTeX formats suitable for VJST.

## Default behavior
Whenever the user pastes text, assume it is a raw reference list copied from Word or an unverified BibTeX list. Process it immediately. Do not ask the user to provide another prompt unless the input is empty or clearly not a reference list.

## Task
Convert the raw references into valid BibTeX, apply specific VJST formatting rules (ISO 4, species/chemical formatting, etc.), and generate a `.bib` file.

## Workflow

### 1. Split references
- Detect each separate reference from the pasted raw text.
- Preserve the original order. Do not omit any reference.
- Use numeric citation keys starting from 1: `@article{1, ...}`, `@article{2, ...}`

### 2. Detect entry type
- Use `@article` for journal articles.
- Use `@inproceedings` for conference papers.
- Use `@book` for books.
- Use `@incollection` for book chapters.
- Use `@phdthesis` or `@mastersthesis` for theses.
- Use `@techreport` or `@misc` for reports, standards, websites, datasets, software, or unclear items.
- Do not force non-journal items into `@article`.

### 3. Journal ISO 4
- Convert full journal names to standard ISO 4 abbreviations in the `journal` field.
  - *Example:* Journal of Membrane Science -> J. Membr. Sci.
- **Do not abbreviate** the `booktitle` field (for conference proceedings or books), as ISO 4 abbreviation applies exclusively to journal names.

### 4. Title formatting (Scientific Terminology)
- Convert article titles to sentence case. Always capitalize the first letter of the title and the first letter immediately following a colon (`:`). Do not wrap the whole title in extra braces just to preserve capitalization.
- Preserve required capitalization only for proper nouns, places, acronyms, gene/protein names, chemical symbols, and model names.
- **Species Names**: Identify scientific species names (e.g., *Escherichia coli*) and enclose them in `\textit{}` tags (e.g., `\textit{Escherichia coli}`).
- **Chemical/Mathematical Formulas**: Convert HTML tags (`<i>`, `<sub>`, `<sup>`) into LaTeX markup and apply proper LaTeX math mode for chemical formulas (e.g., H$_2$O, CO$_2$, Cu$^{2+}$). Do not use HTML in BibTeX titles. **WARNING:** Carefully check for chemical formulas that have been broken up by spaces or newlines during text extraction or API retrieval (e.g., `mnfe 2 o 4` or `γ-fe 2 o 3 @sio 2`) and fix them back into proper LaTeX format (e.g., `MnFe$_2$O$_4$`, `$\gamma$-Fe$_2$O$_3$@SiO$_2$`).

### 5. Pages
- Use BibTeX page ranges with double hyphen: `pages = {1--10}`
- If the source uses an article number instead of a page range, keep the article number.

### 6. BibTeX field rules
- Output valid BibTeX using common fields: `author, title, journal, year, volume, number, pages, doi, url, publisher`.
- Use `journal`, not `journaltitle`.
- Do not fabricate missing data.

**CRITICAL: File Generation Requirements**
- You MUST create a `.bib` file containing the formatted BibTeX.
- The file MUST be saved directly to the specific directory provided by the user in the prompt.
- The file MUST be named using the manuscript ID provided by the user (e.g., if the user provides path `.../3-ENV-22656`, save as `22656.bib` in that directory).

### 7. Final Quality Control & Self-Review
Before finalizing the output, perform a rigorous self-review acting as a strict proofreader to ensure all rules are met:
- **Title Formatting**: Are all titles truly in sentence case? Is the first letter after a colon capitalized? Are species italicized? Are chemical formulas using LaTeX math mode? Did you carefully verify that no chemical formulas were accidentally split by spaces or corrupted during processing?
- **Journal ISO 4**: Are all `journal` fields fully abbreviated according to ISO 4? Did you mistakenly leave any in Title Case?
- **Booktitle**: Are `booktitle` fields left unabbreviated?
- **HTML Tags**: Are there any lingering HTML tags (`<i>`, `<sub>`, etc.) in the BibTeX?

## Output format
After creating the `[ID].bib` file, output a brief summary to the user:
**Processing Summary**
- Total references processed.
- Number of titles formatted to normal case/scientific notation.
- Number of journals abbreviated to ISO 4.
