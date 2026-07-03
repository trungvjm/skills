---
name: stce-create-final
description: Automates the process of converting LaTeX proof files into final publication files for the STCE journal. This includes renaming files based on the TOC, updating frontmatter (volume, year, DOI), and assigning continuous page numbers.
---

# stce-create-final

This skill converts a batch of accepted LaTeX papers (proofs) into their final publication versions for the STCE journal. It automates file renaming, frontmatter updates, and continuous pagination across the entire issue.

## Prerequisites
1. The user provides an ordered **Table of Contents (TOC)** or a list of paper IDs.
2. The user provides the **Volume** (`vol`), **Number** (`number`), and **Year** (`year`) of the issue.

> [!IMPORTANT]
> The LaTeX `\volume` command must be formatted strictly as `\volume{vol (number)}`. For example, if Volume is 20 and Number is 3, it must be updated to `\volume{20 (3)}`. The agent must ensure this formatting is applied correctly.

## Step 1: File Renaming
1. Identify all files in the current working directory (`04-Papers`) that match the paper IDs in the provided TOC.
2. Rename each main `.tex` file, `.pdf`, and all auxiliary files (e.g., `.aux`, `.log`, `.bbl`, etc.) by prefixing them with their 2-digit sequential order (`STT_`).
   - Example: The 1st paper `3551_Oleg Gorbunov.tex` becomes `01_3551_Oleg Gorbunov.tex`.
   - The 2nd paper `3421_Nguyen Trung Kien.tex` becomes `02_3421_Nguyen Trung Kien.tex`.
3. Ensure auxiliary files with suffixes like ` 2.pdf` or ` 3.pdf` are deleted or ignored before renaming.

## Step 2: LaTeX Update & Continuous Pagination
Use a Python script to iterate through the newly renamed `STT_*.tex` files sequentially. For each file, the script must:
1. **Update LaTeX parameters:**
   - Change `\usepackage{STCE/stce_proof}` to `\usepackage{STCE/stce}`.
   - Change `\input{STCE/stce_uncorrectedproof}` to `%\input{STCE/stce_uncorrectedproof}`.
   - Update `\volume{...}` to the provided volume and number, e.g., `\volume{20 (3)}`.
   - Update `\copyrightyear{...}` to the provided year, e.g., `\copyrightyear{2026}`.
   - Update `\doi{...}` to `\doi{https://doi.org/10.31814/stce.huce<year>-<vol>(<number>)-<STT>}`. Example: `\doi{https://doi.org/10.31814/stce.huce2026-20(3)-01}`.
2. **Assign `\firstpage`:**
   - The first paper (`01`) starts with `\firstpage{1}`.
   - For subsequent papers, `\firstpage` is calculated dynamically based on the total pages of the previous paper.
3. **Compile and extract pages:**
   - Run `pdflatex -interaction=nonstopmode <filename>.tex` twice to ensure references and page numbers are resolved.
   - Read the generated `<filename>.log` to extract the total number of pages using a regex like `Output written on .*? \((\d+) pages?, \d+ bytes\)\.`.
   - Add the total pages to the current `firstpage` to compute the `firstpage` for the next paper.
4. **Copy Output Files:**
   - After compiling all files, copy ONLY the final `.pdf` files that correspond to the numbered TOC items (i.e., those prefixed with `STT_`) from `04-Papers` to the `01-Prints` directory.
   - The `01-Prints` directory should be created at the same level as `04-Papers` if it does not already exist (i.e., `../01-Prints`).
5. **Cleanup:**
   - As per user global rules, ALWAYS delete the temporary Python script (`.py`) immediately after the task is successfully executed.

## Example Python Script (Template)
You can use and adapt the following Python template during execution. Remember to run this script using `python3` with **unsandboxed** permissions since `pdflatex` requires system access:

```python
import os, re, subprocess, shutil

vol = "20"
number = "3"
year = "2026"

prints_dir = "../01-Prints"
if not os.path.exists(prints_dir):
    os.makedirs(prints_dir)

files = sorted([f for f in os.listdir('.') if f.endswith('.tex') and re.match(r'^\d{2}_', f)])
current_first_page = 1

for f in files:
    stt = f[:2]
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Update Frontmatter
    content = re.sub(r'\\usepackage\{STCE/stce_proof\}', r'\\usepackage{STCE/stce}', content)
    content = re.sub(r'^(\\input\{STCE/stce_uncorrectedproof\})', r'%\1', content, flags=re.MULTILINE)
    content = re.sub(r'\\volume\{.*?\}', f'\\\\volume{{{vol} ({number})}}', content)
    content = re.sub(r'\\copyrightyear\{.*?\}', f'\\\\copyrightyear{{{year}}}', content)
    
    # DOI update
    doi_str = f'\\\\doi{{https://doi.org/10.31814/stce.huce{year}-{vol}({number})-{stt}}}'
    content = re.sub(r'\\doi\{.*?\}', doi_str, content)
    
    # Pagination
    content = re.sub(r'\\firstpage\{\d+\}', f'\\\\firstpage{{{current_first_page}}}', content)
    
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)
    
    print(f"[{stt}] Compiling {f} starting at page {current_first_page}...")
    subprocess.run(['pdflatex', '-interaction=nonstopmode', f], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(['pdflatex', '-interaction=nonstopmode', f], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    # Copy compiled PDF to 01-Prints
    pdf_file = f.replace('.tex', '.pdf')
    if os.path.exists(pdf_file):
        shutil.copy(pdf_file, os.path.join(prints_dir, pdf_file))
        
    log_file = f.replace('.tex', '.log')
    try:
        with open(log_file, 'r', encoding='latin-1') as lf:
            match = re.search(r'Output written on .*? \((\d+) pages?, \d+ bytes\)\.', lf.read())
            if match:
                pages = int(match.group(1))
                current_first_page += pages
            else:
                print(f"[{stt}] Warning: Page count not found in log.")
    except Exception as e:
        print(f"[{stt}] Error reading log: {e}")
```
