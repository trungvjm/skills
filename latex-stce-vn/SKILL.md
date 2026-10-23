---
name: latex-stce-vn
description: Chuẩn hóa file LaTeX theo template STCE tiếng Việt (Tạp chí KHCN Xây dựng - bản tiếng Việt)
---

# LaTeX-STCE Skill

Skill chuẩn hóa file LaTeX theo đúng template của tạp chí **STCE — Tạp chí Khoa học Công nghệ Xây dựng** (bản tiếng Việt), Đại học Xây dựng Hà Nội — HUCE.

> [!IMPORTANT]
> Skill này dành cho **bài báo tiếng Việt**. Đối với bài báo tiếng Anh, sử dụng skill **latex-stce-en**.

Template chuẩn được lấy từ file `01_3330_Dinh Van Thuat.tex`.

## Danh mục mã quy tắc — bắt buộc đọc trước khi thực hiện

1. Đọc [RULES.md](RULES.md): mỗi quy tắc có một mã duy nhất, mức yêu cầu, nguồn và cách kiểm chứng.
2. Đọc [CONFLICTS.md](CONFLICTS.md): phân biệt mâu thuẫn trực tiếp, ví dụ sai và điều kiện chưa rõ.
3. Bản chụp nguyên trạng trước khi đánh mã là [SKILL.before-rule-ids.md](SKILL.before-rule-ids.md), chỉ dùng đối chiếu lịch sử.

Các mục bên dưới giữ hướng dẫn và ví dụ chi tiết. Khi một nội dung lặp lại ở phần hướng dẫn, checklist và bảng tổng hợp, dùng **cùng mã** trong RULES.md; không coi đó là ba quy tắc độc lập.

**Quyết định đã chốt:** C01 dùng Sentence case; C02 lấy tác giả đầu tiên; C03 viết tắt cộng sự thành cs. và bỏ dấu chấm cuối caption; C04 báo người dùng nếu abstract có nhiều đoạn, không tự gộp; C07 dùng đơn vị thủ công; C10 dùng `{,}` cho dấu phẩy thập phân trong math mode; C11 có một dấu cách sau mỗi dấu phẩy giữa các key cite (`\cite{1, 2, 3}`); C16 lấy số cột theo bảng thực tế. Không hỏi lại các lựa chọn này. C14 là mô tả kỹ thuật về macro của template, không phải lựa chọn ngôn ngữ Việt/Anh.

### Các quy tắc đã được người dùng xác nhận

- **STCE-VN-TXT-001:** `và cộng sự` / `cùng cộng sự` → `và cs.` trong nội dung.
- **STCE-VN-FIG-012:** viết hoa chữ cái đầu của từng subcaption; giữ nhãn panel `(a)`, `(b)` ở chữ thường.
- **STCE-VN-EQ-005:** không có dòng trống ngay trước môi trường `equation`.
- **STCE-VN-FRONT-003:** tiêu đề tiếng Việt dùng Sentence case.
- **STCE-VN-FRONT-012:** từ ba tác giả trở lên, headershort lấy tác giả đầu tiên + `và cs.`.
- **STCE-VN-FIG-013 / STCE-VN-TAB-013:** bỏ dấu chấm cuối caption hình/bảng; đây là ngoại lệ biên tập được phép.
- **STCE-VN-FRONT-019 / STCE-VN-FRONT-023:** abstract nhiều đoạn phải giữ nguyên và báo người dùng, không tự gộp.
- **STCE-VN-UNIT-001:** đơn vị thông thường trình bày thủ công; siunitx chỉ là ngoại lệ cho ký hiệu/prefix đặc biệt.

### Tra nhóm mã

| Phần hướng dẫn | Nhóm mã trong RULES.md |
|---|---|
| Phạm vi và bảo toàn nội dung | `STCE-VN-CORE-*` |
| Sao lưu, ghi nhận thay đổi | `STCE-VN-BACKUP-*` |
| Template và cấu trúc tài liệu | `STCE-VN-TPL-*` |
| Frontmatter và metadata | `STCE-VN-FRONT-*` |
| Sections và paragraph | `STCE-VN-SEC-*` |
| Phương trình và math mode | `STCE-VN-EQ-*` |
| Đơn vị | `STCE-VN-UNIT-*` |
| Ký tự, chữ và cách viết | `STCE-VN-TXT-*` |
| Hình và subcaption | `STCE-VN-FIG-*` |
| Bảng | `STCE-VN-TAB-*` |
| Trích dẫn và bibliography | `STCE-VN-REF-*` |
| Kiểm chứng và bàn giao | `STCE-VN-QA-*` |
| Cách thực hiện và công cụ | `STCE-VN-WORK-*` |

