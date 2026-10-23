---
name: latex-stce-en
description: Chuẩn hóa file LaTeX bài tiếng Anh theo STCE/HUCE Journal; đối chiếu mã quy tắc, bảo toàn nội dung và article history theo template thực tế.
---

# latex-stce-en — Chuẩn hóa bài tiếng Anh

Skill chuẩn hóa file LaTeX theo đúng template của tạp chí **STCE — Science and Technology in Civil Engineering** (Tạp chí Khoa học Công nghệ Xây dựng, Đại học Xây dựng Hà Nội — HUCE).

Mẫu lịch sử: `3451_Tai Yi Liu.tex`. Lần đối chiếu này dùng **Vol.20 No.4 - 12.2026/04-Papers** theo yêu cầu người dùng, đặc biệt API article history trong `STCE/stce.cls`. Khi làm bài mới, ghi nhận template thực tế và metadata của chính bài/số đó.

## Cơ chế mã quy tắc — bắt buộc đọc trước khi làm

1. Đọc toàn bộ skill này, [RULES.md](RULES.md) và [CONFLICTS.md](CONFLICTS.md) trước khi sửa bài. Bản trước mã hóa được giữ ở `SKILL.before-rule-ids.md`.
2. Dùng tiền tố **STCE-EN-<NHÓM>-<SỐ>**; không dùng mã STCE-VN cho bài tiếng Anh. Các nhóm: CORE, BACKUP, TPL, FRONT, HIST, SEC, EQ, UNIT, TXT, FIG, TAB, REF, QA, WORK.
3. Mỗi mã có mức MUST/SHOULD/MAY, nguồn và cách kiểm chứng. Hướng dẫn/checklist lặp lại cùng yêu cầu phải tra cùng mã, không tạo quy tắc thứ hai.
4. Với từng mã, ghi `mã | PASS/FAIL/N/A/BLOCKED | file:dòng hoặc trang PDF | bằng chứng`. N/A cần lý do; chưa kiểm chứng không được PASS. Một lần compile thành công không chứng minh đã tuân thủ mọi mã.
5. Khi hướng dẫn và ví dụ không khớp, tra hồ sơ EN-Cxx và quy tắc đã chốt; không tự chọn ví dụ dễ làm hơn. Chỉ hỏi những quyết định còn thiếu và thực sự ảnh hưởng bài đang làm.

Đây là danh mục kiểm tra và quy trình báo cáo, **chưa phải validator/linter tự động**.

---

> [!CAUTION]
> ## ⚠️ QUY TẮC TỐI THƯỢNG — SUPREME RULE ⚠️
>
> **TUYỆT ĐỐI KHÔNG ĐƯỢC THAY ĐỔI NỘI DUNG GỐC.**
>
> Quy tắc bảo toàn **nội dung khoa học và ý nghĩa** có hiệu lực cao nhất. Các chuẩn hóa biên tập đã được chốt (et al., hoa đầu subcaption, bỏ dấu chấm cuối caption, khoảng trắng cite, định dạng đơn vị) không cho phép diễn giải lại nội dung.
>
> **KHÔNG BAO GIỜ** được thay đổi:
> - **Giá trị số** trong phương trình, bảng biểu
> - **Ký hiệu toán học** (subscript, superscript, biến, ...)
> - **Công thức và phương trình** (không rút gọn, không đơn giản hóa, không thay đổi biến)
> - **Nội dung text** (không viết lại câu, không thay từ, không thêm/bớt ý)
> - **Cấu trúc nội dung** (không thay đổi thứ tự, không gộp/tách đoạn)
> - **Nội dung caption hình/bảng** (chỉ chuẩn hóa biểu diễn và các ngoại lệ biên tập đã chốt)
>
> **CHỈ ĐƯỢC** thay đổi format LaTeX và chuẩn hóa biên tập được quy định rõ trong RULES.md; không được đổi nghĩa, số liệu hay nhận dạng ký hiệu.
>
> **KHÔNG ĐƯỢC SUY DIỄN.** Khi thấy nội dung gốc có vẻ không hợp lý (ký hiệu lạ, giá trị khác thường, công thức thiếu, ký hiệu bị mất do copy-paste) → **PHẢI BÁO CÁO LẠI USER**, không tự ý sửa, không tự ý thay thế bằng giá trị khác.
>
> Nếu không chắc chắn → **HỎI USER**, không tự suy diễn.

