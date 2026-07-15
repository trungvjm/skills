---
name: latex-vjmech
description: Chuẩn hóa file LaTeX theo template VJMech (Vietnam Journal of Mechanics / Tạp chí Cơ học Việt Nam)
---

# LaTeX-VJMech Skill

Skill chuẩn hóa file LaTeX theo đúng template của tạp chí **Vietnam Journal of Mechanics** (Tạp chí Cơ học, Viện Hàn lâm KHCN Việt Nam — VAST).

Template chuẩn được lấy từ file `VJMech_23920.tex`.

---

> [!CAUTION]
> ## ⚠️ QUY TẮC TỐI THƯỢNG — SUPREME RULE ⚠️
>
> **TUYỆT ĐỐI KHÔNG ĐƯỢC THAY ĐỔI NỘI DUNG GỐC.**
>
> Quy tắc này có **hiệu lực cao nhất**, vượt trên mọi quy tắc khác.
>
> **KHÔNG BAO GIỜ** được thay đổi:
> - **Giá trị số** trong phương trình, bảng biểu (ví dụ: E₁₁=134, ν₁₂=0.3, ...)
> - **Ký hiệu toán học** (ví dụ: E₁₁ ≠ E₁, G₃₄ ≠ G₁₂, subscript _e, _m, ...)
> - **Công thức và phương trình** (không rút gọn, không đơn giản hóa, không thay đổi biến)
> - **Nội dung text** (không viết lại câu, không thay từ, không thêm/bớt ý)
> - **Cấu trúc nội dung** (không thay đổi thứ tự, không gộp/tách đoạn)
> - **Caption hình/bảng** (giữ nguyên nội dung, chỉ format LaTeX)
>
> **CHỈ ĐƯỢC** thay đổi **FORMAT LaTeX** (template, citation style, spacing, commands).
>
> **KHÔNG ĐƯỢC SUY DIỄN.** Khi thấy nội dung gốc có vẻ không hợp lý (ký hiệu lạ, giá trị khác thường, công thức thiếu, ký hiệu bị mất do copy-paste) → **PHẢI BÁO CÁO LẠI USER**, không tự ý sửa, không tự ý thay thế bằng giá trị khác.
>
> Nếu không chắc chắn → **HỎI USER**, không tự suy diễn.

---

## 0. Quy tắc bắt buộc trước khi chuẩn hóa

> [!CAUTION]
> **PHẢI tạo bản sao file gốc trước khi sửa trực tiếp.**

- **Trước khi** bắt đầu chuẩn hóa bất kỳ file `.tex` hoặc `.bib` nào, **LUÔN** copy file gốc thành bản sao lưu:
  ```
  copy "VJMech_XXXXX.tex" "VJMech_XXXXX_original.tex"
  copy "XXXXX.bib" "XXXXX_original.bib"
  ```
- Mục đích: để sau khi chuẩn hóa xong có dữ liệu gốc **đối chiếu chéo**, đảm bảo chỉ thay đổi format mà **không xóa/thay đổi nội dung gốc**
- **KHÔNG BAO GIỜ** sửa trực tiếp mà không tạo backup trước
- Chỉ xóa file backup sau khi user xác nhận đã kiểm tra xong

> [!CAUTION]
> **Chỉ chuẩn hóa FORMAT — KHÔNG thay đổi NỘI DUNG gốc**

**Nguyên tắc cốt lõi:** Nội dung text phải giữ nguyên 100% so với bản gốc. Chỉ được thay đổi cách trình bày LaTeX (formatting, spacing, commands).

**ĐƯỢC PHÉP:**
- Đổi `\cite{...}` → `\parencite{...}` hoặc `\textcite{...}` (format citation)
- Đổi `Figure 1` → `Fig.~\ref{f1}` (format reference)
- Đổi raw text heading → `\section{...}` (format heading)
- Đổi raw table → `\begin{table}...\end{table}` (format table)
- Thêm `~` trước `\parencite`, `\ref` (spacing rules)
- Đổi raw equation → `\begin{equation}` (format equation)

