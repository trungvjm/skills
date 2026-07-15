---
name: latex-stce-en
description: Chuẩn hóa file LaTeX theo template STCE/HUCE Journal (Tạp chí KHCN Xây dựng HUCE)
---

# LaTeX-HUCE Skill

Skill chuẩn hóa file LaTeX theo đúng template của tạp chí **STCE — Science and Technology in Civil Engineering** (Tạp chí Khoa học Công nghệ Xây dựng, Đại học Xây dựng Hà Nội — HUCE).

Template chuẩn được lấy từ file `3451_Tai Yi Liu.tex`.

---

> [!CAUTION]
> ## ⚠️ QUY TẮC TỐI THƯỢNG — SUPREME RULE ⚠️
>
> **TUYỆT ĐỐI KHÔNG ĐƯỢC THAY ĐỔI NỘI DUNG GỐC.**
>
> Quy tắc này có **hiệu lực cao nhất**, vượt trên mọi quy tắc khác.
>
> **KHÔNG BAO GIỜ** được thay đổi:
> - **Giá trị số** trong phương trình, bảng biểu
> - **Ký hiệu toán học** (subscript, superscript, biến, ...)
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

- **Trước khi** bắt đầu chuẩn hóa bất kỳ file `.tex` nào, **LUÔN** copy file gốc thành bản sao lưu:
  ```
  copy "XXXX_Author Name.tex" "XXXX_Author Name_original.tex"
  ```
- Mục đích: để sau khi chuẩn hóa xong có dữ liệu gốc **đối chiếu chéo**, đảm bảo chỉ thay đổi format mà **không xóa/thay đổi nội dung gốc**
- **KHÔNG BAO GIỜ** sửa trực tiếp mà không tạo backup trước
- Chỉ xóa file backup sau khi user xác nhận đã kiểm tra xong

> [!CAUTION]
> **Chỉ chuẩn hóa FORMAT — KHÔNG thay đổi NỘI DUNG gốc**

**Nguyên tắc cốt lõi:** Nội dung text phải giữ nguyên 100% so với bản gốc. Chỉ được thay đổi cách trình bày LaTeX (formatting, spacing, commands).

**ĐƯỢC PHÉP:**
- Đổi `[1, 2]` → `~\cite{1,2}` (format citation)
- Đổi `Figure 1` → `Fig.~\ref{f1}` (format reference)
- Đổi `stress- strain` → `stress-strain` (sửa typo khoảng cách)
- Đổi raw text heading → `\section{...}` (format heading)
- Đổi raw table → `\begin{table}...\end{table}` (format table)
- Đổi `300C` → `30~$^\circ$C` (sửa lỗi ký tự đặc biệt)
- Thêm `~` trước `\cite`, `\ref`, `$^\circ$C` (spacing rules)
- Đổi `H2SO4` → `\ce{H2SO4}` (format chemical)
- Đổi raw equation → `\begin{equation}` (format equation)

**NGHIÊM CẤM:**
- **KHÔNG** rút gọn/đơn giản hóa header bảng (giữ nguyên tên cột gốc)
- **KHÔNG** bỏ tên viết tắt tác giả (giữ nguyên `Andisheh K et al` → `Andisheh et al.`)
- **KHÔNG** tự bổ sung nội dung thiếu (nếu gốc để trống/thiếu → giữ nguyên hoặc hỏi user)
- **KHÔNG** thay đổi giá trị dữ liệu trong bảng
- **KHÔNG** đổi ký hiệu/viết tắt (ví dụ `410` → `$\phi$10` là SAI)
- **KHÔNG** rút gọn đơn vị (ví dụ `(mm x mm x mm)` → `(mm)` là SAI)
- **KHÔNG** thay đổi thứ tự hoặc cấu trúc nội dung
- Nếu phát hiện lỗi nội dung trong bản gốc → **báo user**, KHÔNG tự ý sửa


---

## 1. Cấu trúc tổng thể của file `.tex`

Một file `.tex` đúng chuẩn STCE phải có cấu trúc sau theo đúng thứ tự:

```latex
\documentclass[3p,times,11pt]{STCE/stce}
\usepackage{STCE/stce_proof}
\input{STCE/stce_uncorrectedproof}    % hoặc stce_correctedproof
\volume{...}
\firstpage{...}
\copyrightyear{...}
\input{STCE/stce_package}
\newcommand\id{XXXX}                  % mã bài báo

\begin{document}
\begin{frontmatter}
  ... (metadata)
\end{frontmatter}

  ... (nội dung bài báo)

\section*{Acknowledgment}             % không đánh số

\bibliographystyle{STCE/stce}
\bibliography{Bib/XXXX}              % file .bib theo mã bài

\end{document}
```

---

