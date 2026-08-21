---
name: latex-stce-vn
description: Chuẩn hóa file LaTeX theo template STCE tiếng Việt (Tạp chí KHCN Xây dựng - bản tiếng Việt)
---

# LaTeX-STCE Skill

Skill chuẩn hóa file LaTeX theo đúng template của tạp chí **STCE — Tạp chí Khoa học Công nghệ Xây dựng** (bản tiếng Việt), Đại học Xây dựng Hà Nội — HUCE.

> [!IMPORTANT]
> Skill này dành cho **bài báo tiếng Việt**. Đối với bài báo tiếng Anh, sử dụng skill **latex-stce-en**.

Template chuẩn được lấy từ file `01_3330_Dinh Van Thuat.tex`.

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

- **Trước khi** bắt đầu chuẩn hóa bất kỳ file `.tex` hoặc `.bib` nào, **LUÔN** copy file gốc thành bản sao lưu:
  ```
  copy "XXXX_Author Name.tex" "XXXX_Author Name_original.tex"
  copy "Bib/XXXX.bib" "Bib/XXXX_original.bib"
  ```
- Mục đích: để sau khi chuẩn hóa xong có dữ liệu gốc **đối chiếu chéo**, đảm bảo chỉ thay đổi format mà **không xóa/thay đổi nội dung gốc**
- **KHÔNG BAO GIỜ** sửa trực tiếp mà không tạo backup trước
- Chỉ xóa file backup sau khi user xác nhận đã kiểm tra xong

> [!CAUTION]
> **Chỉ chuẩn hóa FORMAT — KHÔNG thay đổi NỘI DUNG gốc**

**Nguyên tắc cốt lõi:** Nội dung text phải giữ nguyên 100% so với bản gốc. Chỉ được thay đổi cách trình bày LaTeX (formatting, spacing, commands).

**ĐƯỢC PHÉP:**
- Đổi `[1, 2]` → `~\cite{1,2}` (format citation)
- Đổi `Hình 1` → `Hình~\ref{f1}` (format reference)
- Đổi `stress- strain` → `stress-strain` (sửa typo khoảng cách)
- Đổi raw text heading → `\section{...}` (format heading)
- Đổi raw table → `\begin{table}...\end{table}` (format table)
- Đổi `300C` → `30~$^\circ$C` (sửa lỗi ký tự đặc biệt)
- Thêm `~` trước `\cite`, `\ref`, `$^\circ$C` (spacing rules)
- Đổi `H2SO4` → `\ce{H2SO4}` (format chemical)
- Đổi raw equation → `\begin{equation}` (format equation)

**NGHIÊM CẤM:**
- **KHÔNG** rút gọn/đơn giản hóa header bảng (giữ nguyên tên cột gốc)
- **KHÔNG** bỏ tên viết tắt tác giả (giữ nguyên tên gốc)
- **KHÔNG** tự bổ sung nội dung thiếu (nếu gốc để trống/thiếu → giữ nguyên hoặc hỏi user)
- **KHÔNG** thay đổi giá trị dữ liệu trong bảng
- **KHÔNG** đổi ký hiệu/viết tắt (ví dụ `410` → `$\phi$10` là SAI)
- **KHÔNG** rút gọn đơn vị (ví dụ `(mm x mm x mm)` → `(mm)` là SAI)
- **KHÔNG** thay đổi thứ tự hoặc cấu trúc nội dung
- Nếu phát hiện lỗi nội dung trong bản gốc → **báo user**, KHÔNG tự ý sửa

> [!CAUTION]
> **Mọi thay đổi phải có REPORT rõ ràng**

- Sau mỗi lần chuẩn hóa, **PHẢI** báo cáo đầy đủ tất cả các thay đổi đã thực hiện
- Mỗi mục trong report phải ghi rõ:
  - **Dòng bao nhiêu** (số dòng trong file)
  - **Thay đổi gì**: nội dung gốc → nội dung mới
  - **Lý do** thay đổi (ví dụ: format citation, thay Unicode, chuẩn hóa table...)