### Điều kiện ghi nhận kết quả

Với từng quy tắc áp dụng, báo cáo `mã | PASS/FAIL/N/A/BLOCKED | file:dòng hoặc trang PDF | bằng chứng`. `N/A` phải có lý do; chưa kiểm chứng không được ghi `PASS`. Biên dịch thành công không thay thế kiểm tra nội dung hoặc định dạng; nhận xét chung của reviewer cũng không thay thế kiểm tra từng mã. Danh mục này **chưa phải validator/linter tự động**.

---

> [!CAUTION]
> ## ⚠️ QUY TẮC TỐI THƯỢNG — SUPREME RULE ⚠️
>
> **TUYỆT ĐỐI KHÔNG ĐƯỢC THAY ĐỔI NỘI DUNG GỐC.**
>
> Quy tắc này có **hiệu lực cao nhất**, vượt trên mọi quy tắc khác.
>
> **Phạm vi ngoại lệ biên tập (C01/C03):** bảo toàn ý nghĩa/nội dung khoa học; vẫn chuẩn hóa Sentence case cho tiêu đề tiếng Việt (`STCE-VN-FRONT-003`), viết tắt cộng sự (`STCE-VN-TXT-001`), viết hoa đầu subcaption (`STCE-VN-FIG-012`) và bỏ dấu chấm cuối caption hình/bảng (`STCE-VN-FIG-013`, `STCE-VN-TAB-013`). Không lấy các ngoại lệ này làm quyền viết lại câu, thay số hoặc đổi ký hiệu.
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

**Nguyên tắc cốt lõi:** giữ nguyên nội dung khoa học, từ ngữ và ý nghĩa của bản gốc; chỉ thay đổi biểu diễn LaTeX và các ngoại lệ biên tập đã được xác nhận ở trên.

**ĐƯỢC PHÉP:**
- Đổi `[1, 2]` → `~\cite{1, 2}` (format citation; C11 đã chốt).
- Đổi `Hình 1` → `Hình~\ref{f1}` (format reference)
- Đổi `stress- strain` → `stress-strain` (sửa typo khoảng cách)
- Đổi raw text heading → `\section{...}` (format heading)
- Đổi raw table → `\begin{table}...\end{table}` (format table)
- Chuẩn hóa ký hiệu độ chỉ khi đã xác định được giá trị gốc. Chuỗi `300C` không đủ bằng chứng để tự đổi thành `30~$^\circ$C` (C06; `STCE-VN-CORE-002`, `STCE-VN-CORE-009`).
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
\title{Tiêu đề bài báo tiếng Việt}
```
- **Tiêu đề bài tiếng Việt viết thường kiểu Sentence case, chỉ viết Hoa các từ bắt buộc phải viết hoa**

**C01 — đã chốt:** dùng Sentence case (`STCE-VN-FRONT-003`); chỉ viết hoa chữ đầu và tên riêng/từ viết tắt cần giữ hoa. Không chuyển toàn bộ tiêu đề tiếng Việt sang HOA; quy tắc tiêu đề tiếng Anh sau `\TD` không thay đổi.

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
\headershort{Đạt, N. T., và cs.} % tác giả đầu tiên Nguyễn Thành Đạt, khi có >2 tác giả
```

> [!IMPORTANT]
> **Khác biệt so với bản tiếng Anh:**
> - `\cortext`: dùng `Tác giả đại diện. \textit{Địa chỉ e-mail:}` thay vì `Corresponding author.~\textit{E-mail address:}`
> - `\headershort`: dùng `và cs.` thay vì `\textit{et al.}`
> - `\corref{cor1}` thay vì `\corref{cor}`

