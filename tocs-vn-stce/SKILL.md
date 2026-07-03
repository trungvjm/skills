---
name: tocs-vn-stce
description: Tạo/cập nhật 2 file LaTeX mục lục (tiếng Việt và tiếng Anh) cho tạp chí STCE (bản tiếng Việt) từ các file bài báo trong 04-Papers
---

# TOCs-VN-STCE Skill

Skill tạo hoặc cập nhật 2 file **Table of Contents** (tiếng Việt `00_Table of contents_1_vi.tex` và tiếng Anh `00_Table of contents_2_en.tex`) trong thư mục `02-TOCs` cho các số xuất bản tiếng Việt của tạp chí STCE, dựa trên thông tin trích xuất từ các file `.tex` trong thư mục `04-Papers`.

---

## 1. Cấu trúc thư mục

```
Vol.XX No.Y - MM.YYYY/
├── 02-TOCs/
│   ├── 00_Table of contents_1_vi.tex   ← file cần tạo/cập nhật
│   ├── 00_Table of contents_2_en.tex   ← file cần tạo/cập nhật
│   ├── stce.cls
│   └── stce.sty
├── 04-Papers/
│   ├── 01_XXXX_Tên tác giả.tex
│   ├── 02_XXXX_Tên tác giả.tex
│   └── ...
```

---

## 2. Thông tin cần trích xuất từ mỗi file bài báo

Từ mỗi file `.tex` trong `04-Papers`, trích xuất các thông tin sau:

| Thông tin | Nguồn trích xuất | Lưu ý |
|-----------|------------|-------|
| **Title (VN)** | Từ lệnh `\title{...}`. | Loại bỏ `\\`, **BẮT BUỘC** viết dạng Normal Case / Sentence Case: Chỉ viết hoa chữ cái đầu tiên của câu và chữ cái đầu tiên sau dấu hai chấm (`:`). Giữ nguyên in hoa đối với các từ viết tắt hoặc tên riêng. **LƯU Ý:** Phải giữ nguyên cả từ viết tắt chứa chữ số (VD: A3, B2B), cẩn thận khi dùng regex lược bỏ ký tự đặc biệt. Nếu in hoa toàn bộ thì phải chuyển về chữ thường và tự phục hồi từ viết tắt. |
| **Title (EN)** | Từ sau lệnh `\TD` trong block `\begin{keyword}`. | Loại bỏ `\\`, **BẮT BUỘC** chuyển về dạng Normal Case / Sentence Case (áp dụng quy tắc y hệt như Title (VN): xử lý dấu hai chấm, từ viết tắt có chứa số, in hoa toàn bộ). |
| **Authors** | Tất cả các lệnh `\author[x]{Tên}` | Loại bỏ `\orcidlink`, `\corref`, `\\`. Nối các tên bằng dấu `, `. Dùng chung danh sách này cho cả bản Việt và Anh. |
| **First page** | Từ lệnh `\firstpage{N}` | |

**Thứ tự bài:** Sắp xếp theo prefix số ở tên file (ví dụ: `01_`, `02_`, ...).

---

## 3. Template file mục lục tiếng Việt (`00_Table of contents_1_vi.tex`)