- KHÔNG được thay đổi "âm thầm" mà không liệt kê trong report


---

## 1. Cấu trúc tổng thể của file `.tex`

Một file `.tex` đúng chuẩn STCE tiếng Việt phải có cấu trúc sau theo đúng thứ tự:

```latex
\documentclass[3p,times,11pt]{STCE/stce}
%\usepackage{STCE/stce}
\usepackage{STCE/stce_proof}
\input{STCE/stce_package}
\input{STCE/stce_uncorrectedproof}    % hoặc stce_correctedproof
%\input{STCE/stce_correctedproof}
\volume{...}
\firstpage{...}
\copyrightyear{...}

\newcommand\id{XXXX}                  % mã bài báo

\begin{document}
\begin{frontmatter}
  ... (metadata)
\end{frontmatter}

  ... (nội dung bài báo)

\bibliographystyle{STCE/stce}
\bibliography{Bib/XXXX}              % file .bib theo mã bài

\end{document}
```

> [!NOTE]
> Preamble **giống** với bản tiếng Anh (latex-stce-en). Không có section `\section*{Acknowledgment}` mặc định — chỉ thêm nếu bài gốc có phần Lời cảm ơn.

---

## 2. Frontmatter — Metadata bài báo

Phần `frontmatter` có các thành phần (theo đúng thứ tự):

### 2.1. DOI
```latex
\doi{https://doi.org/10.31814/stce.huceYYYY-VV(NV)-xx}
```
- Lưu ý: volume tiếng Việt thường dùng ký hiệu `(1V)`, `(2V)` — cần thể hiện đúng trong DOI

### 2.2. Title (Tiếng Việt)
```latex
\title{Tiêu đề bài báo Tiếng Việt}
```
- **Tiêu đề bài tiếng Việt viết thường kiểu Sentence case, chỉ viết Hoa các từ bắt buộc phải viết hoa**

Ví dụ:
```latex
\title{Ảnh hưởng của độ cứng thanh giằng chịu nén trong thiết kế kết cấu khung thép}
```

### 2.3. Authors
```latex
\author[a]{Nguyễn Thành Đạt} % tác giả đầu tiên
\author[b]{Hàn Ngọc Đức}
\author[b]{Đinh Văn Thuật\corref{cor1}}   % tác giả liên hệ
```
- Label `[a]`, `[b]`, `[c]`... tương ứng với address
- Tác giả liên hệ (corresponding author) có thêm `\corref{cor1}`
- Tên tác giả viết theo **thứ tự tiếng Việt**: Họ Đệm Tên (ví dụ: `Đinh Văn Thuật`)

### 2.4. Corresponding author info
```latex
\cortext[cor1]{Tác giả đại diện. \textit{Địa chỉ e-mail:}}
\shortauth{Tên, Họ viết tắt.} % tên tác giả liên hệ viết tắt
\mailauth{email@domain}	% email tác giả liên hệ
\headershort{Tên, Họ viết tắt., và cs.} % tên tác giả đầu tiên viết tắt, và cs. khi có >2 tác giả
```

> [!IMPORTANT]
> **Khác biệt so với bản tiếng Anh:**
> - `\cortext`: dùng `Tác giả đại diện. \textit{Địa chỉ e-mail:}` thay vì `Corresponding author.~\textit{E-mail address:}`
> - `\headershort`: dùng `và cs.` thay vì `\textit{et al.}`
> - `\corref{cor1}` thay vì `\corref{cor}`

**Quy tắc `\headershort`:**
- **1 tác giả**: ghi tên viết tắt tác giả đó, ví dụ: `\headershort{Thuật, Đ. V.}`
- **2 tác giả**: ghi đủ tên viết tắt cả 2, ví dụ: `\headershort{Thuật, Đ. V., Đức, H. N.}`
- **Từ 3 tác giả trở lên**: ghi tên tác giả liên hệ + `và cs.`, ví dụ: `\headershort{Thuật, Đ. V., và cs.}`