**Quy tắc `\headershort`:**
- **1 tác giả**: ghi tên viết tắt tác giả đó, ví dụ: `\headershort{Thuật, Đ. V.}`
- **2 tác giả**: ghi đủ tên viết tắt cả 2, ví dụ: `\headershort{Thuật, Đ. V., Đức, H. N.}`
- **Từ 3 tác giả trở lên** (`STCE-VN-FRONT-012`): ghi tên tác giả đầu tiên + `và cs.`, ví dụ với danh sách tác giả ở trên: `\headershort{Đạt, N. T., và cs.}`.

**C02 — đã chốt:** headershort lấy tác giả đầu tiên, không lấy tác giả liên hệ thay thế. `\shortauth` và `\mailauth` vẫn thuộc tác giả liên hệ.

> `shortauth` dùng ở footnote trang đầu; `headershort` dùng ở running header và bắt đầu từ tác giả đầu tiên theo số lượng tác giả ở trên. Giữ phân biệt đã có trên GitHub (`STCE-VN-FRONT-009–012`).

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
... (giữ nguyên tóm tắt nguồn; nếu có nhiều đoạn thì báo người dùng, không tự gộp)
\end{abstract}
```

**C04 / STCE-VN-FRONT-019:** nếu abstract nguồn có nhiều đoạn, giữ nguyên các đoạn và báo người dùng số đoạn/vị trí để xin quyết định; không tự gộp, cắt hoặc viết lại cho thành một paragraph.

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
- **`\ABS`** (`STCE-VN-FRONT-023`): abstract tiếng Anh thường là một paragraph; nếu nguồn có nhiều đoạn thì giữ nguyên và báo người dùng, không tự gộp.
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
- **STCE-VN-EQ-005:** không có dòng trống ngay trước `\begin{equation}`.
- **STCE-VN-EQ-006:** sau equation có đúng một dòng trống nếu đoạn tiếp theo bắt đầu chữ hoa; không có dòng trống nếu phần tiếp theo bắt đầu chữ thường.

Ví dụ:
```latex
\begin{equation}
	{{H}_{i}}=\phi {{P}_{Ed}} ; \quad \phi ={{\phi }_{0}}{{\alpha }_{h}}{{\alpha }_{m}}; \quad {{\phi }_{0}}={1}/{200}
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
- **Đơn vị đo lường — C07 đã chốt (`STCE-VN-UNIT-001`):** đơn vị thông thường trình bày thủ công đúng bản gốc trong math mode, dùng `\mathrm{}` và dấu `/` gõ tay, ví dụ `55~$\mathrm{mm}$`, `$U=5{,}5~\mathrm{W/m^2/K}$`, `25~$\mathrm{m^3/h}/\text{người}$`, `\mathrm{kWh/m^2}/\text{năm}`. Chỉ dùng `siunitx` khi cần ký hiệu/prefix đặc biệt như `\micro`, ví dụ `$50~\si{\micro\gram}/\mathrm{m^3}$`; không chuyển đơn vị thông thường sang `\si{}`/`\SI{}` chỉ vì template đã nạp package này.
  - Giữ nguyên cách viết và slash của nguồn nếu rõ nghĩa. Với nhiều mẫu số, vẫn dùng biểu diễn thủ công theo nguồn, ví dụ `\mathrm{W/m^2/K}`; không bắt buộc đổi thành một `\si{}` chứa nhiều `\per`. Với từ tiếng Việt trong mẫu số, dùng text, ví dụ `\mathrm{K}/\text{phút}` hoặc `\mathrm{cm^3}/\text{vòng}`. Khi thực sự dùng siunitx cho trường hợp đặc biệt, không trộn các cách viết làm mơ hồ đơn vị; không đặt `per-mode` toàn cục nếu người dùng chưa yêu cầu và chưa kiểm tra mọi đơn vị ghép.
  - Với `\si` đứng sau một số, dùng `~` trước `\si` để tạo khoảng trắng không ngắt dòng; `\SI` tự xử lý khoảng cách.
  - Cách thủ công là mặc định cho đơn vị thông thường, không chỉ là phương án khi siunitx thất bại. Giữa số và đơn vị có khoảng cách không ngắt dòng theo cách biểu diễn đã chọn, ví dụ `55~$\mathrm{mm}$`, `37~$^\circ$C`; không viết dính `55mm` hoặc chỉ dùng khoảng trắng thường.
  - **Bắt buộc kiểm chứng đầu ra PDF:** quy tắc này áp dụng cho **mọi đơn vị**, đặc biệt đơn vị tùy chỉnh/không phải SI và đơn vị trong mẫu số. Khi chuyển sang `\si{}`/`\SI{}`, chỉ chuẩn hóa cú pháp, phải giữ nguyên cách viết, ký hiệu và ngôn ngữ hiển thị của bản gốc. Với **mọi đơn vị**, phải đối chiếu trực tiếp `_original.tex`: cách viết, ký hiệu, dấu phân cách và ngôn ngữ của tác giả quyết định đầu ra, không theo tên macro của `siunitx`. Nếu bản gốc không rõ hoặc đầu ra dự kiến có bất kỳ sai khác nào, **phải hỏi user quyết định trước khi sửa**; không tự suy diễn hay tự chọn cách biểu diễn. **Tuyệt đối không dịch hoặc đổi đơn vị sang tiếng Anh** (ví dụ `người` → `person`, `giờ` → `hour`, `năm` → `year`, `vòng` → `revolution`) nếu user chưa yêu cầu rõ ràng. Tên macro không tự dịch đơn vị: `\DeclareSIUnit{\person}{person}` làm `\person` in thành `person`, không phải `người`; để in tiếng Việt trong `siunitx`, khai báo dạng text, ví dụ `\DeclareSIUnit{\person}{\text{người}}`. Với từng đơn vị tùy chỉnh, phải kiểm tra `\DeclareSIUnit` và biên dịch/xem PDF trước khi chấp nhận thay đổi.