```latex
\documentclass[3p,times,11pt]{stce}
%% The `ecrc' package must be called to make the CRC functionality available
\usepackage{stce}
\usepackage{mhchem}
%\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[utf8]{vietnam}
\usepackage[english,vietnamese]{babel}
\pagenumbering{roman}
\makeatletter
\newcommand\oddhead[1]{\gdef\@oddhead{\reset@font#1}}
\newcommand\evenhead[1]{\gdef\@evenhead{\reset@font#1}}
\newcommand\oddfoot[1]{\gdef\@oddfoot{\reset@font#1}}
\newcommand\evenfoot[1]{\gdef\@evenfoot{\reset@font#1}}
\makeatother
\setcounter{page}{1}

\usepackage{ifluatex}
\ifluatex 
\usepackage{fontspec}
%\setsansfont{CMU Sans Serif}%{Arial}
\setmainfont{Times New Roman}
%\setmonofont{CMU Typewriter Text}%{Consolas}
\defaultfontfeatures{Ligatures={TeX}}
\else
\usepackage[utf8]{inputenc}
\usepackage[T2A,T1]{fontenc}
\fi


\oddhead{\fontsize{10pt}{12}\selectfont \hfil Tạp chí Khoa học Công nghệ Xây dựng, ĐHXDHN, YYYY, VV (N) \hfil}
\evenhead{}
\oddfoot{\hfil\rm\thepage\hfil}
\evenfoot{}

\def\mydotfill{\unskip\nobreak\leaders\hbox{.}\hskip 4em plus 1fill\relax}

%\DeclareUnicodeCharacter{0301}{\'{}}
%\usepackage[tcvn]{vietnam}
%\hsize 1cm \raggedright
\begin{document}
	
\linespread{1.3}\selectfont
\section*{\Large Mục lục}

	
\begin{enumerate}

\item Tiêu đề bài 1 (tiếng Việt)

{\small\textit{Tác giả 1, Tác giả 2, Tác giả 3}} \dotfill TRANG

% ... tiếp tục cho các bài còn lại

\end{enumerate}
\end{document}
```

---

## 4. Template file mục lục tiếng Anh (`00_Table of contents_2_en.tex`)

```latex
\documentclass[3p,times,11pt]{stce}
%% The `ecrc' package must be called to make the CRC functionality available
\usepackage{stce}
\usepackage{mhchem}
\usepackage[utf8]{inputenc}
\usepackage[english,russian,vietnamese]{babel}
\pagenumbering{roman}
\makeatletter
\newcommand\oddhead[1]{\gdef\@oddhead{\reset@font#1}}
\newcommand\evenhead[1]{\gdef\@evenhead{\reset@font#1}}
\newcommand\oddfoot[1]{\gdef\@oddfoot{\reset@font#1}}
\newcommand\evenfoot[1]{\gdef\@evenfoot{\reset@font#1}}
\makeatother
\setcounter{page}{2}

\usepackage{ifluatex}
\ifluatex 
\usepackage{fontspec}
%\setsansfont{CMU Sans Serif}%{Arial}
\setmainfont{Times New Roman}
%\setmonofont{CMU Typewriter Text}%{Consolas}
\defaultfontfeatures{Ligatures={TeX}}
\else
\usepackage[utf8]{inputenc}
\usepackage[T2A,T1]{fontenc}
\fi

\oddhead{\fontsize{10pt}{12}\selectfont \hfil Journal of Science and Technology in Civil Engineering, HUCE, YYYY, VV (N)	\hfil}
\evenhead{}
\oddfoot{\hfil\rm\thepage\hfil}
\evenfoot{}

\def\mydotfill{\unskip\nobreak\leaders\hbox{.}\hskip 4em plus 1fill\relax}

%\hsize 3cm \raggedright
\begin{document}

\linespread{1.3}\selectfont
%\vspace*{1mm}
\section*{\Large Table of Contents}

\begin{enumerate}

\item Tiêu đề bài 1 (tiếng Anh)

{\small\textit{Tác giả 1, Tác giả 2, Tác giả 3}} \dotfill TRANG

% ... tiếp tục cho các bài còn lại

\end{enumerate}
\end{document}
```

---

## 5. Quy tắc format mỗi entry (cho cả 2 file)

Mỗi bài báo trong TOC có format:

```latex
\item Tiêu đề bài báo

{\small\textit{Tác giả 1, Tác giả 2, Tác giả 3}} \dotfill TRANG_ĐẦU
```

### Chi tiết:
- **`\item`** + tiêu đề trên 1 dòng.
- **Có dòng trống** giữa tiêu đề và danh sách tác giả.
- **Authors**: bọc trong `{\small\textit{...}}`, nối bằng `, `. Nếu danh sách tác giả dài, dùng `\\` ngắt dòng bên trong.
- **`\dotfill`** + số trang đầu (lấy từ `\firstpage`).
- **Dòng trống** sau mỗi entry.

---

## 6. Cập nhật header (Năm và Số/Tập)

Cần cập nhật các tham số `YYYY` (năm) và `VV (N)` (tập/số) trong lệnh `\oddhead` ở cả 2 file.
- **Lưu ý:** Với số tiếng Việt, `(N)` thường có chữ `V` (ví dụ: `20 (1V)`).
- Lấy thông tin này từ tên thư mục chứa bài viết hoặc trực tiếp hỏi user nếu không rõ.

---

## 7. Quy trình thực hiện

1. **Liệt kê** tất cả file `.tex` bài báo trong thư mục `04-Papers` (sắp xếp theo prefix `01_`, `02_`, ...).
2. **Trích xuất** dữ liệu từ mỗi bài: Tiêu đề tiếng Việt, Tiêu đề tiếng Anh, Danh sách tác giả, và Trang đầu (`\firstpage`).
3. **Xác định** volume, số báo, và năm xuất bản.
4. **Tạo/ghi đè** file `02-TOCs/00_Table of contents_1_vi.tex` theo template tiếng Việt. Đảm bảo dùng `\setcounter{page}{1}` và `\oddhead` tiếng Việt. Thay thế các entries bằng danh sách tiêu đề tiếng Việt.
5. **Tạo/ghi đè** file `02-TOCs/00_Table of contents_2_en.tex` theo template tiếng Anh. Đảm bảo dùng `\setcounter{page}{2}` và `\oddhead` tiếng Anh. Thay thế các entries bằng danh sách tiêu đề tiếng Anh.
6. **Kiểm tra** lại cả 2 file xem đã tuân thủ định dạng ngắt dòng, `\dotfill`, và ngoặc móc `{}` chưa.