**Quy tắc viết tắt tên tác giả Việt Nam:**
- Format: `Tên, Họ viết tắt. Đệm viết tắt.`
- Ví dụ:
  - `Đinh Văn Thuật` → `Thuật, Đ. V.`
  - `Nguyễn Thành Đạt` → `Đạt, N. T.`
  - `Hàn Ngọc Đức` → `Đức, H. N.`
  - `Ngô Hữu Cường` → `Cường, N. H.`

### 2.5. Addresses
```latex
\address[a]{Tên đơn vị, Địa chỉ, Việt Nam}
\address[b]{Khoa ..., Trường Đại học ...,\\ Địa chỉ, Việt Nam}
```
- Địa chỉ viết **bằng tiếng Việt**
- Nếu dài quá 1 dòng, dùng `\\` để ngắt dòng

### 2.6. Received dates
```latex
\received{DD/M/YYYY}{DD/M/YYYY}{DD/M/YYYY}
```
- 3 ngày: received / revised / accepted
- **Quy tắc ghi tháng trong văn bản tiếng Việt:** tháng 1 và tháng 2 phải ghi lần lượt là `01` và `02`; tháng 3 đến tháng 9 ghi `3` đến `9`, không thêm số `0` ở phía trước; tháng 10 đến tháng 12 ghi đủ hai chữ số (`10`, `11`, `12`).
- Ví dụ đúng: `\received{04/01/2026}{12/7/2026}{12/8/2026}`.

### 2.7. Abstract (Tiếng Việt)
```latex
\begin{abstract}
... (nội dung tóm tắt tiếng Việt, viết liền 1 paragraph)
\end{abstract}
```

### 2.8. Keywords block (Song ngữ)

> [!IMPORTANT]
> **Đây là điểm khác biệt LỚN NHẤT so với bản tiếng Anh.** Phần keyword bao gồm THÊM tiêu đề tiếng Anh, abstract tiếng Anh và keywords tiếng Anh.

```latex
\begin{keyword}
từ khóa 1; từ khóa 2; từ khóa 3; từ khóa 4.

\TD
TIÊU ĐỀ TIẾNG ANH VIẾT HOA

\ABS
\begin{otherlanguage}{english}
English abstract text...
\end{otherlanguage}
\KW
keyword1; keyword2; keyword3; keyword4.

\CR
\end{keyword}
```

**Chi tiết:**
- **Keywords tiếng Việt**: các keyword cách nhau bằng `;`, kết thúc bằng `.`
- **`\TD`**: tiêu đề tiếng Anh (viết HOA toàn bộ)
- **`\ABS`**: abstract tiếng Anh (viết liền 1 paragraph)
- **`\KW`**: keywords tiếng Anh, cách nhau bằng `;`, kết thúc bằng `.`
- **`\CR`**: đứng riêng 1 dòng trước `\end{keyword}`

---

## 3. Nội dung bài báo — Sections

### 3.1. Hierarchy
```
\section{...}                   % Mục lớn: 1., 2., 3.
  \subsection{...}              % Mục con: 2.1., 2.2.
    \subsubsection{...}         % Mục con con: a., b., c.
```
- **KHÔNG BAO GIỜ** dùng `\paragraph` hay `\subparagraph`
- Section đầu tiên thường là `Giới thiệu`
- Section cuối cùng thường là `Kết luận`
- Không có section `Acknowledgment` mặc định; nếu bài gốc có phần lời cảm ơn, dùng `\section*{Lời cảm ơn}` (không đánh số)

### 3.2. Tên section tiếng Việt phổ biến

| Tiếng Anh (latex-stce-en) | Tiếng Việt (latex-stce-vn) |
|---|---|
| Introduction | Giới thiệu |
| Conclusions | Kết luận |
| Acknowledgment | Lời cảm ơn |
| Methods | Phương pháp |
| Results and discussion | Kết quả và thảo luận |
| Literature review | Tổng quan |