- **Công thức hóa học**: LUÔN dùng `\ce{}` (package `mhchem`), KHÔNG dùng subscript/superscript thủ công
  - Ví dụ: `\ce{H2SO4}`, `\ce{CO2}`, `\ce{NaOH}`
  - Sai: `H$_2$SO$_4$`, `CO$_2$`
- **Tên loài/chi/họ khoa học**: LUÔN in nghiêng bằng `\textit{}` theo quy chuẩn danh pháp khoa học
- **Dấu phẩy thập phân**: phần tiếng Việt dùng dấu phẩy, giữ nguyên giá trị số; phần abstract tiếng Anh và chuỗi định danh/DOI theo quy tắc riêng, không đổi dấu máy móc.
- **STCE-VN-TXT-006 / C10 đã chốt:** dấu phẩy thập phân trong math mode viết bằng `{,}`; không dùng dấu phẩy trần hoặc cách chèn khoảng trắng âm để thay quy tắc này. Không đổi dấu phân cách vector/danh sách hoặc dấu phẩy giữa key cite thành dấu thập phân.
  - Đúng: `$1{,}5$`, `$0{,}12$`, `$\gamma_I = 1{,}0$`
  - Sai: `$1,5$` (sẽ có khoảng trắng thừa giữa `1` và `5`)
- **Tỷ lệ phần trăm**: viết `\%` sau số, ví dụ: `60\%`, `100\%`
- **Dấu ngoặc kép trong văn bản**: KHÔNG giữ dấu ngoặc kép ASCII `"` hoặc Unicode `“` / `”` trong source. Phải dùng hai dấu grave accent để mở và hai apostrophe để đóng, theo ví dụ bắt buộc bên dưới.

```latex
% Đúng
Hiện tượng ``giật khi dừng xe'' xuất hiện khi xe dừng hẳn.

% Sai
Hiện tượng "giật khi dừng xe" xuất hiện khi xe dừng hẳn.
```

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
| `‘` / `’` (smart single quotes) | một grave accent (mở) / một apostrophe (đóng) |
| `“` / `”` (smart double quotes), ASCII `"` | hai grave accent (mở) / hai apostrophe (đóng); xem ví dụ trên |

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
- **STCE-VN-FIG-012:** viết hoa chữ cái đầu nội dung mỗi subcaption (ví dụ `Phân bố nhiệt độ`); không viết hoa nhãn panel `(a)`, `(b)`.

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
- **STCE-VN-FIG-013 / C03 đã chốt:** bỏ dấu chấm kết thúc caption hình và subcaption; giữ nguyên nội dung còn lại.

---

## 6. Tables

### 6.1. Cấu trúc table chuẩn