---

## 0. Quy tắc bắt buộc trước khi chuẩn hóa

> [!CAUTION]
> **PHẢI tạo bản sao file gốc trước khi sửa trực tiếp.**

- Trước khi sửa `.tex` hoặc `.bib` có sẵn, tạo bản `_original` tương ứng, ví dụ `XXXX_Author Name_original.tex` và `Bib/XXXX_original.bib` (`STCE-EN-BACKUP-001`).
- **Không ghi đè** bản `_original` đã có; không tạo “bản gốc” từ file đã chuẩn hóa (`STCE-EN-BACKUP-002`).
- Dùng backup để đối chiếu toàn bộ nội dung; chỉ xóa sau khi người dùng xác nhận đã kiểm tra xong (`STCE-EN-BACKUP-003`).
- Báo vị trí gốc/mới, nội dung trước/sau và lý do thay đổi; không sửa âm thầm (`STCE-EN-BACKUP-004`).

> [!CAUTION]
> **Chỉ chuẩn hóa FORMAT — KHÔNG thay đổi NỘI DUNG gốc**

**Nguyên tắc cốt lõi:** giữ nguyên nội dung và ý nghĩa nguồn; chỉ thay đổi cách trình bày và các chuẩn hóa biên tập được liệt kê rõ, không dùng chúng để viết lại câu.

**ĐƯỢC PHÉP:**
- Đổi `[1, 2]` → `~\cite{1, 2}` (format citation; có một dấu cách sau dấu phẩy)
- Đổi `Figure 1` → `Fig.~\ref{f1}` (format reference)
- Đổi `stress- strain` → `stress-strain` (sửa typo khoảng cách)
- Đổi raw text heading → `\section{...}` (format heading)
- Đổi raw table → `\begin{table}...\end{table}` (format table)
- Định dạng giá trị nhiệt độ **đã xác nhận**: `30 °C` → `30~$^\circ\mathrm{C}$`; không đoán `300C` là 30 °C
- Thêm `~` trước `\cite`, `\ref`, `$^\circ$C` (spacing rules)
- Đổi `H2SO4` → `\ce{H2SO4}` (format chemical)
- Đổi raw equation → `\begin{equation}` (format equation)

**NGHIÊM CẤM:**
- **KHÔNG** rút gọn/đơn giản hóa header bảng (giữ nguyên tên cột gốc)
- **KHÔNG** bỏ thành phần tên/initials: `Andisheh K et al` → `Andisheh K et al.` chỉ chuẩn hóa `et al.`, vẫn giữ `K`
- **KHÔNG** tự bổ sung nội dung thiếu (nếu gốc để trống/thiếu → giữ nguyên hoặc hỏi user)
- **KHÔNG** thay đổi giá trị dữ liệu trong bảng
- **KHÔNG** đổi ký hiệu/viết tắt (ví dụ `410` → `$\phi$10` là SAI)
- **KHÔNG** rút gọn đơn vị (ví dụ `(mm x mm x mm)` → `(mm)` là SAI)
- **KHÔNG** thay đổi thứ tự hoặc cấu trúc nội dung
- Nếu phát hiện lỗi nội dung trong bản gốc → **báo user**, KHÔNG tự ý sửa


---

## 1. Cấu trúc tổng thể của file `.tex`

Trật tự cấu trúc như dưới đây; chọn package theo đầu ra (`STCE-EN-TPL-001–009`). Ví dụ là **bản final**; không mang metadata giả/metadata của bài mẫu vào bài thật:

```latex
\documentclass[3p,times,11pt]{STCE/stce}
\usepackage{STCE/stce}                % final; proof dùng STCE/stce_proof thay dòng này
\volume{...}
\firstpage{...}
\copyrightyear{...}
\input{STCE/stce_package}
% Bản proof: sau khi nạp stce_package, bật đúng MỘT file watermark:
% \input{STCE/stce_uncorrectedproof}  % hoặc stce_correctedproof
\newcommand\id{XXXX}                  % mã bài báo

\begin{document}
\begin{frontmatter}
  ... (metadata)
\end{frontmatter}

  ... (nội dung bài báo)

% \section*{Acknowledgment}          % chỉ bật nếu nguồn có phần cảm ơn

\bibliographystyle{STCE/stce}
\bibliography{Bib/XXXX}              % file .bib theo mã bài

\end{document}
```