### 3.3. Format `\subsubsection`
- Đánh số theo chữ cái: **a.**, **b.**, **c.** (do class `stce` tự định nghĩa)
- Tiêu đề `\subsubsection` thường in nghiêng (italic) — do class xử lý
- Khi chuẩn hóa: nếu bài gốc dùng bold/italic thủ công cho tiểu mục (ví dụ `\textbf{a.}` hoặc `\textit{a) Tên mục}`), phải chuyển thành `\subsubsection{Tên mục}` để class tự format

### 3.4. Spacing
- Giữa **mọi paragraph trong phần nội dung** phải có **đúng 1 dòng trống** (đây là cách LaTeX nhận biết đoạn mới).
- Đây là mục kiểm tra bắt buộc trước khi báo hoàn tất: phải rà toàn bộ file từ sau `\end{frontmatter}` đến trước bibliography, không chỉ kiểm tra một vài đoạn đầu.
- Không được để hai paragraph liên tiếp chỉ cách nhau một ký tự xuống dòng; phải có dòng trống thực sự.
- Không được gộp hai paragraph độc lập trên cùng một dòng nguồn.
- Trước `\section` nên có 2 dòng trống.
- Trước `\subsection` nên có 1 dòng trống.
- Trước `\subsubsection` nên có 1 dòng trống.
- Không có dòng trống thừa giữa heading và paragraph đầu tiên.
- Sau khi chuẩn hóa phải kiểm tra lại bằng cách rà các dòng văn bản liên tiếp và báo cáo riêng trạng thái paragraph spacing.

---

## 4. Equations

### 4.1. Display equations
```latex
\begin{equation}
... nội dung phương trình ...
\end{equation}
```
- Label đánh số trực tiếp nếu cần tham chiếu: `\label{1}`, `\label{2}`, `\label{3}`, ...
- **Nhiều biểu thức trong cùng một dòng** của phương trình: ngăn cách bằng `; \quad` (dấu chấm phẩy + khoảng trắng toán học)
- **Cuối phương trình KHÔNG có dấu câu** (không `.`, không `,`)

Ví dụ:
```latex
\begin{equation}
	{{H}_{i}}=\phi {{P}_{Ed}} ; \quad \phi ={{\phi }_{0}}{{\alpha }_{h}}{{\alpha }_{m}}; \qaud {{\phi }_{0}}={1}/{200}
\end{equation}
```

> [!NOTE]
> **Khác biệt so với bản tiếng Anh:** Bài tiếng Việt **KHÔNG** bắt buộc dùng dòng `%` trước/sau `\begin{equation}` và `\end{equation}`. Tuy nhiên nếu bài gốc có thì giữ nguyên.

### 4.2. Inline math
- **Bắt buộc**: Tất cả ký hiệu toán học, biến, toán tử, hàm số học, số mũ/chỉ số, ký hiệu Hy Lạp, và các đơn vị dạng toán học phải được đặt trong môi trường math mode (ví dụ `$ ... $`) ngay cả khi chúng đứng độc lập trong câu (ví dụ `$x$`, `$L$`, `$C_p$`, `$t$`).
- Dùng `$...$` cho biến đơn hoặc biểu thức ngắn
- Mô tả biến ngay sau equation: `trong đó $X$ là ...; $Y$ là ...; $Z$ là ...`

### 4.3. Ký hiệu đặc biệt
- Dấu ngang dài (en-dash) trong text: `--` (ví dụ: `load--settlement`)
- Khoảng `~` dùng trước `\cite`, `\ref`, `(\ref{...})`
- **Đơn vị đo lường**: vì template đã nạp `siunitx`, ưu tiên cú pháp gọn `giá trị~\si{đơn vị}`; dùng `\SI{giá trị}{đơn vị}` khi cần siunitx định dạng cả giá trị. Ví dụ: `55,0~\si{\milli\metre}`, `140~\si{\micro\metre}`, `\SI{55,0}{\milli\metre}`, `\si{\kilogram\per\metre\cubed}`, `\si{\ohm}`.
  - Với `\si` đứng sau một số, dùng `~` trước `\si` để tạo khoảng trắng không ngắt dòng; `\SI` tự xử lý khoảng cách.
  - Chỉ dùng dạng thủ công có `~` (ví dụ `55~mm`, `37~$^\circ$C`) khi không thể dùng `siunitx` hoặc khi tương thích đặc biệt với macro/template; tuyệt đối không viết dính `55mm` hoặc dùng khoảng trắng thường giữa số và đơn vị.