**NGHIÊM CẤM:**
- **KHÔNG** rút gọn/đơn giản hóa header bảng (giữ nguyên tên cột gốc)
- **KHÔNG** tự bổ sung nội dung thiếu (nếu gốc để trống/thiếu → giữ nguyên hoặc hỏi user)
- **KHÔNG** thay đổi giá trị dữ liệu trong bảng
- **KHÔNG** thay đổi thứ tự hoặc cấu trúc nội dung
- Nếu phát hiện lỗi nội dung trong bản gốc → **báo user**, KHÔNG tự ý sửa

---

## 1. Cấu trúc tổng thể của file `.tex`

Một file `.tex` đúng chuẩn VJMech phải có cấu trúc sau theo đúng thứ tự:

```latex
\documentclass[11pt]{vjmech_ol}
% !TeX program = pdflatex
% !BIB program = biber

% --- 1. FONTS & SYMBOLS ---
\usepackage[mathscr]{eucal}
\usepackage{upgreek, textgreek}
\usepackage{stmaryrd}

% --- 2. MATH & SCIENCE ---
\usepackage{amsmath, amssymb, amsxtra, latexsym, amscd}
\usepackage{bm}
\usepackage{cases}
\usepackage{siunitx}
\usepackage{mhchem}
\everymath{\displaystyle}
\newcommand{\dif}{\mathrm{d}}

% --- 3. GRAPHICS & FIGURES ---
\usepackage{graphicx}
\usepackage[centerlast]{subfigure}
\usepackage[justification=centerlast]{caption}
\usepackage{wrapfig}
\usepackage{float}
\usepackage{pict2e}
\usepackage{tikz}

% --- 4. TABLES ---
\usepackage{booktabs}
\usepackage{multirow}
\usepackage{makecell}
\usepackage{tabularx}
\usepackage{diagbox}
\usepackage{ctable}

% --- 5. COLORS & HIGHLIGHTS ---
\usepackage[table]{xcolor}
\usepackage[final]{changes}
\setdeletedmarkup{\color{red}\sout{#1}}
\setaddedmarkup{\color{teal}#1}

% --- 6. UTILITIES & LAYOUT ---
\usepackage{multicol}
\usepackage[left]{lineno}
\usepackage{listings}
\usepackage{accsupp}
\usepackage{microtype}

% --- 7. BIBLIOGRAPHY ---
\usepackage[style=apa,backend=biber,maxcitenames=2,mincitenames=1]{biblatex}
\addbibresource{XXXXX.bib}
\setlength{\bibhang}{.8cm}

% --- 8. HYPERLINKS (Load last) ---
\usepackage{url}
\usepackage[colorlinks=true,linkcolor=blue,citecolor=blue,urlcolor=blue]{hyperref}

% --- 9. ORCID (Load after hyperref) ---
\usepackage{orcidlink}

% --- MACROS & DEFINITIONS ---
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{remark}{Remark}
\newtheorem{proposition}{Proposition}

\def\bm#1{\mbox{\boldmath{$#1$}}}
\def\rr#1{(\ref{#1})}
\def\p#1{\phantom{#1}}
\def\id#1{}
\def\orcid#1{\scriptsize\orcidlink{#1}}  % BẮT BUỘC - luôn phải có dù tác giả chưa cung cấp ORCID
\long\def\rrr#1#2#3{\multirow{#1}{*}{\makecell[#2]{#3}}}
\long\def\lll#1#2{\multicolumn{#1}{c}{\makecell[c]{#2}}}

\urlstyle{sf}
\raggedbottom

\begin{document}
\Volume{VV}\Number{N}\Year{YYYY}
\Page{PP}\Endpage{EE}
\ID{XXXXX}
\Title{Tiêu đề bài báo}
\author{...}
\maketitle
\markboth{...}{...}

\begin{abstract}
  ... (nội dung abstract)
  \keyword{...}
\end{abstract}

  ... (nội dung bài báo: sections)

\section*{DECLARATION OF COMPETING INTEREST}
\section*{CREDIT AUTHOR STATEMENT}
\section*{ACKNOWLEDGEMENT}

\defbibheading{finalbib}{\section*{REFERENCES}}
\printbibliography[heading=finalbib]

\end{document}
```