**STCE-VN-TAB-014 / C16 đã chốt:** số cột và kiểu cột phải theo từng bảng thực tế của bài, không cố định theo template. Ví dụ dưới minh họa bảng ba cột bằng `{Xcc}`; khi đổi cấu trúc phải sửa cả khai báo cột, header và các hàng dữ liệu, có tính các ô gộp multicolumn.

```latex
\begin{table}[ht!]\caption{Mô tả bảng}\label{tN}
	%\tabcolsep = 4.65mm
	%\fontsize{9}{11} \selectfont
	%\renewcommand*\arraystretch{1.2}
	\begin{tabularx}{\textwidth}{Xcc}\toprule
\lll{1}{Cột 1} & \lll{1}{Cột 2} & \lll{1}{Cột 3} \\\midrule
Dòng 1 & giá trị & giá trị \\
Dòng 2 & giá trị & giá trị \\
Dòng 3 & giá trị & giá trị \\
		\bottomrule\end{tabularx}
	%\vspace*{1mm}\fontsize{10}{12} \selectfont
\end{table}
```

### 6.2. Table macros đặc biệt

**STCE-VN-TAB-002 / STCE-VN-TAB-003 — C14:** macro là lệnh viết tắt phụ thuộc template, không phân loại theo bài Việt/Anh. Phải đọc định nghĩa trước khi dùng. Trong mẫu tháng 10 đã đối chiếu:

| Lệnh | Vai trò |
|---|---|
| `\lll{n}{text}` | Gộp ngang n cột, căn giữa, cho phép xuống dòng trong ô; thường dùng header với n = 1. |
| `\rrr{n}{c}{text}` | Gộp dọc n hàng, căn nội dung giữa theo định nghĩa multirow/makecell của mẫu. |
| `\p{text}` | Giữ khoảng trống có kích thước của text nhưng không in text (phantom). |
| `\toprule`, `\midrule`, `\bottomrule` | Đường kẻ trên/giữa/dưới theo booktabs. |
| `\ML` | Không mặc định có sẵn; chỉ dùng khi template thực sự định nghĩa và đã kiểm tra đúng chức năng. |



### 6.3. Quy tắc
- Bảng một trang dùng `tabularx` với `\textwidth`; bảng dài nhiều trang dùng `xltabular` theo §6.4 (`STCE-VN-TAB-001`).
- Dùng `\toprule`, `\midrule`, `\bottomrule` (booktabs style), không dùng `\hline`. Chỉ dùng `\ML` khi đã đọc định nghĩa trong template và xác nhận đúng vai trò đường kẻ thay thế; không tự giả định macro này tồn tại.
- Label: `t1`, `t2`, ...
- **Tham chiếu (tiếng Việt)**: `Bảng~\ref{tN}` (KHÔNG dùng `Table~\ref{tN}`)
- Với bảng một trang, `\caption` đặt **TRƯỚC** `tabularx`; bảng dài có caption đầu môi trường `xltabular` theo §6.4.
- `\tabcolsep` tùy chỉnh khoảng cách cột
- Với bảng một trang, hàng dữ liệu cuối kết thúc bằng `\\`; dòng kế tiếp viết `\bottomrule\end{tabularx}`, không thêm hàng trắng. Bảng dài dùng footer ở §6.4.
- Float bảng một trang dùng `[ht!]`; `xltabular` không bọc float.
- **KHÔNG** thêm space/padding thừa để căn cột. Giữ code bảng **compact**, dễ đọc
- Khi cần căn số theo dấu thập phân, dùng cột `S`; có thể khai báo `S[table-format=M.N]`. Header bọc trong `{...}` hoặc `\multicolumn{1}{c}{...}`; ô không phải số như `-` phải viết `{-}` (`STCE-VN-TAB-011/015/016`). `M.N` là cú pháp cấu hình, không phải số thập phân trong nội dung; dữ liệu tiếng Việt vẫn theo quy tắc dấu phẩy.
- **LUÔN** giữ các dòng comment sẵn (`%\tabcolsep`, `%\fontsize`, `%\renewcommand*\arraystretch`, `%\vspace`) trong mỗi table — để có thể bỏ comment khi cần tùy chỉnh
- **STCE-VN-TAB-013 / C03 đã chốt:** bỏ dấu chấm kết thúc caption bảng; giữ nguyên nội dung còn lại.