- **Công thức hóa học**: LUÔN dùng `\ce{}` (package `mhchem`), KHÔNG dùng subscript/superscript thủ công
  - Ví dụ: `\ce{H2SO4}`, `\ce{CO2}`, `\ce{NaOH}`
  - Sai: `H$_2$SO$_4$`, `CO$_2$`
- **Tên loài/chi/họ khoa học**: LUÔN in nghiêng bằng `\textit{}` theo quy chuẩn danh pháp khoa học
- **Dấu phẩy thập phân**: bài tiếng Việt dùng **dấu phẩy** `,` làm dấu thập phân (ví dụ: `0,12`, `1,3`, `9,80`). Dùng `\,!` để bỏ khoảng trắng trong math mode nếu cần: `$0,\!12g$`
- **Dấu phẩy thập phân trong math mode**: LaTeX mặc định hiểu dấu `,` là dấu phân cách (có khoảng trắng sau). Để viết số thập phân đúng trong `$...$`, **PHẢI** dùng `{,}` thay vì `,`
  - Đúng: `$1{,}5$`, `$0{,}12$`, `${{\\gamma}_{I}} = 1{,}0$`
  - Sai: `$1,5$` (sẽ có khoảng trắng thừa giữa `1` và `5`)
- **Tỷ lệ phần trăm**: viết `\%` sau số, ví dụ: `60\%`, `100\%`

### 4.4. Kiểm tra Unicode — thay bằng lệnh LaTeX

> [!CAUTION]
> Tác giả thường dùng ký tự Unicode trực tiếp thay vì lệnh LaTeX. **PHẢI** kiểm tra và thay thế tất cả ký tự Unicode bằng lệnh LaTeX tương ứng.

| Ký tự Unicode | Lệnh LaTeX thay thế |
|---|---|
| `×` (dấu nhân) | `$\times$` |
| `°` (độ) | `$^\circ$` |
| `−` (dấu trừ dài) | `$-$` hoặc `-` |
| `–` (en-dash) | `--` |
| `—` (em-dash) | `---` |
| `≤` | `$\le$` hoặc `$\leq$` |
| `≥` | `$\ge$` hoặc `$\geq$` |
| `±` | `$\pm$` |
| `≈` | `$\approx$` |
| `≠` | `$\neq$` |
| `∞` | `$\infty$` |
| `→` | `$\to$` hoặc `$\rightarrow$` |
| `Δ` | `$\Delta$` |
| `α, β, γ, φ, σ, ε, λ, μ, ρ, θ, ω` ... | `$\alpha$`, `$\beta$`, `$\gamma$`, `$\varphi$`, `$\sigma$`, `$\varepsilon$`, `$\lambda$`, `$\mu$`, `$\rho$`, `$\theta$`, `$\omega$` ... |
| `²`, `³` (superscript) | `$^2$`, `$^3$` |
| `₁`, `₂` (subscript) | `$_1$`, `$_2$` |
| `'`, `'` (smart quotes) | `\`{}`, `'` |
| `"`, `"` (smart double quotes) | ` \`{}\`{} `, `''` |

---

## 5. Figures

### 5.1. Figure đơn
```latex
\begin{figure}[ht!]\centering
	\includegraphics[width=.7\textwidth]{Figures/\id/FN}
	\caption{Mô tả hình}\label{fN}
\end{figure}
```