## 2. Frontmatter — Metadata bài báo

Phần `frontmatter` có các thành phần (theo đúng thứ tự):

### 2.1. DOI
```latex
\doi{https://doi.org/10.31814/stce.huceYYYY-VV(N)-xx}
```

### 2.2. Title
```latex
\title{Tiêu đề bài báo}
```

### 2.3. Authors
```latex
\author[a]{Họ Tên} % tác giả đầu tiên
\author[b]{Họ Tên\corref{cor}}}   % tác giả liên hệ
...
```
- Label `[a]`, `[b]`, `[c]`... tương ứng với address
- Tác giả liên hệ (corresponding author) có thêm `\corref{cor}`

### 2.4. Corresponding author info
```latex
\cortext[cor]{Corresponding author.~\textit{E-mail address:}}
\shortauth{Tên, Họ viết tắt} % tên tác giả liên hệ viết tắt
\mailauth{email@domain} % email tác giả liên hệ
\headershort{Tên, Họ viết tắt, \textit{et al.}} % tên tác giả đầu tiên viết tắt, \textit{et al.} khi có >2 tác giả
```

**Quy tắc `\headershort`:**
- **1 tác giả**: ghi tên viết tắt tác giả đó, ví dụ: `\headershort{Anh, D. H.}`
- **2 tác giả**: ghi đủ tên viết tắt cả 2, ví dụ: `\headershort{Anh, D. H., Anh, N. V.}`
- **Từ 3 tác giả trở lên**: ghi tên tác giả liên hệ + `\textit{et al.}`, ví dụ: `\headershort{Thai, D.-K., \textit{et al.}}`

**Quy tắc viết tắt tên tác giả:**
- Tên viết tắt theo format: `Tên, Họ viết tắt. Đệm viết tắt.`
- Chỉ dùng dấu `-` nối giữa các chữ cái viết tắt khi **tên gốc có gạch nối** (ví dụ: "Duc-Kien" → `D.-K.`)
- Nếu tên gốc **không có gạch nối**, dùng dấu **cách** giữa các chữ viết tắt (ví dụ: "Do Hong Anh" → `Anh, D. H.`)
- Ví dụ:
  - `Duc-Kien Thai` → `Thai, D.-K.` (có `-` vì tên "Duc-Kien" có gạch nối)
  - `Do Hong Anh` → `Anh, D. H.` (không có `-` vì tên "Do Hong" không có gạch nối)
  - `Van-Long Nguyen` → `Nguyen, V.-L.` (có `-` vì tên "Van-Long" có gạch nối)

### 2.5. Addresses
```latex
\address[a]{Tên đơn vị, Quốc gia}
\address[b]{Tên đơn vị, Quốc gia}
...
```

### 2.6. Received dates
```latex
\received{DD/MM/YYYY}{DD/MM/YYYY}{DD/MM/YYYY}
```
- 3 ngày: received / revised / accepted

### 2.7. Abstract
```latex
\begin{abstract}
... (nội dung abstract, không ngắt dòng, viết liền 1 paragraph)
\end{abstract}
```

### 2.8. Keywords
```latex
\begin{keyword}
keyword1; keyword2; keyword3; keyword4; keyword5.
\CR
\end{keyword}
```
- Các keyword cách nhau bằng dấu `;` (chấm phẩy)
- Kết thúc bằng dấu `.` (chấm)
- `\CR` đứng riêng 1 dòng trước `\end{keyword}`

---

## 3. Nội dung bài báo — Sections

### 3.1. Hierarchy
```
\section{...}                   % Mục lớn: 1., 2., 3.
  \subsection{...}              % Mục con: 2.1., 2.2.
    \subsubsection{...}         % Mục con con: a., b., c.
```
- **KHÔNG BAO GIỜ** dùng `\paragraph` hay `\subparagraph`
- Section cuối cùng thường là `Conclusions`
- `Acknowledgment` dùng `\section*{Acknowledgment}` (không đánh số, viết số ít)

### 3.2. Format `\subsubsection`
- Đánh số theo chữ cái: **a.**, **b.**, **c.** (do class `stce` tự định nghĩa)
- Tiêu đề `\subsubsection` thường in nghiêng (italic) — do class xử lý
- Nội dung bắt đầu ngay sau tiêu đề (cùng dòng hoặc dòng mới, tùy nội dung)
- Ví dụ:
```latex
\subsubsection{Tên mục con con}

Nội dung paragraph...
```
- Khi chuẩn hóa: nếu bài gốc dùng bold/italic thủ công cho tiểu mục (ví dụ `\textbf{a.}` hoặc `\textit{a) Tên mục}`), phải chuyển thành `\subsubsection{Tên mục}` để class tự format