### 6.4. Bảng dài nhiều trang — giữ hướng dẫn đã có trên GitHub

Nguồn: `trungvjm/skills` tại `c00d465`, §6.4. Mã mới `STCE-VN-TAB-017–023`; thêm `\usepackage{xltabular}` ở preamble khi dùng bảng dài, đặt `xltabular` trực tiếp, **không bọc `table`**.

Ví dụ tám cột chỉ minh họa: số cột, header và mọi hàng phải theo dữ liệu thực tế (`STCE-VN-TAB-014`).

```latex
%\tabcolsep = 3.5mm
%\fontsize{9}{11} \selectfont
%\renewcommand*\arraystretch{1.2}
\begin{xltabular}{\textwidth}{*8{>{\centering\arraybackslash}X}}
\caption{Mô tả bảng dài}\label{tN} \\
\toprule
\lll{1}{Cột 1} & \lll{1}{Cột 2} & \lll{1}{Cột 3} & \lll{1}{Cột 4} & \lll{1}{Cột 5} & \lll{1}{Cột 6} & \lll{1}{Cột 7} & \lll{1}{Cột 8} \\
\midrule
\endfirsthead
\toprule
\lll{1}{Cột 1} & \lll{1}{Cột 2} & \lll{1}{Cột 3} & \lll{1}{Cột 4} & \lll{1}{Cột 5} & \lll{1}{Cột 6} & \lll{1}{Cột 7} & \lll{1}{Cột 8} \\
\midrule
\endhead
\midrule
\endfoot
\bottomrule
\endlastfoot
Dòng 1 & giá trị & giá trị & giá trị & giá trị & giá trị & giá trị & giá trị \\
Dòng cuối & giá trị & giá trị & giá trị & giá trị & giá trị & giá trị & giá trị \\
\end{xltabular}
%\vspace*{1mm}\fontsize{10}{12} \selectfont
```

- `STCE-VN-TAB-019`: caption/label ở đầu bảng, hàng caption kết thúc bằng `\\`.
- `STCE-VN-TAB-020`: trang sau không lặp caption hay thêm “Bảng... (tiếp theo)”; chỉ lặp header cột giữa `\toprule`/`\midrule` trước `\endhead`.
- `STCE-VN-TAB-021–022`: chân trang giữa dùng `\midrule\endfoot`; chân trang cuối dùng `\bottomrule\endlastfoot`.
- `STCE-VN-TAB-023`: ưu tiên `X` hoặc `*N{>{\centering\arraybackslash}X}` để tổng rộng theo `\textwidth`; N là số cột thực tế.


---

## 7. Citations & Bibliography

### 7.1. In-text citations
```latex
\cite{1, 2, 3}        % nhiều citations ghép chung; một dấu cách sau mỗi dấu phẩy
\cite{11}             % citation đơn
```
- Dùng `~` trước `\cite`: `text~\cite{N}`
- Số citation là key trong file `.bib`
- **STCE-VN-REF-005 / C11 đã chốt:** đặt đúng một dấu cách sau mỗi dấu phẩy giữa các key cite, ví dụ `\cite{1, 2}` hoặc `\cite{1, 2, 3}`; không có khoảng trắng trước dấu phẩy. Chuẩn hóa khoảng trắng dù nguồn dùng kiểu khác; giữ nguyên key và thứ tự key.

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

1. **Kiểm tra preamble** (`STCE-VN-TPL-002`–`010`): documentclass `STCE/stce`, package `STCE/stce_proof`, input `STCE/stce_package`, proof status và `\id`; không tự bật dòng package đang comment trong mẫu (C05).
2. **Kiểm tra frontmatter** (`STCE-VN-FRONT-*` đang áp dụng): đúng metadata và thứ tự; tiêu đề tiếng Việt Sentence case; headershort lấy tác giả đầu tiên; abstract nhiều đoạn được báo người dùng và không tự gộp; keyword block song ngữ đủ TD/ABS/KW/CR.
3. **Chuẩn hóa sections**: đúng hierarchy, spacing, tên section tiếng Việt
4. **Chuẩn hóa equations**: format label, tham chiếu
5. **Chuẩn hóa figures**: đường dẫn, label, placement, width, tham chiếu `Hình~\ref{}`
6. **Chuẩn hóa tables**: tabularx, booktabs/`\ML`, `\rrr`/`\lll`, label, tham chiếu `Bảng~\ref{}`
7. **Chuẩn hóa citations**: format `\cite`, kiểm tra `~` spacing
8. **Kiểm tra kết thúc**: bibliography, `\end{document}`