- **Final:** `STCE/stce`, không watermark proof. **Proof:** `STCE/stce_proof` và đúng trạng thái uncorrected/corrected; không nạp cả hai style.
- Giữ các phụ thuộc có trong mẫu, gồm encoding khi bài cần; không thêm package chỉ để khớp máy móc một ví dụ. `stce_package` phải được nạp trước watermark cần TikZ.
- Kiểm tra footer/ISSN/license trên PDF. Mẫu tháng 12 có năm **2026 hard-code** trong footer style; `\copyrightyear` không tự cập nhật chuỗi đó khi làm năm khác (`STCE-EN-TPL-010`).

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
- `STCE-EN-FRONT-003`: giữ hoa/thường của source, tên riêng và ký hiệu. Mẫu tháng 12 tự in **HOA trên PDF** bằng `\MakeUppercase`; có bài source HOA, có bài Title Case. Không ép source sang HOA/Title Case/Sentence case chỉ vì bảng so sánh cũ; kiểm tra ký hiệu toán/hóa học trên PDF không bị đổi nhận dạng.

### 2.3. Authors
```latex
\author[a]{Họ Tên} % tác giả đầu tiên
\author[b]{Họ Tên\corref{cor}}   % tác giả liên hệ
...
```
- Label `[a]`, `[b]`, `[c]`... tương ứng với address
- Tác giả liên hệ (corresponding author) có thêm `\corref{cor}`
- Giữ `\orcidlink{...}` đúng tác giả nếu nguồn có; không tự tạo/đoán ORCID (`STCE-EN-FRONT-014`).
- Có thể ngắt dòng title/author/address theo bố cục, không đổi thành phần tên hoặc làm tên bị tách khó đọc (`STCE-EN-FRONT-013/018`).

### 2.4. Corresponding author info
```latex
\cortext[cor]{Corresponding author.~\textit{E-mail address:}}
\shortauth{Tên, Họ viết tắt} % tên tác giả liên hệ viết tắt
\mailauth{email@domain} % email tác giả liên hệ
\headershort{Tên, Họ viết tắt, \textit{et al.}} % tên tác giả đầu tiên viết tắt, \textit{et al.} khi có >2 tác giả
```

> **Không nhầm hai macro:** `shortauth` là tác giả liên hệ, dùng ở footnote trang đầu (`STCE-EN-FRONT-007`); `headershort` bắt đầu từ tác giả đầu tiên, dùng ở running header và theo số tác giả bên dưới (`STCE-EN-FRONT-008–009`). Giữ phân biệt đã có trên GitHub.

**Quy tắc `\headershort`:**
- **1 tác giả**: ghi tên viết tắt tác giả đó, ví dụ: `\headershort{Anh, D. H.}`
- **2 tác giả**: ghi đủ tên viết tắt cả 2, ví dụ: `\headershort{Anh, D. H., Anh, N. V.}`
- **Từ 3 tác giả trở lên**: ghi tên **tác giả đầu tiên** + `\textit{et al.}` (`STCE-EN-FRONT-009`); `shortauth`/`mailauth` vẫn thuộc tác giả liên hệ. Ví dụ bài01 tháng 12: header `Tuan, L. S. A., \textit{et al.}`, tác giả liên hệ `Cuong, D. V.`.

**Quy tắc viết tắt tên tác giả:**
- Tên Việt Nam theo format `Tên, Họ viết tắt. Đệm viết tắt.`; tên nước ngoài theo cấu trúc tên đã xác định trong nguồn. Không đoán họ từ vị trí hay tự đảo tên đầy đủ (`STCE-EN-FRONT-010`).
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

### 2.6. Article history — received năm trường

`STCE-EN-HIST-001–011`. Template tháng 12 hỗ trợ năm đối số theo đúng thứ tự:

| Đối số | Nhãn trên PDF | Mã |
|---|---|---|
| 1 | Received | STCE-EN-HIST-002 |
| 2 | Revised | STCE-EN-HIST-003 |
| 3 | Accepted | STCE-EN-HIST-004 |
| 4 | Available online | STCE-EN-HIST-005 |
| 5 | Version of Record | STCE-EN-HIST-006 |

```latex
\received{D/M/YYYY}{D/M/YYYY}{D/M/YYYY}{D/M/YYYY}{D/M/YYYY}
```