---

## 2. Preamble — Document class & Packages

### 2.1. Document class
```latex
\documentclass[11pt]{vjmech_ol}
```
- Dùng class `vjmech_ol` (online/proof version) hoặc `vjmech` (final version)
- Option: `11pt`

### 2.2. Packages
- Các packages được chia theo nhóm chức năng, đánh số từ 1–9 (xem mục 1)
- **THỨ TỰ BẮT BUỘC**: hyperref phải load GẦN CUỐI, orcidlink phải load SAU hyperref
- Khi chuẩn hóa, **GIỮ NGUYÊN** danh sách packages chuẩn, chỉ thêm/bớt nếu bài thực sự cần

### 2.3. Bibliography setup
```latex
\usepackage[style=apa,backend=biber,maxcitenames=2,mincitenames=1]{biblatex}
\addbibresource{XXXXX.bib}
\setlength{\bibhang}{.8cm}
```
- **LUÔN** dùng `biblatex` với style `apa` và backend `biber`
- File `.bib` đặt cùng thư mục, tên trùng mã bài (ví dụ: `23920.bib`)
- **KHÔNG** dùng `\bibliographystyle` + `\bibliography` (đó là BibTeX cũ)

### 2.4. Macros chuẩn
```latex
\def\id#1{}                    % macro ID bài báo (dùng trong đường dẫn figures)
\def\orcid#1{\scriptsize\orcidlink{#1}}
\long\def\rrr#1#2#3{\multirow{#1}{*}{\makecell[#2]{#3}}}
\long\def\lll#1#2{\multicolumn{#1}{c}{\makecell[c]{#2}}}
```

---

## 3. Document Header — Volume, Page, ID

```latex
\Volume{48}\Number{1}\Year{2026}
\Page{1}\Endpage{13}
\ID{23920}
```
- `\Volume`, `\Number`, `\Year`: thông tin tập/số/năm
- `\Page`, `\Endpage`: trang bắt đầu và kết thúc
- `\ID`: mã bài báo (cũng dùng làm `\id` trong đường dẫn figures)

---

## 4. Title & Author Block

### 4.1. Title
```latex
\Title{Dynamic instability of a double curved shallow sandwich electromagnetic shell with\\ a three-phase nanocomposite core
}
```
- Dùng `\Title{...}` (chữ T hoa) — KHÔNG phải `\title{...}`
- **Sentence case (Normal case)**: Tiêu đề viết chữ thường, chỉ viết hoa chữ cái đầu câu và các từ bắt buộc viết hoa (tên riêng, viết tắt, ký hiệu, v.v.). Ví dụ: `Dynamic instability of a double curved shallow sandwich electromagnetic shell...`
- Dòng xuống trong tiêu đề: dùng `\\`

### 4.2. Authors & Affiliations
```latex
\author{\textbf{Tên TC$ ^{1} $, Tên TC$ ^{\orcid{XXXX-XXXX-XXXX-XXXX}2,*} $, ...}\\
\small
\(^1\)\textit{Tên đơn vị 1, Quốc gia}\\
\(^2\)\textit{Tên đơn vị 2, Quốc gia}\\
\Email{email@domain}\\
\vspace*{3mm}\\\fontsize{9}{11} \selectfont
Received: DD Month YYYY
/ Revised: DD Month YYYY
/ Accepted: DD Month YYYY\\
Published online: DD Month YYYY
\vspace*{-5mm}
}
```

