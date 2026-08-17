---
name: vjst-word
description: "Tự động hóa quy trình chuyển đổi và định dạng toàn diện bản thảo gốc (.docx) vào file template Word chuẩn của tạp chí VJST (Vietnam Journal of Science and Technology) với các style sẵn có. Không làm thay đổi nội dung, chuẩn hóa các mục Front matter, Headings, Text, Figures, Tables, Back matter và References, đồng thời tạo 2 báo cáo kiểm tra (Proofreading & References). Alias: /vjst-word"
---

# vjst-word: Chuẩn hóa bản thảo Word và Tạo Báo cáo Kiểm tra cho VJST

Kỹ năng này thực hiện 2 nhiệm vụ chính:
1. Đưa toàn bộ nội dung bản thảo gốc của tác giả (`.docx`) vào file template mẫu của VJST (`VJST-[ID].docx` hoặc `VJST.docx`), áp dụng chính xác hệ thống Style chuẩn, bảo toàn 100% nội dung và chỉ thay đổi định dạng theo quy cách xuất bản.
2. Tự động khởi tạo **2 file báo cáo kiểm tra độc lập** (`REPORT-PROOFREADING-[ID].md` và `REPORT-REFERENCES-[ID].md`) lưu cùng thư mục bài báo để phục vụ công tác biên tập chuyên môn.

---

## 1. Tài liệu và Bài mẫu đối soát chuẩn
- **File CSL quy chuẩn Reference**: `.../VJST/04-Publication/vietnam-journal-of-science-and-technology.csl`
- **File bài mẫu chuẩn xuất bản (Benchmark)**: `.../VJST/04-Publication/2026/VOL64N4/07-Final/VJST-0-REV-23683-ĐD2-30-07-2026.docx`

---

## 2. Hệ thống Style chuẩn của VJST Word Template