### 9.1. Checklist bắt buộc sau khi chuẩn hóa

Chỉ báo hoàn tất khi đã kiểm tra và ghi nhận kết quả cho toàn bộ các mục sau:

- [ ] **Backup**: file `_original.tex` và `_original.bib` tồn tại; không bị ghi đè.
- [ ] **Đối chiếu nội dung gốc**: đọc trực tiếp toàn bộ `_original.tex` và file đã chuẩn hóa theo từng khối; đối chiếu frontmatter, từng paragraph, caption, bảng, phương trình, citation và bibliography. Ghi rõ dòng gốc → dòng mới cho mọi nội dung bị thêm, bỏ hoặc đổi nghĩa; chỉ kết luận đạt khi không còn thay đổi chưa được user phê duyệt. Mọi điểm nghi ngờ phải báo tác giả, không tự suy diễn hoặc sửa.
- [ ] **Preamble/template**: documentclass, package, proof status, `\id`, volume, DOI và bibliography đúng chuẩn.
- [ ] **Math mode**: không còn biến, chỉ số, số mũ, ký hiệu Hy Lạp, dấu toán học hoặc dấu trừ viết ngoài math mode.
- [ ] **Đồng nhất ký hiệu**: đối chiếu mọi lần xuất hiện của từng ký hiệu trong văn bản, phương trình, bảng, caption và tham chiếu; kiểm tra chính xác chữ hoa/thường, ký tự Hy Lạp, chỉ số dưới/trên, dấu mũ, gạch trên và đơn vị. Ghi rõ mọi khác biệt; chỉ sửa khi bản gốc hoặc user xác nhận ý nghĩa, không tự đoán ký hiệu thiếu.
- [ ] **Đơn vị và số** (`STCE-VN-UNIT-*` đang áp dụng, `STCE-VN-TXT-005`–`010`): đơn vị thông thường dùng math mode và `\mathrm{}` thủ công; giữ nguyên slash, cách viết/ngôn ngữ nguồn và kiểm tra PDF; chỉ dùng siunitx cho ký hiệu/prefix đặc biệt. Số thập phân tiếng Việt trong math dùng `{,}`; không còn đơn vị viết dính hoặc Unicode toán chưa xử lý.
- [ ] **Paragraph**: giữa các paragraph có đúng một dòng trống; heading có spacing đúng quy định; không gộp hoặc tách sai paragraph.
- [ ] **Cách viết tác giả** (`STCE-VN-TXT-001`): thay thống nhất `và cộng sự`/`cùng cộng sự` bằng `và cs.` trong nội dung.
- [ ] **Khoảng cách quanh phương trình** (`STCE-VN-EQ-005`–`006`): không có dòng trống ngay trước phương trình; sau phương trình có đúng một dòng trống nếu đoạn tiếp theo bắt đầu bằng chữ hoa, và không có dòng trống nếu đoạn tiếp theo bắt đầu bằng chữ thường.
- [ ] **Nhiều biểu thức trong một phương trình**: các biểu thức cùng dòng được ngăn cách bằng `;\quad`, không dùng dấu phẩy thay thế khi không phải dấu phân cách nội bộ của vector/bảng trường hợp.
- [ ] **Figures/tables** (`STCE-VN-FIG-*`, `STCE-VN-TAB-*`): mọi hình tồn tại và mở được; subcaption hoa đầu, caption bỏ dấu chấm cuối theo C03; đường dẫn, placement, label/tham chiếu đúng. Bảng dùng số cột thực tế, booktabs và ô S hợp lệ; bảng nhiều trang dùng xltabular với header lặp và footer đúng trang.
- [ ] **Citations/references**: mọi citation có key trong `.bib`, mọi label được tham chiếu đúng; không còn cảnh báo undefined sau khi biên dịch lại.
- [ ] **Biên dịch**: chạy chu trình LaTeX/BibTeX phù hợp, sau đó chạy LaTeX đủ số lần để ổn định cross-reference; PDF được tạo thành công.
- [ ] **Kiểm tra chéo AGY**: nếu AGY khả dụng hoặc được yêu cầu, chạy kiểm tra chéo sau cùng và đối chiếu các cảnh báo về nội dung, citation, hình, bảng, phương trình và bố cục với file đã chuẩn hóa.
- [ ] **Warnings**: rà `overfull/underfull`, missing figure/font, hyperref và BibTeX; sửa nếu thuộc phạm vi format hoặc ghi rõ warning còn lại trong báo cáo cuối.
- [ ] **Báo cáo**: ghi file đầu ra, số trang, trạng thái compile, lỗi/warning còn lại và các thay đổi format chính; không báo “hoàn tất” nếu còn lỗi biên dịch hoặc undefined reference/citation.