### 5.2. Figure đôi (subfigure)
```latex
\begin{figure}[ht!]\centering
	\subfigure[]{\includegraphics[height=0.38\textwidth]{Figures/\id/FNa}}
	\hfill
	%\qquad
	\subfigure[]{\includegraphics[height=0.38\textwidth]{Figures/\id/FNb}}
	\caption{Caption tổng}\label{fN}
\end{figure}
```
- Mặc định dùng `height` để đồng đều chiều cao cho subfigure
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
- **Tham chiếu (tiếng Việt)**: `Hình~\ref{fN}` (KHÔNG dùng `Fig.~\ref{fN}`)
- **Tham chiếu subfigure**: dùng ngoặc `()`, ví dụ `Hình~\ref{fN}(a)`, `Hình~\ref{fN}(b)` — KHÔNG viết `Hình~\ref{fN}a`
- Placement: luôn dùng `[ht!]`
- Width phổ biến: `.7\textwidth` (đơn), `0.38\textwidth` height (đôi)
- **LUÔN** giữ dòng `%\qquad` comment sẵn trong subfigure để có thể bỏ comment khi cần thay `\hfill`
- **Caption KHÔNG kết thúc bằng dấu `.`**

---

## 6. Tables

### 6.1. Cấu trúc table chuẩn
```latex
\begin{table}[ht!]\caption{Mô tả bảng}\label{tN}
	%\tabcolsep = 4.65mm
	%\fontsize{9}{11} \selectfont
	%\renewcommand*\arraystretch{1.2}
	\begin{tabularx}{\textwidth}{ccccccccccccccccccc}\toprule
\lll{1}{Cột 1} & \lll{1}{Cột 2} & \lll{1}{Cột 3} \\\midrule
Dòng 1 & giá trị & giá trị \\
Dòng 2 & giá trị & giá trị \\
Dòng 3 & giá trị & giá trị \\
		\\\bottomrule\end{tabularx}
	%\vspace*{1mm}\fontsize{10}{12} \selectfont
\end{table}
```

### 6.2. Table macros đặc biệt

> [!IMPORTANT]
> **Bài tiếng Việt sử dụng thêm các macro viết tắt cho table:**
> - `\lll{1}{text}` cho hàng đầu tiên trong bảng



### 6.3. Quy tắc
- **LUÔN** dùng `tabularx` với `\textwidth`
- Dùng `\toprule`, `\midrule` (hoặc `\ML`), `\bottomrule` (booktabs style) — **KHÔNG** dùng `\hline`
- Label: `t1`, `t2`, ...
- **Tham chiếu (tiếng Việt)**: `Bảng~\ref{tN}` (KHÔNG dùng `Table~\ref{tN}`)
- `\caption` đặt **TRƯỚC** `tabularx`
- `\tabcolsep` tùy chỉnh khoảng cách cột
- Dòng cuối KHÔNG có `\\` mà viết `\\\bottomrule\end{tabularx}`
- Placement: `[ht!]`
- **KHÔNG** thêm space/padding thừa để căn cột. Giữ code bảng **compact**, dễ đọc
- **Cột số**: dùng column type `S` (package `siunitx`) nếu cần **dóng hàng theo dấu**. Header của cột `S` phải wrap trong `{...}`
- **LUÔN** giữ các dòng comment sẵn (`%\tabcolsep`, `%\fontsize`, `%\renewcommand*\arraystretch`, `%\vspace`) trong mỗi table — để có thể bỏ comment khi cần tùy chỉnh
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
- Dùng khoảng trắng sau dấu phẩy trong text gốc: `\cite{1, 2}` (giữ nguyên spacing của gốc)

### 7.2. Bibliography
```latex
\bibliographystyle{STCE/stce}
\bibliography{Bib/XXXX}
```
- File `.bib` đặt trong thư mục `Bib/`
- Tên file `.bib` trùng với mã bài `\id`

---

## 8. Tham chiếu tiếng Việt

> [!IMPORTANT]
> **Đây là điểm khác biệt quan trọng so với bản tiếng Anh.** Tất cả tham chiếu phải viết bằng tiếng Việt.

