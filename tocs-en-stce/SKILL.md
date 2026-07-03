---
name: tocs-en-stce
description: Tạo/cập nhật file LaTeX mục lục tiếng Anh (Table of Contents) cho tạp chí STCE/HUCE từ các file bài báo trong 04-Papers
---

# TOCs-EN-STCE Skill

Skill tạo hoặc cập nhật file **Table of Contents tiếng Anh** (file `00_Table of contents_en.tex`) trong thư mục `02-TOCs`, dựa trên thông tin trích xuất từ các file `.tex` trong thư mục `04-Papers`.

---

## 1. Cấu trúc thư mục

```
Vol.XX No.Y - MM.YYYY/
├── 02-TOCs/
│   ├── 00_Table of contents_en.tex   ← file cần tạo/cập nhật
│   ├── stce.cls
│   └── stce.sty
├── 04-Papers/
│   ├── 01_XXXX_Tên tác giả.tex
│   ├── 02_XXXX_Tên tác giả.tex
│   └── ...
```

---

## 2. Thông tin cần trích xuất từ mỗi file bài báo

Từ mỗi file `.tex` trong `04-Papers`, trích xuất 3 thông tin:

| Thông tin | Lệnh LaTeX | Ví dụ |
|-----------|------------|-------|
| **Title** | `\title{...}` | `Verification of large-diameter bored pile...` |
| **Authors** | `\author[x]{Tên}` (tất cả, bỏ `\orcidlink`, `\corref`, `\\`) | `Tai-Yi Liu, Cheng-An Lee, ...` |
| **First page** | `\firstpage{N}` | `1` |

### Quy tắc trích xuất:

- **Title**: Lấy nội dung trong `\title{...}`, loại bỏ `\\` (line break), viết thành 1 dòng. **BẮT BUỘC** chuyển về dạng Normal Case / Sentence Case: Chỉ viết hoa chữ cái đầu tiên của câu và chữ cái đầu tiên sau dấu hai chấm (`:`). Giữ nguyên in hoa đối với các từ viết tắt (VD: CFD, WIPAS, AI) hoặc tên riêng. **LƯU Ý QUAN TRỌNG:** Phải giữ nguyên cả các từ viết tắt có chứa chữ số (VD: A3, B2B) - cẩn thận khi dùng regex lược bỏ ký tự đặc biệt kẻo làm mất chữ số và biến chúng thành chữ thường. Nếu tiêu đề gốc đang in hoa toàn bộ, phải chuyển về chữ thường và tự phục hồi từ viết tắt.
- **Authors**: Lấy tất cả `\author[...]{Tên}` (bỏ dòng comment `%\author`), loại bỏ `\orcidlink{...}`, `\corref{cor}`, `\\` ở đầu tên. Nối tên bằng dấu `,`
- **Firstpage**: Lấy số trong `\firstpage{N}`
- **Thứ tự bài**: theo prefix số ở tên file (`01_`, `02_`, ..., `08_`, ...)

---

## 3. Template file `00_Table of contents_en.tex`

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


\oddhead{\fontsize{10pt}{12}\selectfont \hfil Journal of Science and Technology in Civil Engineering, HUCE, YYYY, VV (N)	\hfil}
\evenhead{}
\oddfoot{\hfil\rm \thepage\hfil}
\evenfoot{}

\def\mydotfill{\unskip\nobreak\leaders\hbox{.}\hskip 4em plus 1fill\relax}

%\hsize 9cm %\raggedright
\begin{document}
\vspace*{-0.8cm}
\section*{\Large Table of Contents}

\linespread{1.25}\selectfont % Line spacing :double spacing 
%\noindent
%\textit{\textbf{Research Results and Applications}}


\begin{enumerate}
\item Tiêu đề bài 1

{\small\textit{Tác giả 1, Tác giả 2, Tác giả 3}} \dotfill TRANG

\item Tiêu đề bài 2

{\small\textit{Tác giả 1, Tác giả 2}} \dotfill TRANG

% ... tiếp tục cho các bài còn lại

\end{enumerate}
\end{document}
```

---

## 4. Quy tắc format mỗi entry

Mỗi bài báo trong TOC có format:

```latex
\item Tiêu đề bài báo

{\small\textit{Tác giả 1, Tác giả 2, Tác giả 3}} \dotfill TRANG_ĐẦU
```

### Chi tiết:
- **`\item`** + tiêu đề trên 1 dòng (nếu quá dài, dùng `\break` để xuống dòng thủ công)
- **Dòng trống** giữa title và authors
- **Authors**: bọc trong `{\small\textit{...}}`, nối bằng `, `
- **`\dotfill`** + số trang đầu (lấy từ `\firstpage`)
- **Dòng trống** sau mỗi entry (trước `\item` tiếp theo)
- Nếu danh sách tác giả quá dài (tràn 1 dòng), dùng `\\` để ngắt dòng trong `{\small\textit{...}}`

---

## 5. Cập nhật header

Thay đổi dòng `\oddhead` cho đúng năm và volume/issue:

```latex
\oddhead{\fontsize{10pt}{12}\selectfont \hfil Journal of Science and Technology in Civil Engineering, HUCE, YYYY, VV (N)	\hfil}
```

- **YYYY**: năm xuất bản (ví dụ: `2026`)
- **VV (N)**: volume và issue (ví dụ: `20 (1)`)
- Lấy thông tin từ `\volume{...}` trong file bài báo hoặc từ tên folder

---

## 6. Quy trình thực hiện

1. **Liệt kê** tất cả file `.tex` bài báo trong `04-Papers` (bỏ qua thư mục con)
2. **Sắp xếp** theo prefix số (`01_`, `02_`, ...)
3. **Trích xuất** từ mỗi file: `\title`, `\author` (tất cả), `\firstpage`
4. **Xác định** volume/year từ `\volume{...}` hoặc tên folder
5. **Tạo/ghi đè** file `02-TOCs/00_Table of contents_en.tex` theo template
6. **Kiểm tra** lại file đã tạo

### Lưu ý:
- Nếu file TOC đã tồn tại → **ghi đè** nội dung mới
- Preamble (dòng 1-13) giữ nguyên, chỉ cập nhật `\oddhead` và nội dung `\begin{enumerate}...\end{enumerate}`
- Giữ nguyên file `stce.cls` và `stce.sty` trong `02-TOCs/` (KHÔNG chỉnh sửa)