### Lưu ý quan trọng
- **LUÔN backup** file trước khi chỉnh sửa
- Thực hiện từng bước (`STCE-VN-WORK-001`); chỉ commit khi môi trường có Git và người dùng/quy trình cho phép (`STCE-VN-WORK-002`; C15).
- Kiểm tra **compile** sau mỗi lần chỉnh sửa lớn
- Với file lớn (>500 dòng), làm **incremental** để tránh memory error
- **Đọc trực tiếp nội dung để đối chiếu** bằng công cụ đọc file hiện có (`STCE-VN-WORK-005`). Tìm kiếm chỉ hỗ trợ định vị, không thay việc đọc đầy đủ; không yêu cầu một tool tên `view_file` khi môi trường không có tool đó (C12).
- **KHÔNG** tạo script sửa nhanh (sed, PowerShell replace, python script...) — luôn dùng tool chỉnh sửa file trực tiếp

---

## 10. Tổng hợp khác biệt latex-stce-vn và latex-stce-en

| Đặc điểm | latex-stce-vn (Tiếng Việt) | latex-stce-en (Tiếng Anh) |
|---|---|---|
| Package / Proof status | Giống nhau | Giống nhau |
| Title | Sentence case (`STCE-VN-FRONT-003`) | Giữ case source; class mẫu tháng 12 in HOA trên PDF (`STCE-EN-FRONT-003`), không áp cho tiêu đề dịch sau `\TD` của bài Việt |
| Cortext | `Tác giả đại diện. \textit{Địa chỉ e-mail:}` | `Corresponding author.~\textit{E-mail address:}` |
| Corref key | `\corref{cor1}` | `\corref{cor}` |
| Headershort | `và cs.` | `\textit{et al.}` |
| Keyword block | Keywords VN + `\TD` + `\ABS` + `\KW` + `\CR` | Keywords EN + `\CR` |
| Dấu thập phân | Dấu phẩy `,` | Dấu chấm `.` |
| Tham chiếu hình | `Hình~\ref{}` | `Fig.~\ref{}` |
| Tham chiếu bảng | `Bảng~\ref{}` | `Table~\ref{}` |
| Section names | Tiếng Việt | Tiếng Anh |
| Acknowledgment | `\section*{Lời cảm ơn}` (nếu có) | `\section*{Acknowledgment}` (nếu nguồn có) |
| Equation `%` | Không bắt buộc | Không bắt buộc (`STCE-EN-EQ-010`); vẫn không dòng trống trước equation |
| Table macro | booktabs; macro bổ trợ theo template thực tế | booktabs; macro bổ trợ theo template thực tế |
| Article history | Theo class của số tiếng Việt | Class tháng 12: 5 trường; Available online / Version of Record chưa có thì để đối số rỗng |
| Đơn vị thông thường | Thủ công, math mode + `\mathrm{}`, giữ slash nguồn | Thủ công như tiếng Việt (`STCE-EN-UNIT-001`); thập phân vẫn dùng dấu chấm |

**C14 đã đồng bộ:** không chia macro theo ngôn ngữ. Áp dụng TAB-002/003 theo đúng chức năng và định nghĩa thực tế của template; không thêm lệnh chưa được mẫu nạp. C01 vẫn thống nhất Sentence case cho tiêu đề tiếng Việt.