### 3.3. Spacing
- Trước `\section` nên có 2 dòng trống
- Trước `\subsection` nên có 1 dòng trống
- Trước `\subsubsection` nên có 1 dòng trống
- Không có dòng trống thừa giữa heading và paragraph đầu tiên

---

## 4. Equations

### 4.1. Display equations
```latex
\begin{equation}\label{1}
... nội dung phương trình ...
\end{equation}
```
- Label đánh số trực tiếp: `\label{1}`, `\label{2}`, `\label{3}`, ...
- Tham chiếu bằng `Eq.~(\ref{1})`, `Eq.~(\ref{2})`, ...

### 4.2. Inline math
- Dùng `$...$` cho biến đơn hoặc biểu thức ngắn
- Mô tả biến ngay sau equation: `where $X$ is ...; $Y$ is ...; and $Z$ is ...`

### 4.3. Ký hiệu đặc biệt
- Dấu ngang dài (en-dash) trong text: `--` (ví dụ: `load--settlement`)
- Khoảng `~` dùng trước `\cite`, `\ref`, `(\ref{...})`
- **Đơn vị nhiệt độ**: theo chuẩn SI, giữa số và đơn vị phải có khoảng trắng không ngắt dòng `~`
  - Đúng: `37~$^\circ$C`, `60~$^\circ$C`
  - Sai: `37$^\circ$C`, `60$^\circ$C` (thiếu `~`)
- **Công thức hóa học**: LUÔN dùng `\ce{}` (package `mhchem`), KHÔNG dùng subscript/superscript thủ công
  - Ví dụ: `\ce{H2SO4}`, `\ce{CO2}`, `\ce{NaOH}`, `\ce{NaNO3}`, `\ce{PO4}`, `\ce{NH4}`
  - Sai: `H$_2$SO$_4$`, `CO$_2$`
- **Tên loài/chi/họ khoa học**: LUÔN in nghiêng bằng `\textit{}` theo quy chuẩn danh pháp khoa học
  - Ví dụ: `\textit{E. coli}`, `\textit{Ascaris}`, `\textit{Salmonella}`, `\textit{Lactobacillus}`

---

## 5. Figures

### 5.1. Figure đơn
```latex
\begin{figure}[ht!]\centering
	\includegraphics[width=0.65\textwidth]{Figures/\id/FN}
	\caption{Mô tả hình}\label{fN}
\end{figure}
```

### 5.2. Figure đôi (subfigure)
```latex
\begin{figure}[ht!]\centering
	\subfigure[Caption con a]{\includegraphics[width=0.47\textwidth]{Figures/\id/FNa}}
	\hfill
	\subfigure[Caption con b]{\includegraphics[width=0.47\textwidth]{Figures/\id/FNb}}
	\caption{Caption tổng}\label{fN}
\end{figure}
```
- Khi cần đồng đều chiều cao thay vì chiều rộng, dùng `height` thay `width`:
```latex
\begin{figure}[ht!]\centering
	\subfigure[]{\includegraphics[height=0.38\textwidth]{Figures/\id/FNa}}
	\hfill
	%\qquad
	\subfigure[]{\includegraphics[height=0.38\textwidth]{Figures/\id/FNb}}
	\caption{}\label{fN}
\end{figure}
```
- Dùng `\hfill` để tự căn 2 hình đều 2 bên; thay bằng `\qquad` (đã comment sẵn) nếu muốn khoảng cách cố định


### 5.3. Hai hình cùng hàng (minipage)
Khi cần 2 hình **cùng hàng** nhưng **mỗi hình** có caption và label riêng (khác với subfigure dùng chung 1 caption tổng):
```latex
\begin{figure}[ht!]
	\begin{minipage}[t]{0.48\textwidth}
		\centering
		\includegraphics[height=0.8\textwidth]{Figures/\id/FN}
		\caption{}\label{fN}
	\end{minipage}
	\hfill
	\begin{minipage}[t]{0.48\textwidth}
		\centering
		\includegraphics[height=0.8\textwidth]{Figures/\id/FM}
		\caption{}\label{fM}
	\end{minipage}
\end{figure}
```

### 5.4. Wrap figure
```latex
\begin{wrapfigure}{R}{0.45\textwidth}\vspace*{-2mm}
	\centering
	\includegraphics[width=0.31\textwidth]{Figures/\id/FN}
	\caption{Mô tả}\label{fN}
\end{wrapfigure}
```

### 5.5. Quy tắc chung
- Đường dẫn hình: `Figures/\id/FN` (dùng `\id` macro, N là số thứ tự)
- Label: `f1`, `f2`, `f3`...
- Tham chiếu: `Fig.~\ref{fN}`
- **Tham chiếu subfigure**: dùng ngoặc `()`, ví dụ `Fig.~\ref{fN}(a)`, `Fig.~\ref{fN}(b)` — KHÔNG viết `Fig.~\ref{fN}a`
- Placement: luôn dùng `[ht!]`
- Width phổ biến: `0.65\textwidth` (đơn), `0.47\textwidth` (đôi)
- **Caption KHÔNG kết thúc bằng dấu `.`**