| Loại | Tiếng Anh (latex-stce-en) | Tiếng Việt (latex-stce-vn) |
|---|---|---|
| Hình | `Fig.~\ref{fN}` | `Hình~\ref{fN}` |
| Bảng | `Table~\ref{tN}` | `Bảng~\ref{tN}` |
| Phương trình | `Eq.~(\ref{N})` | (không bắt buộc viết tắt — ghi trực tiếp hoặc dùng cách diễn đạt tự nhiên) |
| Section | `Section~\ref{...}` | `Mục~\ref{...}` |

---

## 9. Quy trình chuẩn hóa file LaTeX

Khi được yêu cầu chuẩn hóa file LaTeX theo STCE tiếng Việt, thực hiện theo các bước:

1. **Kiểm tra preamble**: đúng documentclass, packages (`\usepackage{STCE/stce}`), `\id`
2. **Kiểm tra frontmatter**: đủ và đúng thứ tự các thành phần (doi, title VIẾT HOA, author, cortext tiếng Việt, shortauth, mailauth, headershort với "và cs.", address tiếng Việt, received, abstract tiếng Việt, keyword block song ngữ với TD/ABS/KW/CR)
3. **Chuẩn hóa sections**: đúng hierarchy, spacing, tên section tiếng Việt
4. **Chuẩn hóa equations**: format label, tham chiếu
5. **Chuẩn hóa figures**: đường dẫn, label, placement, width, tham chiếu `Hình~\ref{}`
6. **Chuẩn hóa tables**: tabularx, booktabs/`\ML`, `\rrr`/`\lll`, label, tham chiếu `Bảng~\ref{}`
7. **Chuẩn hóa citations**: format `\cite`, kiểm tra `~` spacing
8. **Kiểm tra kết thúc**: bibliography, `\end{document}`

### Lưu ý quan trọng
- **LUÔN backup** file trước khi chỉnh sửa
- Thực hiện **từng bước**, commit sau mỗi nhóm thay đổi
- Kiểm tra **compile** sau mỗi lần chỉnh sửa lớn
- Với file lớn (>500 dòng), làm **incremental** để tránh memory error
- **LUÔN đọc trực tiếp file** (`view_file`) để kiểm tra nội dung — **KHÔNG** dùng `grep`, `findstr`, `Select-String` hay bất kỳ lệnh tìm kiếm nào
- **KHÔNG** tạo script sửa nhanh (sed, PowerShell replace, python script...) — luôn dùng tool chỉnh sửa file trực tiếp

---

## 10. Tổng hợp khác biệt latex-stce-vn và latex-stce-en

| Đặc điểm | latex-stce-vn (Tiếng Việt) | latex-stce-en (Tiếng Anh) |
|---|---|---|
| Package / Proof status | Giống nhau | Giống nhau |
| Title | **VIẾT HOA** toàn bộ | Title case |
| Cortext | `Tác giả đại diện. \textit{Địa chỉ e-mail:}` | `Corresponding author.~\textit{E-mail address:}` |
| Corref key | `\corref{cor1}` | `\corref{cor}` |
| Headershort | `và cs.` | `\textit{et al.}` |
| Keyword block | Keywords VN + `\TD` + `\ABS` + `\KW` + `\CR` | Keywords EN + `\CR` |
| Dấu thập phân | Dấu phẩy `,` | Dấu chấm `.` |
| Tham chiếu hình | `Hình~\ref{}` | `Fig.~\ref{}` |
| Tham chiếu bảng | `Bảng~\ref{}` | `Table~\ref{}` |
| Section names | Tiếng Việt | Tiếng Anh |
| Acknowledgment | `\section*{Lời cảm ơn}` (nếu có) | `\section*{Acknowledgment}` |
| Equation `%` | Không bắt buộc | Bắt buộc `%` trước/sau |
| Table macro | `\ML`, `\p{}`, `\rrr{}` | `\midrule`, `\lll{}` |