**Quy tắc chi tiết:**
- Tất cả tác giả nằm trong **MỘT** `\author{...}` block duy nhất
- Tên tác giả in đậm bằng `\textbf{...}`
- Số thứ tự affiliation: `$ ^{1} $`, `$ ^{2,3} $`, ...
- Tác giả liên hệ (corresponding): thêm `$ ^{*} $` và hiển thị ORCID bằng `$ ^{\orcid{XXXX-XXXX-XXXX-XXXX}} $`
- Địa chỉ đơn vị: `\(^N\)\textit{Tên đơn vị, Quốc gia}\\`
- Email: `\Email{email@domain}`
- Received dates: format `DD Month YYYY`, phân cách bằng ` / `
- Published online đứng riêng 1 dòng

### 4.3. Maketitle & Markboth
```latex
\maketitle

\markboth{Tên TC1, Tên TC2, Tên TC3}{Tiêu đề ngắn \ldots}
```
- `\maketitle` bắt buộc ngay sau `\author{...}`
- `\markboth{Danh sách tác giả}{Tiêu đề rút gọn}` — dùng cho header trang chẵn/lẻ
- Tiêu đề rút gọn nếu dài: kết thúc bằng `\ldots`

---

## 5. Abstract & Keywords

```latex
\begin{abstract}
Nội dung abstract viết liền 1 paragraph, không ngắt dòng.

\keyword{keyword1, keyword2, keyword3, keyword4}
\end{abstract}
```
- Abstract viết liền 1 đoạn
- `\keyword{...}` nằm **BÊN TRONG** `\begin{abstract}...\end{abstract}`
- Keywords phân cách bằng dấu `,` (phẩy) — **KHÔNG** dùng `;` (chấm phẩy)
- **Sentence case (Normal case)**: Keywords viết chữ thường, chỉ viết hoa các từ bắt buộc (tên riêng, viết tắt, ký hiệu). Ví dụ: `physics informed neural network, plane stress`
- **KHÔNG** có `\CR` hay `\begin{keyword}...\end{keyword}` riêng biệt

---

## 6. Nội dung bài báo — Sections

### 6.1. Hierarchy
```
\section{INTRODUCTION}          % Mục lớn: 1., 2., 3.
  \subsection{Tên mục con}      % Mục con: 2.1., 2.2.
    \subsubsection{Tên mục sâu} % Mục con con
```

### 6.2. Tên section viết HOA
- **LUÔN** viết HOA tiêu đề `\section`: `INTRODUCTION`, `BASIC EQUATIONS`, `COMPARISON STUDIES`, `NUMERICAL RESULT AND DISCUSSION`, `CONCLUSIONS`
- `\subsection` và `\subsubsection`: viết bình thường (Title Case hoặc Sentence case)

### 6.3. Sections đặc biệt (không đánh số)

```latex
\section*{DECLARATION OF COMPETING INTEREST}
Viết theo mẫu sau:
"The authors declare that they have no known competing financial interests or personal relationships that could have appeared to influence the work reported in this paper."

\section*{CREDIT AUTHOR STATEMENT}

\section*{ACKNOWLEDGEMENT}
Nếu cảm ơn người khác ngoài tác giả và nguồn tài trợ mà không ghi rõ mã nguồn tài trợ

\section*{FUNDING}
nếu có nguồn tài trợ rõ ràng, ghi mã nguồn tài trợ (ví dụ: NAFOSTED, code số) trong phần này hoặc không có nguồn tài trợ cũng phải ghi rõ "This research received no specific grant from any funding agency in the public, commercial, or not-for-profit sectors.")
```
- Tất cả viết HOA
- `CREDIT AUTHOR STATEMENT` có format:
  ```latex
  Tên TC1: \textit{Conceptualization, Methodology, ...}.
  Tên TC2: \textit{Investigation, Validation, ...}.
  ```