`D/M/YYYY` chỉ là ký hiệu vị trí, không phải ngày mặc định hay yêu cầu bỏ/thêm số 0. Giữ ngày thực đã xác nhận và kiểu thể hiện của kỳ đang làm.

Khi chưa được cung cấp hai ngày mới, dùng **thay thế** dòng trên bằng:

```latex
\received{D/M/YYYY}{D/M/YYYY}{D/M/YYYY}{}{}
```

- Nếu chỉ thiếu một ngày mới, để `{}` đúng vị trí đó; vẫn giữ đủ năm đối số. Class ẩn nhãn của trường 4/5 rỗng, không tự ẩn nhãn ba trường đầu.
- Không tự điền ngày hiện tại, timestamp file, ngày Accepted hoặc ngày của bài mẫu. Ba ngày đầu thiếu/mâu thuẫn phải báo người dùng.
- Ngày `16/10/2026` và `25/12/2026` của bài mẫu tháng 12 không phải hằng số dùng cho kỳ khác.
- Class tháng 12 đặt Version of Record xuống dòng riêng; kiểm tra cả nhãn/ngày trên PDF và không để đối số thừa lọt vào abstract.
- Class hiện tại còn đọc ba/bốn đối số từ nguồn cũ, nhưng hướng dẫn mới dùng đủ năm. Trước khi áp dụng sang dự án khác, **kiểm tra class hỗ trợ**; không thêm hai đối số vào class cũ chỉ nhận ba, không tự sửa class/tạo shim ngoài phạm vi.

### 2.7. Abstract
```latex
\begin{abstract}
... (nội dung abstract, giữ nguyên ranh giới các đoạn của nguồn)
\end{abstract}
```
- Abstract nguồn nhiều đoạn: giữ nguyên và báo số đoạn/vị trí cho người dùng, **không tự gộp** (`STCE-EN-FRONT-015`).

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
- Nếu nguồn có, `Acknowledgment` dùng `\section*{Acknowledgment}` (không đánh số, số ít). Giữ các declaration có trong nguồn, không tự tạo lời cảm ơn hay khai báo AI (`STCE-EN-SEC-003`).

### 3.2. Format `\subsubsection`
- Đánh số theo chữ cái **a.**, **b.**, **c.** do template cấu hình; không gõ nhãn thủ công.
- Mẫu tháng 12: `\subsection` in nghiêng, `\subsubsection` **đứng**; để class xử lý, không bọc thêm italic/bold (`STCE-EN-SEC-004–005`).
- Nội dung bắt đầu ngay sau tiêu đề (cùng dòng hoặc dòng mới, tùy nội dung)
- Ví dụ:
```latex
\subsubsection{Tên mục con con}
Nội dung paragraph...
```
- Khi chuẩn hóa: nếu bài gốc dùng bold/italic thủ công cho tiểu mục (ví dụ `\textbf{a.}` hoặc `\textit{a) Tên mục}`), phải chuyển thành `\subsubsection{Tên mục}` để class tự format