| Phần | Style áp dụng | Quy cách chi tiết |
| :--- | :--- | :--- |
| **Loại bài báo** | `008_Section 1.` | `REVIEW PAPER`, `RESEARCH PAPER`, `SHORT COMMUNICATION` (chữ in hoa) |
| **Tiêu đề bài báo** | `002_Title` | 18pt Bold. **BẮT BUỘC DẠNG NORMAL CASE (Sentence case)**: Chỉ viết hoa chữ cái đầu tiên của tiêu đề, chữ cái đầu tiên ngay sau dấu hai chấm (`:`), các từ viết tắt/acronym bắt buộc (COVID-19, SARS-CoV-2, DNA, RNA...) và danh từ riêng |
| **Tác giả (Authors)** | `003_Author` | 12pt Bold. Danh sách tác giả, **các chỉ số địa chỉ (affiliation numbers) và dấu sao `*` liên hệ BẮT BUỘC Ở DẠNG SUPERSCRIPT** (chỉ số trên). |
| **Địa chỉ (Affiliation)**| `004_Affiliation` | 11pt Italic. **Các chỉ số địa chỉ ở đầu dòng (`1`, `2`, `1, 2`...) BẮT BUỘC Ở DẠNG SUPERSCRIPT** (chỉ số trên), theo sau là tên đơn vị/địa chỉ. |
| **Email liên hệ** | `005_Email` | 10pt, dạng `*Email: ...` hoặc `*E-mail: ...` |
| **Lịch sử bài báo** | `006_History` | 10pt, `Received: ...; Accepted for publication: ...` |
| **Tóm tắt (Abstract)** | `007_Abstract` | 11pt, Run đầu `Abstract. ` in đậm, nội dung sau viết thường |
| **Keywords** | `007_Keyword-Classification` | Run `Keywords` in nghiêng, `: ` thường. **BẮT BUỘC DẠNG NORMAL CASE (chữ thường)**: Danh sách từ khóa viết thường, chỉ viết in hoa các từ bắt buộc (COVID-19, SARS-CoV-2, DNA, RNA...) và danh từ riêng, kết thúc bằng dấu chấm `.` |
| **Classification numbers** | `007_Keyword-Classification` | Run `Classification numbers` in nghiêng, `: `. **LƯU Ý:** Nếu bài gốc không có mã phân loại, để trống sau dấu hai chấm (`Classification numbers: `) |
| **Tiêu đề mục cấp 1** | `008_Section 1.` | 11pt Bold. **BẮT BUỘC VIẾT HOA CHỮ CÁI ĐẦU TIÊN CỦA TIÊU ĐỀ MỤC** và áp dụng dạng **SENTENCE CASE (Normal case)**: Chữ cái đầu tiên ngay sau số thứ tự mục bắt buộc phải viết hoa (ví dụ: `1. Introduction`, `2. Materials and methods`, `3. Results and discussion`, `4. Conclusions`). Các từ tiếp theo viết thường, chỉ viết hoa các từ viết tắt/acronym bắt buộc và danh từ riêng. **LƯU Ý:** Mục Tài liệu tham khảo **KHÔNG ĐÁNH SỐ** (`References`). |
| **Tiêu đề mục cấp 2** | `009_Subsection 1.1.` | 11pt Bold. **Bắt buộc viết hoa chữ cái đầu tiên** ngay sau số thứ tự và áp dụng dạng Sentence case (chỉ viết hoa từ bắt buộc) (`2.1. Applications of lectins`, `2.2. Plant materials`, `3.1. Structure elucidation`...) |
| **Tiêu đề mục cấp 3** | `010_Subsubsection 1.1.1.` | 11pt Bold Italic. **Bắt buộc viết hoa chữ cái đầu tiên** ngay sau số thứ tự và áp dụng dạng Sentence case (chỉ viết hoa từ bắt buộc) (`2.1.1. General experimental procedures`, `2.1.2. Plant-derived lectins against SARS-CoV-2`...) |
| **Đoạn văn nội dung** | `000_Text` | 11pt, giữ nguyên in nghiêng danh pháp Latin/loài (*in vitro*, *E. coli*), chỉ số $\text{CO}_2$, $\text{IC}_{50}$, $\text{K}_m$... |
| **Ảnh minh họa** | `012_Figure` | Căn giữa, chứa hình ảnh (độ rộng ~5.5 inches) |
| **Chú thích hình** | `013_FigCap` | Căn giữa, Run `Figure X.` in nghiêng, phần nội dung mô tả viết thường |
| **Chú thích bảng** | `013_TableCap` | Run `Table X.` in nghiêng, phần nội dung mô tả viết thường |
| **Nội dung bảng** | `014_Table` | Kẻ viền ngang khoa học (bỏ viền dọc), header in đậm |
| **Lời cảm ơn** | `007_Keyword-Classification` | Run `Acknowledgments. ` in đậm nghiêng |
| **Đóng góp tác giả** | `007_Keyword-Classification` | Run `CRediT authorship contribution statement. ` in đậm nghiêng |
| **Xung đột lợi ích** | `007_Keyword-Classification` | Run `Declaration of competing interest. ` in đậm nghiêng. **BẮT BUỘC DÙNG MẪU:** `The authors declare that they have no known competing financial interests or personal relationships that could have appeared to influence the work reported in this paper.` |
| **Tài liệu tham khảo** | `016_Tailieuthamkhao` | Định dạng theo chuẩn CSL `vietnam-journal-of-science-and-technology.csl` (xem chi tiết mục 3) |

---

## 3. Quy chuẩn Reference theo `vietnam-journal-of-science-and-technology.csl`

- **Định dạng chung**: Đánh số với tiền tố `{i}. \t`.
- **Dấu phân cách Tác giả và Tiêu đề**: Sử dụng dấu gạch ngang en-dash có khoảng trắng hai bên ` – ` (Unicode `\u2013`).
- **Tiêu đề bài báo**: Viết dạng sentence case, kết thúc bằng dấu chấm `. `. Tên loài sinh học, từ Latin (*in vitro*, *in vivo*, *Terminalia catappa*...) phải được in nghiêng.
- **Tạp chí (Journal Article)**:
  - Tên tạp chí viết tắt chuẩn ISO 4 (chữ thẳng, không in nghiêng), theo sau là dấu phẩy `, `.
  - Tập san (Volume): Bắt buộc **IN ĐẬM** (`font-weight: bold`), không đưa số kỳ (Issue) vào mục journal article.
  - Năm xuất bản: Đặt trong ngoặc đơn `(YYYY)`.
  - Số trang / Article number: `(2021) 3647–3655.` (dùng en-dash `–` cho khoảng trang).
  - Link DOI: `https://doi.org/...` đặt ở cuối và kết thúc bằng dấu chấm `.`.
  - *Ví dụ*: `1. \tPan D., Nolan J., Williams K. H., Robbins M. J., Weber K. A. – Abundance and distribution of microbial cells and viruses in an alluvial aquifer. Front. Microbiol., 8 (2017) 1199. https://doi.org/10.3389/fmicb.2017.01199.`