### 6.4. Spacing
- Trước `\section` nên có 1 dòng trống
- Trước `\subsection` nên có 1 dòng trống

---

## 7. Equations

### 7.1. Display equations
```latex
\begin{equation}\label{1}
  ... nội dung phương trình ...
\end{equation}
```
- Label đánh số trực tiếp: `\label{1}`, `\label{2}`, ...
- Tham chiếu: `Eq.~(\ref{1})`, `Eqs.~(\ref{10})`
- Cuối phương trình có dùng dấu `.` hoặc `,` phụ thuộc vào câu tiếp sau phương trình đó đã ngắt ý hay chưa

### 7.2. Equation không số
```latex
\begin{equation*}
  ...
\end{equation*}
```

### 7.3. Subequations
```latex
\begin{subequations}\label{10}
\begin{equation}\label{10a}
  ...
\end{equation}
\begin{equation}\label{10b}
  ...
\end{equation}
\end{subequations}
```
- Label chính: số (`\label{10}`), label con: số + chữ (`\label{10a}`, `\label{10b}`, ...)

### 7.4. Inline math
- Dùng `$...$` cho biến đơn hoặc biểu thức ngắn
- Toán tử vi phân: `\dif` (đã define trong preamble)
- Đơn vị SI: dùng `\SI{giá_trị}{đơn_vị}` (package `siunitx`)
- Công thức hóa học: dùng `\ce{...}` (package `mhchem`)

---

## 8. Figures

### 8.1. Figure đơn
```latex
\begin{figure}[ht!]\centering
	\includegraphics[width=.47\textwidth]{Figures/F1}
	\caption{Mô tả hình}\label{f1}
\end{figure}
```

### 8.2. Figure đôi (subfigure)
```latex
\begin{figure}[ht!]\centering
	\subfigure[Caption con a]{\includegraphics[height=0.35\textwidth]{Figures/F3a}}
	\hfill
  %\qquad
	\subfigure[Caption con b]{\includegraphics[height=0.35\textwidth]{Figures/F3b}}
	\caption{Caption tổng}\label{f3}
\end{figure}
```

### 8.3. Wrap figure
```latex
\begin{wrapfigure}{R}{0.45\textwidth}\vspace*{-2mm}
	\centering
	\includegraphics[width=0.31\textwidth]{Figures/FN}
	\caption{Mô tả}\label{fN}
\end{wrapfigure}
```

### 8.4. Quy tắc chung
- Đường dẫn hình: `Figures/FN` (đặt trực tiếp trong thư mục `Figures/`, N là số/ký tự thứ tự)
- Label: `f1`, `f2`, `f3`, ...
- Tham chiếu: `Fig.~\ref{fN}`
- Placement: luôn `[ht!]`
- Subfigure có thể dùng caption rỗng `[]` nếu chỉ đánh (a), (b)
- Giữa 2 subfigure dùng `\qquad` (KHÔNG dùng `\hfill`)
- Caption dài có thể ngắt bằng `\\`
- **Caption KHÔNG kết thúc bằng dấu `.`**

---

## 9. Tables

### 9.1. Cấu trúc table chuẩn
```latex
\begin{table}[ht!]\caption{Mô tả bảng}\label{t1}
	%\tabcolsep = 4.65mm
	%\fontsize{9}{11} \selectfont
	%\renewcommand*\arraystretch{1.2}
	\begin{tabularx}{\textwidth}{ccccccccccccccccccc}\toprule
		\lll{1}{Header 1} & \lll{1}{Header 2} & \lll{1}{Header 3} \\\midrule
		Data 1 & Data 2 & Data 3 \\
		\bottomrule\end{tabularx}
	%\vspace*{1mm}\fontsize{10}{12} \selectfont
\end{table}
```

- Các dòng comment (`%`) giữ nguyên để dễ bật khi cần tùy chỉnh: `\tabcolsep`, `\fontsize`, `\arraystretch`, `\vspace`