### 3.3. Spacing
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
\begin{equation}\label{1}
... nội dung phương trình ...
\end{equation}
```
- Label đánh số trực tiếp: `\label{1}`, `\label{2}`, `\label{3}`, ...
- Tham chiếu bằng `Eq.~(\ref{1})`, `Eq.~(\ref{2})`, ...
- **Không có dòng trống ngay trước** `\begin{equation}` (`STCE-EN-EQ-004`).
- Sau equation: một dòng trống nếu đoạn tiếp bắt đầu chữ hoa; không dòng trống nếu tiếp tục chữ thường (`STCE-EN-EQ-005`). Không gộp/tách paragraph để thỏa một kiểm tra máy móc.
- Nhiều biểu thức độc lập cùng dòng dùng `;\quad`; giữ dấu phân cách nội bộ vector/cases/max theo nguồn (`STCE-EN-EQ-006`).
- Dòng comment `%` trước/sau equation là tùy chọn (`STCE-EN-EQ-010`), không bắt buộc và không thay thế yêu cầu paragraph spacing.

### 4.2. Inline math
- Dùng `$...$` cho biến đơn hoặc biểu thức ngắn
- Mô tả biến ngay sau equation: `where $X$ is ...; $Y$ is ...; and $Z$ is ...`

### 4.3. Ký hiệu đặc biệt
- Dấu ngang dài (en-dash) trong text: `--` (ví dụ: `load--settlement`)
- Khoảng `~` dùng trước `\cite`, `\ref`, `(\ref{...})`
- **Đơn vị nhiệt độ** có khoảng trắng không ngắt dòng giữa số và đơn vị: `37~$^\circ\mathrm{C}$`, không viết `37$^\circ\mathrm{C}$`.
- **Công thức hóa học**: LUÔN dùng `\ce{}` (package `mhchem`), KHÔNG dùng subscript/superscript thủ công
  - Ví dụ: `\ce{H2SO4}`, `\ce{CO2}`, `\ce{NaOH}`, `\ce{NaNO3}`, `\ce{PO4}`, `\ce{NH4}`
  - Sai: `H$_2$SO$_4$`, `CO$_2$`
- **Tên loài/chi/họ khoa học**: LUÔN in nghiêng bằng `\textit{}` theo quy chuẩn danh pháp khoa học
  - Ví dụ: `\textit{E. coli}`, `\textit{Ascaris}`, `\textit{Salmonella}`, `\textit{Lactobacillus}`


### 4.4. Đơn vị và số tiếng Anh — đã chốt thủ công

- `STCE-EN-UNIT-001–005`: đơn vị thông thường viết thủ công, phần đơn vị trong math mode dùng `\mathrm{}`; giữ nguyên slash, chữ viết, ngôn ngữ và giá trị nguồn. Ví dụ: `30~$\mathrm{MPa}$`, `2.5~$\mathrm{m/s}$`, `37~$^\circ\mathrm{C}$`.
- `siunitx` chỉ dùng khi cần ký hiệu/prefix đặc biệt; không chuyển đồng loạt đơn vị sang `siunitx`. Khi dùng phải kiểm tra PDF đúng biểu diễn nguồn; ví dụ prefix micro đi với đơn vị đầy đủ `\si{\micro\metre}`, không viết `\si{\micro}m`.
- Tiếng Anh dùng dấu chấm thập phân (`2.5`), **không dùng `{,}`** của số tiếng Việt. Không đổi dấu phân cách hàng nghìn thành dấu thập phân.
- Cột số `S` để căn theo dấu chấm là chức năng căn bảng, không có nghĩa đơn vị phải chuyển sang `siunitx`.
- Chuẩn hóa Unicode toán sang lệnh LaTeX đúng ký hiệu (ví dụ `α` → `$\alpha$`, dấu trừ toán → `$-$`); không xóa dấu tên riêng hoặc đoán ký hiệu bị mất (`STCE-EN-EQ-009`).

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
	%\qquad
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
- Figure thông thường dùng `[ht!]`; `wrapfigure` theo cú pháp riêng của môi trường, như ví dụ §5.4.
- Width phổ biến: `0.65\textwidth` (đơn), `0.47\textwidth` (đôi)
- **Caption KHÔNG kết thúc bằng dấu `.`**
- Subcaption viết hoa **chữ đầu nội dung**, không Title Case toàn câu; nhãn `(a)`, `(b)` vẫn thường. Subcaption cũng bỏ dấu chấm cuối (`STCE-EN-FIG-010–011`).

---

## 6. Tables

### 6.1. Cấu trúc table chuẩn
```latex
\begin{table}[ht!]\caption{Mô tả bảng}\label{tN}
%\tabcolsep = 3.5mm
%\fontsize{9}{11} \selectfont
%\renewcommand*\arraystretch{1.2}
\begin{tabularx}{\textwidth}{Xcc}\toprule
\lll{1}{Cột đầu tiên} & \lll{1}{Cột 2} & \lll{1}{Cột 3} \\\midrule
Dòng 1 & giá trị & giá trị \\
Dòng 2 & giá trị & giá trị \\
\bottomrule
\end{tabularx}
%\vspace*{1mm}\fontsize{10}{12} \selectfont
\end{table}
```

### 6.2. Quy tắc
- Bảng một trang dùng `tabularx` với `\textwidth`; bảng dài nhiều trang dùng `xltabular` theo §6.3, không ép vào float một trang. **Số cột theo bảng thực tế**, không chép số cột của ví dụ (`STCE-EN-TAB-001`).
- Dùng `\toprule`, `\midrule`, `\bottomrule` (booktabs style) — **KHÔNG** dùng `\hline`
- Hàng đầu tiên dùng `\lll{1}{Cột đầu tiên} & \lll{1}{Cột 2} & \lll{1}{Cột 3} \\\midrule`
- Macro trong `stce_package` không phân theo ngôn ngữ: `\lll{n}{text}` gộp n cột, căn giữa và makecell; `\rrr{n}{pos}{text}` gộp n hàng, makecell theo pos; `\p{text}` là phantom. Không tự dùng macro chưa được template định nghĩa (`STCE-EN-TAB-002–003`).
- Label: `t1`, `t2`, ...
- Tham chiếu: `Table~\ref{tN}`
- Với bảng một trang, `\caption` đặt **TRƯỚC** `tabularx`; bảng nhiều trang đặt caption theo môi trường tương ứng.
- `\tabcolsep` tùy chỉnh khoảng cách cột
- Với bảng một trang, hàng cuối kết thúc đúng **một** `\\`, sau đó `\bottomrule` ở dòng kế tiếp; không bỏ kết thúc hàng và không thêm hàng trắng (`STCE-EN-TAB-007`). Bảng dài dùng footer ở §6.3.
- Float bảng một trang dùng `[ht!]`; môi trường bảng nhiều trang theo cú pháp riêng.
- **KHÔNG** thêm space/padding thừa để căn cột (ví dụ `SS & 5 & Present & 3.1654` — viết liền, KHÔNG thêm khoảng trắng dài giữa các `&` để canh hàng). Giữ code bảng **compact**, dễ đọc
- Khi cần căn cột số theo dấu chấm thập phân, dùng `S`; có thể khai báo `S[table-format=M.N]` với M/N là số chữ số phần nguyên/thập phân. Header bọc trong `{...}` hoặc `\multicolumn{1}{c}{...}`; ô không phải số như `-` phải viết `{-}` (`STCE-EN-TAB-009/011/012`). Cột `S` không buộc đơn vị chuyển sang `siunitx`; số cột vẫn theo bảng thực tế.
- **Caption KHÔNG kết thúc bằng dấu `.`**

### 6.3. Bảng dài nhiều trang — giữ hướng dẫn đã có trên GitHub

Nguồn: `trungvjm/skills` tại `c00d465`, §6.3. Mã mới `STCE-EN-TAB-013–019`; không thay mã đã cấp. Thêm `\usepackage{xltabular}` vào preamble khi dùng bảng dài. Bảng đặt trực tiếp trong `xltabular`, **không bọc `table`**.

Ví dụ tám cột chỉ minh họa cấu trúc: phải sửa khai báo, header và dữ liệu theo số cột thực tế của bài.

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

- `STCE-EN-TAB-015`: caption/label ở đầu bảng, kết thúc hàng caption bằng `\\`.
- `STCE-EN-TAB-016`: trang sau **không lặp caption**, không caption tiếp nối; chỉ lặp header cột giữa `\toprule`/`\midrule` trước `\endhead`.
- `STCE-EN-TAB-017–018`: trang giữa dùng `\midrule\endfoot`; trang cuối dùng `\bottomrule\endlastfoot`.
- `STCE-EN-TAB-019`: ưu tiên cột co giãn `X` hoặc `*N{>{\centering\arraybackslash}X}`, tổng rộng theo `\textwidth`; N theo dữ liệu, không mặc định bằng 8.


---

## 7. Citations & Bibliography

### 7.1. In-text citations
```latex
\cite{1, 2, 3}        % đúng một dấu cách sau mỗi dấu phẩy
\cite{11}             % citation đơn
```
- `~` attaches directly to the preceding word: `text~\cite{N}`; never `text ~\cite{N}` or a line break before `~` (`STCE-EN-REF-003`).
- Adjacent citations must be merged: `\cite{2, 3, 4}`, not `\cite{2}, ~\cite{3}, ~\cite{4}` (`STCE-EN-REF-002`).
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

1. **Kiểm tra preamble**: template thực tế, documentclass, package proof/final, metadata, `\id`, footer/license
2. **Kiểm tra frontmatter**: đủ và đúng thứ tự các thành phần (doi, title, author, cortext, shortauth, mailauth, headershort, address, received, abstract, keyword)
3. **Chuẩn hóa sections**: đúng hierarchy, spacing
4. **Chuẩn hóa equations**: không dòng trống trước equation, spacing sau theo đoạn, label/tham chiếu; comment `%` tùy chọn
5. **Chuẩn hóa figures**: đường dẫn, label, placement, width
6. **Chuẩn hóa tables**: tabularx, booktabs, `\lll`, label
7. **Chuẩn hóa citations**: format `\cite`, kiểm tra `~` spacing
8. **Kiểm tra kết thúc**: Acknowledgment/declarations nếu nguồn có, bibliography; không tạo nội dung thiếu

### 8.1. Mandatory post-normalization checklist

Do not report the file as complete until every applicable rule in RULES.md has recorded evidence. The checklist below maps to the same IDs, not a second rule set:

- [ ] **Backup**: `_original.tex` and `_original.bib` exist and were not overwritten.
- [ ] **Content comparison**: compare against the original; scientific content, values, symbols, equations, paragraph order, caption meaning and references are preserved. Only explicitly permitted editorial normalizations may change surface wording/punctuation. Report doubtful cases.
- [ ] **Preamble/template**: document class, packages, proof status, `\id`, volume, DOI, and bibliography are correct.
- [ ] **Article history** (`STCE-EN-HIST-001–011`): verify class support, five argument positions, real metadata dates, empty unknown fields 4/5, and rendered labels/dates including Available online and Version of Record.
- [ ] **Math mode**: variables, subscripts, superscripts, Greek letters, mathematical signs, and minus signs are not left in text mode; notation is consistent throughout the article.
- [ ] **Units and numbers** (`STCE-EN-UNIT-001–005`): ordinary units use manual math-mode `\mathrm{}`; preserve source notation/slashes; `siunitx` only for special symbols/prefixes. English decimal point stays `.`; number–unit spacing and rendered symbols are correct.
- [ ] **Paragraphs**: exactly one blank line separates body paragraphs; heading spacing is correct; paragraphs were not accidentally merged or split.
- [ ] **Author wording**: use `et al.` consistently where the English template requires it; do not leave mixed author-collaboration wording.
- [ ] **Equation spacing**: no blank line immediately precedes a display equation; add exactly one blank line after an equation when the following paragraph starts with an uppercase letter, and no blank line when it starts with lowercase text.
- [ ] **Multiple expressions in one equation**: separate same-line expressions with `;\quad`; do not replace it with a comma unless the comma is an internal separator for a vector or cases environment.
- [ ] **Figures/tables** (`STCE-EN-FIG-001–012`, `STCE-EN-TAB-001–019`): every image exists, opens and renders; references resolve; subcaptions start uppercase but panel letters stay lowercase; captions have no final period. Tables use actual column counts, valid S cells and booktabs; multipage tables use xltabular with the required repeated header and page-specific footers.
- [ ] **Citations/references**: every citation key exists in `.bib`, every label resolves, and no undefined citation/reference remains after recompilation.
- [ ] **Compilation**: run the appropriate LaTeX/BibTeX cycle, then rerun LaTeX enough times to stabilize cross-references; confirm that the PDF is generated.
- [ ] **AGY cross-check**: if AGY is available or requested, run it after normalization and reconcile warnings about content, citations, figures, tables, equations, and layout with the normalized file.
- [ ] **Warnings**: review `overfull/underfull`, missing figure/font, hyperref, and BibTeX warnings; fix format issues or list remaining warnings in the final report.
- [ ] **Report** (`STCE-EN-BACKUP-004`, `STCE-EN-QA-007–008`): output files, page count, build result, remaining warnings, before/after changes and decisions; attach per-ID PASS/FAIL/N/A/BLOCKED with file/line or PDF-page evidence. Never claim completion with compilation or undefined-reference/citation errors, or claim unchecked rules passed.

### Lưu ý quan trọng
- **LUÔN backup** file trước khi chỉnh sửa
- Thực hiện từng nhóm thay đổi; chỉ commit khi có Git và được người dùng/quy trình cho phép, không tự tạo repo để thỏa skill
- Kiểm tra **compile** sau mỗi lần chỉnh sửa lớn
- Với file lớn (>500 dòng), làm **incremental** để tránh memory error
- **LUÔN đọc trực tiếp toàn bộ nội dung** bằng tool đọc file hiện có để đối chiếu; tìm kiếm chỉ giúp định vị, không thay việc đọc/nghiệm thu. Không phụ thuộc tên tool `view_file` nếu môi trường không có
- **KHÔNG** tạo script sửa nhanh (sed, PowerShell replace, python script...) — luôn dùng tool chỉnh sửa file trực tiếp