---

## 6. Tables

### 6.1. Cấu trúc table chuẩn
```latex
\begin{table}[ht!]\caption{Mô tả bảng}\label{tN}
%\tabcolsep = 3.5mm
%\fontsize{9}{11} \selectfont
%\renewcommand*\arraystretch{1.2}
\begin{tabularx}{\textwidth}{cccccccccccccccccc}\toprule
\lll{1}{Cột đầu tiên} & \lll{1}{Cột 2} & \lll{1}{Cột 3} \\\midrule
Dòng 1 & giá trị & giá trị \\
Dòng 2 & giá trị & giá trị
\\\bottomrule\end{tabularx}
%\vspace*{1mm}\fontsize{10}{12} \selectfont
\end{table}
```

### 6.2. Quy tắc
- **LUÔN** dùng `tabularx` với `\textwidth`
- Dùng `\toprule`, `\midrule`, `\bottomrule` (booktabs style) — **KHÔNG** dùng `\hline`
- Hàng đầu tiên dùng `\lll{1}{Cột đầu tiên} & \lll{1}{Cột 2} & \lll{1}{Cột 3} \\\midrule`
- Label: `t1`, `t2`, ...
- Tham chiếu: `Table~\ref{tN}`
- `\caption` đặt **TRƯỚC** `tabularx`
- `\tabcolsep` tùy chỉnh khoảng cách cột
- Dòng cuối KHÔNG có `\\` mà viết `\\\bottomrule\end{tabularx}`
- Placement: `[ht!]`
- **KHÔNG** thêm space/padding thừa để căn cột (ví dụ `SS & 5 & Present & 3.1654` — viết liền, KHÔNG thêm khoảng trắng dài giữa các `&` để canh hàng). Giữ code bảng **compact**, dễ đọc
- **Cột số**: dùng column type `S` (package `siunitx`) thay vì `c` để **dóng hàng theo dấu `.`**. Header của cột `S` phải wrap trong `{...}` (ví dụ `{0} & {2} & {5}`). Ví dụ: `\begin{tabularx}{\textwidth}{XSSSS}` thay vì `\begin{tabularx}{\textwidth}{Xcccc}`
- **Caption KHÔNG kết thúc bằng dấu `.`**

---

## 7. Citations & Bibliography

### 7.1. In-text citations
```latex
\cite{1,2,3}          % nhiều citations ghép chung
\cite{11}             % citation đơn
```
- Dùng `~` trước `\cite`: `text~\cite{N}`
- Số citation là key trong file `.bib`

### 7.2. Bibliography
```latex
\bibliographystyle{STCE/stce}
\bibliography{Bib/XXXX}
```
- File `.bib` đặt trong thư mục `Bib/`
- Tên file `.bib` trùng với mã bài `\id`

---

## 8. Quy trình chuẩn hóa file LaTeX

Khi được yêu cầu chuẩn hóa file LaTeX theo STCE/HUCE, thực hiện theo các bước:

1. **Kiểm tra preamble**: đúng documentclass, packages, `\id`
2. **Kiểm tra frontmatter**: đủ và đúng thứ tự các thành phần (doi, title, author, cortext, shortauth, mailauth, headershort, address, received, abstract, keyword)
3. **Chuẩn hóa sections**: đúng hierarchy, spacing
4. **Chuẩn hóa equations**: format `%` trước/sau, label, tham chiếu
5. **Chuẩn hóa figures**: đường dẫn, label, placement, width
6. **Chuẩn hóa tables**: tabularx, booktabs, `\lll`, label
7. **Chuẩn hóa citations**: format `\cite`, kiểm tra `~` spacing
8. **Kiểm tra kết thúc**: Acknowledgment, bibliography

### Lưu ý quan trọng
- **LUÔN backup** file trước khi chỉnh sửa
- Thực hiện **từng bước**, commit sau mỗi nhóm thay đổi
- Kiểm tra **compile** sau mỗi lần chỉnh sửa lớn
- Với file lớn (>500 dòng), làm **incremental** để tránh memory error
- **LUÔN đọc trực tiếp file** (`view_file`) để kiểm tra nội dung — **KHÔNG** dùng `grep`, `findstr`, `Select-String` hay bất kỳ lệnh tìm kiếm nào
- **KHÔNG** tạo script sửa nhanh (sed, PowerShell replace, python script...) — luôn dùng tool chỉnh sửa file trực tiếp