### 9.2. Quy tắc
- **LUÔN** dùng `tabularx` với `\textwidth`
- Dùng `\toprule`, `\midrule`, `\bottomrule` (booktabs) — **KHÔNG** dùng `\hline`
- Label: `t1`, `t2`, ...
- Tham chiếu: `Table~\ref{tN}`
- `\caption` đặt **TRƯỚC** `tabularx`, nằm cùng dòng `\begin{table}`
- `\tabcolsep` tùy chỉnh khoảng cách cột (uncomment khi cần)
- Placement: `[ht!]`
- Dùng `\multirow{N}{*}{...}` cho gộp dòng, `\multicolumn{N}{c}{...}` cho gộp cột
- Dùng `\cmidrule{N-M}` cho đường kẻ ngang cục bộ
- **Caption KHÔNG kết thúc bằng dấu `.`**

---

## 10. Citations & Bibliography

### 10.1. In-text citations (biblatex/APA style)
```latex
\parencite{1}             % (Author, Year) — citation trong ngoặc
\parencite{1,2,3}         % nhiều citations ghép
\textcite{2}              % Author (Year) — citation trong text
```
- **KHÔNG** dùng `\cite{...}` — đây là BibTeX cũ
- Dùng `~` trước `\parencite`: `text~\parencite{N}`

### 10.2. Bibliography output
```latex
\defbibheading{finalbib}{\section*{REFERENCES}}
\printbibliography[heading=finalbib]
```
- Heading tùy chỉnh: `REFERENCES` viết HOA
- **KHÔNG** dùng `\bibliographystyle` hay `\bibliography`

---

## 11. Quy trình chuẩn hóa file LaTeX

Khi được yêu cầu chuẩn hóa file LaTeX theo VJMech, thực hiện theo các bước:

1. **Kiểm tra preamble**: đúng documentclass (`vjmech_ol` hoặc `vjmech`), đủ packages theo thứ tự chuẩn, biblatex setup đúng
2. **Kiểm tra header**: `\Volume`, `\Number`, `\Year`, `\Page`, `\Endpage`, `\ID`
3. **Kiểm tra title/author block**: `\Title`, `\author` (gồm affiliations, ORCID, email, dates), `\maketitle`, `\markboth`
4. **Kiểm tra abstract**: `\begin{abstract}...\keyword{...}\end{abstract}`
5. **Chuẩn hóa sections**: tiêu đề viết HOA, đúng hierarchy
6. **Chuẩn hóa equations**: label số, tham chiếu, subequations
7. **Chuẩn hóa figures**: đường dẫn `Figures/\id/`, label, placement
8. **Chuẩn hóa tables**: tabularx, booktabs (`\FL`), label, caption trước
9. **Chuẩn hóa citations**: `\parencite` và `\textcite` (KHÔNG dùng `\cite`)
10. **Kiểm tra kết thúc**: Declaration, Credit Author Statement, Acknowledgement, `\printbibliography`

### Lưu ý quan trọng
- **LUÔN backup** file trước khi chỉnh sửa
- Thực hiện **từng bước**, commit sau mỗi nhóm thay đổi
- Không cần **compile** sau mỗi lần chỉnh sửa
- Với file lớn (>500 dòng), làm **incremental** để tránh memory error
- **LUÔN đọc trực tiếp file** (`view_file`) để kiểm tra nội dung — **KHÔNG** dùng `grep`, `findstr`, `Select-String` hay bất kỳ lệnh tìm kiếm nào
- **KHÔNG** tạo script sửa nhanh (sed, PowerShell replace, python script...) — luôn dùng tool chỉnh sửa file trực tiếp
- Khi proof (bản online): dùng `\usepackage[final]{changes}` và class `vjmech_ol`
- Khi final: dùng class `vjmech` và bỏ package `changes`