- **Sách / Chương sách (Book / Chapter / Conference)**:
  - Dạng: `{Authors} – {Title}. In: {Book Title in Italic}, {Volume in Bold}, ({Year}) {Pages}. https://doi.org/{DOI}.`
  - *Ví dụ*: `2. \tSankaran N., Weiss R. A. – Viruses: Impact on science and society. In: Encyclopedia of Virology, 1, (2021) 671–680. https://doi.org/10.1016/B978-0-12-814515-9.00075-8.`

- **Quy chuẩn Trích dẫn nội văn (In-text citations)**:
  - Các trích dẫn phân cách bằng dấu phẩy **bắt buộc có khoảng trắng** sau dấu phẩy: `[3, 4]`, `[13, 14]`, `[6, 16]` (không viết dính `[3,4]`).
  - Dải trích dẫn liên tiếp (từ 3 số trở lên hoặc khoảng) **bắt buộc gộp lại và dùng dấu gạch ngang en-dash `–`**: `[4–7]`, `[1–3]`, `[94–96]` (không viết rời `[4]-[7]`, `[4] - [7]` hay dùng dấu gạch nối ngắn `[4-7]`).

---

## 4. Quy trình thực hiện tự động bằng Python

Khi người dùng yêu cầu thay thế/định dạng bản thảo vào template trong thư mục bài báo (ví dụ `.../VOL64N5/0-REV-23881`):

### Bước 1: Khảo sát và chuẩn bị môi trường
1. Sử dụng `uv run --with python-docx --with pillow python3` để đảm bảo có đầy đủ thư viện xử lý `.docx` và trích xuất hình ảnh (`.tif`, `.png`, `.jpg`).
2. Xác định file bản thảo gốc (file `.docx` tác giả gửi) và file template đích (`VJST-[ID].docx` hoặc `VJST.docx`).

### Bước 2: Trích xuất hình ảnh và phân tích toàn vẹn XML
1. Mở file `.docx` gốc như một file zip, trích xuất tất cả file trong `word/media/` ra thư mục tạm scratch.
2. **Quan trọng về XML**: Sử dụng hàm quét đệ quy qua các phần tử XML `<w:p>`, `<w:r>`, `<w:hyperlink>`, `<w:tc>` để bảo đảm 100% văn bản (bao gồm link DOI, bảng lồng nhau, chỉ số hóa học) không bị thất lạc.

### Bước 3: Khởi tạo và ghi nội dung vào Template
1. Mở file template `VJST-[ID].docx`.
2. Xóa toàn bộ các đoạn văn và bảng mẫu có sẵn trong phần thân (giữ lại `w:sectPr` để bảo toàn margins, header, footer và phân trang).
3. Đưa từng phần vào document theo thứ tự: Front matter -> Headings & Paragraphs -> Figures -> Tables -> Back matter -> References.

---

## 5. Quy chuẩn 2 Báo cáo Kiểm tra (Post-processing Reports)

Sau khi hoàn tất định dạng file Word, tiến hành rà soát chuyên sâu và tự động tạo 2 file báo cáo bằng Markdown lưu trực tiếp trong thư mục bài báo:

### 1. `REPORT-PROOFREADING-[ID].md` (Báo cáo Hiệu đính, Quy chuẩn Biên tập & Trích dẫn Nội văn)
Rà soát toàn văn bản thảo theo các quy tắc biên tập khoa học của VJST:
- **Kiểm tra trích dẫn nội văn (In-text citations)**:
  - **Hình ảnh (Figures)**: Kiểm tra từng hình (Figure 1, Figure 2...) đã được dẫn chiếu trong nội văn hay chưa.
  - **Bảng biểu (Tables)**: Kiểm tra từng bảng (Table 1, Table 2...) đã được dẫn chiếu trong nội văn hay chưa.
  - **Tài liệu tham khảo (References)**: Kiểm tra từng số tài liệu `[1]` đến `[N]` trong nội văn (bao gồm dải trích dẫn `[1–3]`, `[5, 9–11]`). **BẮT BUỘC kiểm tra thứ tự trích dẫn (Sequential Order)**: Các tài liệu xuất hiện lần đầu phải theo thứ tự tăng dần ($[1], [2], [3], [4]\dots$); chỉ rõ bất kỳ tài liệu nào xuất hiện sai thứ tự (out of order), nhảy cóc (gaps) hoặc chưa được trích dẫn (Uncited References).
- **Hệ đơn vị đo lường chuẩn SI**: Đơn vị phải cách số đứng trước 1 khoảng trắng / option space (ví dụ: `10 mg`, `50 mL`, `37 °C`, `24 h`, `100 kDa`, `5.5 inches`...).
- **Ký hiệu phần trăm (%)**: Bắt buộc phải cách số đứng trước 1 khoảng trắng (ví dụ: `10 %`, `95.5 %`, `0.5 %`...).
- **Chuẩn hóa địa danh Việt Nam**:
  - Địa danh phải viết tách: `Vietnam` → `Viet Nam`, `Hanoi` → `Ha Noi`, `Danang` → `Da Nang`...
  - **LƯU Ý QUAN TRỌNG**: **Giữ nguyên tên cơ quan, trường học, viện nghiên cứu** (ví dụ: `Vietnam Academy of Science and Technology`, `Hanoi University of Science and Technology`, `Vietnam National University`...).
- **Chính tả và Thuật ngữ tiếng Anh**: Phát hiện các lỗi đánh máy (typos), lỗi dùng từ chuyên ngành, danh pháp Latin chưa in nghiêng (*in vivo*, *in vitro*, *et al.*, tên chi/loài sinh học).
- **Cấu trúc báo cáo**:
  1. Bảng tổng quan trạng thái (Figures in-text, Tables in-text, Refs in-text, SI units, %, Latin, Địa danh).
  2. Báo cáo chi tiết rà soát trích dẫn nội văn (Hình, Bảng, Refs) và danh sách mục chưa có trích dẫn.
  3. Bảng chi tiết các điểm chính tả & quy chuẩn cần sửa: `| Vị trí | Nội dung hiện tại | Đề xuất chỉnh sửa | Lý do / Quy chuẩn |`.
  4. Kiến nghị dành cho Biên tập viên.

### 2. `REPORT-REFERENCES-[ID].md` (Báo cáo Đối soát Tài liệu Tham khảo theo `/check-ref`)
Thực hiện đối soát toàn bộ danh mục tài liệu tham khảo với dữ liệu trực tuyến (Crossref API và Google Scholar):
- **A. Bảng tổng hợp đối soát**: Tổng số tài liệu, số tài liệu khớp 100%, số tài liệu có sai lệch hoặc thiếu thông tin.
- **B. Tác giả bị thiếu / viết tắt chưa chuẩn**: Phát hiện các trường hợp dùng "et al.", "others" hoặc thiếu tên đồng tác giả so với cơ sở dữ liệu chính thức.
- **C. Sai lệch thông tin xuất bản (Discrepancies)**: Đối chiếu và chỉ ra sự khác biệt về Năm, Tập (Volume), Số trang (Pages), Tiêu đề bài báo.
- **D. Cảnh báo tài liệu bất thường / Tiền ấn phẩm**: Cảnh báo các bài báo dạng Preprint (arXiv, Research Square), tài liệu thiếu DOI, DOI không phân giải được hoặc thông tin chưa được thẩm định chính thức.
- **E. Bảng đối soát chi tiết từng Reference**: Liệt kê từng tài liệu kèm trạng thái (Verified / Discrepancy / Missing DOI / Pre-print).
