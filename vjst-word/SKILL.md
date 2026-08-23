---
name: vjst-word
description: "Chuyển bản thảo gốc (.docx) sang một file Word mới dùng template VJST có sẵn style. Mặc định FORMAT-ONLY: giữ nguyên tuyệt đối nội dung, số liệu, công thức, ký hiệu, email, hình, bảng và tài liệu tham khảo; chỉ áp dụng style/bố cục và tạo báo cáo kiểm tra. Không tự sửa nội dung. Alias: /vjst-word"
---

# vjst-word: Chuẩn hóa bản thảo Word và Tạo Báo cáo Kiểm tra cho VJST

Kỹ năng này thực hiện 2 nhiệm vụ chính:
1. Đưa nguyên văn toàn bộ nội dung bản thảo gốc (`.docx`) vào **một file Word mới** dựa trên template VJST (`VJST-[ID].docx` hoặc `VJST.docx`), chỉ áp dụng style và bố cục có sẵn.
2. Tạo **2 file báo cáo kiểm tra độc lập** (`REPORT-PROOFREADING-[ID].md` và `REPORT-REFERENCES-[ID].md`) trong thư mục bài báo. Báo cáo chỉ nêu vấn đề và đề xuất; không tự ghi các sửa đổi nội dung vào file đích.

## 0. Chế độ bảo toàn nội dung — mặc định bắt buộc

- Không được viết lại, diễn giải, dịch, hiệu đính hoặc tự sửa bất kỳ chữ, chữ hoa/thường, số liệu, công thức, ký hiệu Greek, đơn vị, email, DOI, URL, tên tác giả, tài liệu tham khảo, chú thích hình/bảng hay nội dung trong bảng.
- Không được tự sửa lỗi chính tả như `caried`, `cctivities`, `NRM...`; không được tự đổi `Vietnam`/`Viet Nam`, dấu gạch nối, dấu câu hoặc dữ liệu hóa học. Mọi điểm nghi ngờ chỉ ghi vào báo cáo với nhãn `[CHECK]`.
- Không được xóa thân bài mẫu bằng thao tác có thể làm mất đối tượng Word. Tạo file đích mới từ template rồi chèn/copy nguyên cấu trúc nội dung, hình, bảng, công thức OMML và hyperlink.
- Chỉ được thay đổi: style, font, cỡ chữ, căn lề, khoảng cách, section, header/footer theo template và kích thước/vị trí trình bày khi không làm đổi nội dung.
- Chỉ thực hiện sửa nội dung khi người dùng nói rõ `cho phép sửa nội dung` hoặc yêu cầu một danh sách sửa cụ thể; khi đó phải bật Track Changes hoặc tạo báo cáo before/after riêng.

---

## 1. Tài liệu và Bài mẫu đối soát chuẩn
- **File CSL quy chuẩn Reference**: `.../VJST/04-Publication/vietnam-journal-of-science-and-technology.csl`
- **File bài mẫu chuẩn xuất bản (Benchmark)**: `.../VJST/04-Publication/2026/VOL64N4/07-Final/VJST-0-REV-23683-ĐD2-30-07-2026.docx`

---

## 2. Hệ thống Style chuẩn của VJST Word Template

| Phần | Style áp dụng | Quy cách chi tiết |
| :--- | :--- | :--- |
| **Loại bài báo** | `008_Section 1.` | Nếu bản gốc có loại bài, giữ nguyên chữ và chỉ áp dụng style; không tự thêm hoặc chuyển chữ hoa. |
| **Tiêu đề bài báo** | `002_Title` | 18pt Bold. Giữ nguyên chữ hoa/thường của bản gốc; không tự chuyển Sentence case. |
| **Tác giả (Authors)** | `003_Author` | 12pt Bold. Danh sách tác giả, **các chỉ số địa chỉ (affiliation numbers) và dấu sao `*` liên hệ BẮT BUỘC Ở DẠNG SUPERSCRIPT** (chỉ số trên). |
| **Địa chỉ (Affiliation)**| `004_Affiliation` | 11pt Italic. **Các chỉ số địa chỉ ở đầu dòng (`1`, `2`, `1, 2`...) BẮT BUỘC Ở DẠNG SUPERSCRIPT** (chỉ số trên), theo sau là tên đơn vị/địa chỉ. |
| **Email liên hệ** | `005_Email` | 10pt; giữ nguyên nhãn, số lượng và địa chỉ email của bản gốc. |
| **Lịch sử bài báo** | `006_History` | 10pt; giữ nguyên nguyên văn thông tin Received/Accepted của bản gốc. |
| **Tóm tắt (Abstract)** | `007_Abstract` | 11pt, có thể in đậm run nhãn nếu nhãn đã có trong bản gốc; giữ nguyên nội dung và chữ hoa/thường. |
| **Keywords** | `007_Keyword-Classification` | Run `Keywords` in nghiêng; giữ nguyên toàn bộ danh sách từ khóa, chữ hoa/thường và dấu câu của bản gốc. |
| **Classification numbers** | `007_Keyword-Classification` | Chỉ định dạng nếu mục này đã có trong bản gốc; không tự thêm nhãn hoặc mã phân loại. |
| **Tiêu đề mục cấp 1** | `008_Section 1.` | 11pt Bold. Chỉ áp dụng style; giữ nguyên chữ hoa/thường và nội dung tiêu đề của bản gốc. Mục References không đánh số nếu template đã quy định. |
| **Tiêu đề mục cấp 2** | `009_Subsection 1.1.` | 11pt Bold. Chỉ áp dụng style; giữ nguyên chữ hoa/thường và nội dung tiêu đề của bản gốc. |
| **Tiêu đề mục cấp 3** | `010_Subsubsection 1.1.1.` | 11pt Bold Italic. Chỉ áp dụng style; giữ nguyên chữ hoa/thường và nội dung tiêu đề của bản gốc. |
| **Đoạn văn nội dung** | `000_Text` | 11pt, giữ nguyên in nghiêng danh pháp Latin/loài (*in vitro*, *E. coli*), chỉ số $\text{CO}_2$, $\text{IC}_{50}$, $\text{K}_m$... |
| **Ảnh minh họa** | `012_Figure` | Căn giữa, chứa hình ảnh (độ rộng ~5.5 inches) |
| **Chú thích hình** | `013_FigCap` | Căn giữa; chỉ in nghiêng phần tương ứng đã có trong bản gốc, không tự đổi `Fig.` thành `Figure` hoặc sửa caption. |
| **Chú thích bảng** | `013_TableCap` | Chỉ áp dụng style cho caption hiện có; không tự đổi nhãn, số thứ tự hoặc chữ hoa/thường. |
| **Nội dung bảng** | `014_Table` | Kẻ viền ngang khoa học (bỏ viền dọc), header in đậm |
| **Lời cảm ơn** | `007_Keyword-Classification` | Chỉ áp dụng style cho nhãn/nội dung đã có; không tự đổi `Acknowledgements`/`Acknowledgments`. |
| **Đóng góp tác giả** | `007_Keyword-Classification` | Chỉ áp dụng style cho mục đã có; không tự thêm, xóa hoặc thay câu nhãn. |
| **Xung đột lợi ích** | `007_Keyword-Classification` | Run nhãn mục in đậm nghiêng; giữ nguyên câu tuyên bố của bản gốc, không thay bằng câu mẫu. |
| **Tài liệu tham khảo** | `016_Tailieuthamkhao` | Định dạng theo chuẩn CSL `vietnam-journal-of-science-and-technology.csl` (xem chi tiết mục 3) |

---

## 3. Quy chuẩn trình bày References theo `vietnam-journal-of-science-and-technology.csl`

CSL chỉ dùng để xác định **style trình bày**. Trong chế độ FORMAT-ONLY, không được dùng CSL/AI để sửa, rút gọn, bổ sung, xác minh hoặc thay thế metadata của tài liệu gốc.

- Giữ nguyên tên tác giả, tiêu đề, năm, volume, issue, trang, DOI, URL, dấu câu, chữ hoa/thường và thứ tự reference.
- Có thể áp dụng style cho số reference, font, thụt lề, in đậm volume hoặc in nghiêng theo template **nếu không thay đổi ký tự**.
- Không tự đổi dấu gạch nối/en-dash, không tự viết tắt tên tạp chí, không tự thêm/xóa DOI, không đổi `et al.` và không sửa typo.
- Kiểm tra thứ tự trích dẫn, reference chưa được trích dẫn, DOI lỗi hoặc metadata sai chỉ trong báo cáo; mọi đề xuất phải có nhãn `[CHECK]`.

---

## 4. Quy trình thực hiện tự động bằng Python

Khi người dùng yêu cầu thay thế/định dạng bản thảo vào template trong thư mục bài báo (ví dụ `.../VOL64N5/0-REV-23881`):

### Bước 1: Khảo sát và chuẩn bị môi trường
1. Sử dụng `uv run --with python-docx --with pillow python3` để đảm bảo có đầy đủ thư viện xử lý `.docx` và trích xuất hình ảnh (`.tif`, `.png`, `.jpg`).
2. Xác định file bản thảo gốc (file `.docx` tác giả gửi) và file template đích (`VJST-[ID].docx` hoặc `VJST.docx`).

### Bước 2: Trích xuất hình ảnh và phân tích toàn vẹn XML
1. Mở file `.docx` gốc như một file zip, trích xuất tất cả file trong `word/media/` ra thư mục tạm scratch.
2. **Quan trọng về XML**: Sử dụng hàm quét đệ quy qua các phần tử XML `<w:p>`, `<w:r>`, `<w:hyperlink>`, `<w:tc>` để bảo đảm 100% văn bản (bao gồm link DOI, bảng lồng nhau, chỉ số hóa học) không bị thất lạc.

### Bước 3: Khởi tạo file đích từ Template
1. Tạo một bản sao mới của template `VJST-[ID].docx`; không sửa file gốc và tránh LibreOffice round-trip nếu có thể.
2. Xác định vùng placeholder/paragraph mẫu rồi thay bằng bản sao cấu trúc nội dung từ bản thảo: paragraphs, runs, hyperlinks, tables, equations OMML, drawings, captions, footnotes/endnotes và media.
3. Giữ nguyên thứ tự và ký tự; chỉ gán style tương ứng: Front matter -> Headings & Paragraphs -> Figures -> Tables -> Back matter -> References.
4. Không dùng `get_text()` rồi viết lại toàn bộ document vì có thể làm mất superscript/subscript, công thức, hyperlink, field, comment hoặc định dạng nội tuyến.

---

## 5. Quy chuẩn 2 Báo cáo Kiểm tra (Post-processing Reports)

Sau khi hoàn tất định dạng file Word, tiến hành rà soát chuyên sâu và tự động tạo 2 file báo cáo bằng Markdown lưu trực tiếp trong thư mục bài báo:

### 1. `REPORT-PROOFREADING-[ID].md` (Báo cáo Hiệu đính, Quy chuẩn Biên tập & Trích dẫn Nội văn)
Rà soát toàn văn bản thảo theo các quy tắc biên tập khoa học của VJST nhưng **chỉ phát hiện và báo cáo, không tự sửa nội dung**:
- **Kiểm tra trích dẫn nội văn (In-text citations)**:
  - **Hình ảnh (Figures)**: Kiểm tra từng hình (Figure 1, Figure 2...) đã được dẫn chiếu trong nội văn hay chưa.
  - **Bảng biểu (Tables)**: Kiểm tra từng bảng (Table 1, Table 2...) đã được dẫn chiếu trong nội văn hay chưa.
  - **Tài liệu tham khảo (References)**: Kiểm tra từng số tài liệu `[1]` đến `[N]` trong nội văn (bao gồm dải trích dẫn `[1–3]`, `[5, 9–11]`). **BẮT BUỘC kiểm tra thứ tự trích dẫn (Sequential Order)**: Các tài liệu xuất hiện lần đầu phải theo thứ tự tăng dần ($[1], [2], [3], [4]\dots$); chỉ rõ bất kỳ tài liệu nào xuất hiện sai thứ tự (out of order), nhảy cóc (gaps) hoặc chưa được trích dẫn (Uncited References).
- **Hệ đơn vị đo lường chuẩn SI**: Phát hiện đơn vị chưa đúng quy cách và ghi đề xuất `[CHECK]`; không tự thêm khoảng trắng hoặc sửa ký hiệu trong file đích.
- **Ký hiệu phần trăm (%)**: Phát hiện vị trí chưa đúng quy cách và ghi đề xuất `[CHECK]`; không tự thêm khoảng trắng hoặc sửa ký hiệu trong file đích.
- **Địa danh và tên cơ quan**: Phát hiện cách viết không nhất quán và ghi đề xuất `[CHECK]`; giữ nguyên nguyên văn trong file đích, bao gồm tên cơ quan, trường học và viện nghiên cứu.
- **Chính tả và Thuật ngữ tiếng Anh**: Phát hiện và liệt kê lỗi đánh máy, lỗi dùng từ chuyên ngành, danh pháp Latin chưa in nghiêng (*in vivo*, *in vitro*, *et al.*, tên chi/loài sinh học); không tự sửa vào file Word.
- **Cấu trúc báo cáo**:
  1. Bảng tổng quan trạng thái (Figures in-text, Tables in-text, Refs in-text, SI units, %, Latin, Địa danh).
  2. Báo cáo chi tiết rà soát trích dẫn nội văn (Hình, Bảng, Refs) và danh sách mục chưa có trích dẫn.
  3. Bảng chi tiết các điểm chính tả & quy chuẩn cần sửa: `| Vị trí | Nội dung hiện tại | Đề xuất chỉnh sửa | Lý do / Quy chuẩn |`.
  4. Kiến nghị dành cho Biên tập viên.

### 2. `REPORT-REFERENCES-[ID].md` (Báo cáo Đối soát Tài liệu Tham khảo theo `/check-ref`)
Thực hiện đối soát toàn bộ danh mục tài liệu tham khảo với dữ liệu trực tuyến (Crossref API và Google Scholar), nhưng chỉ lập báo cáo; không thay thế metadata trong file đích:
- **A. Bảng tổng hợp đối soát**: Tổng số tài liệu, số tài liệu khớp 100%, số tài liệu có sai lệch hoặc thiếu thông tin.
- **B. Tác giả bị thiếu / viết tắt chưa chuẩn**: Phát hiện các trường hợp dùng "et al.", "others" hoặc thiếu tên đồng tác giả so với cơ sở dữ liệu chính thức.
- **C. Sai lệch thông tin xuất bản (Discrepancies)**: Đối chiếu và chỉ ra sự khác biệt về Năm, Tập (Volume), Số trang (Pages), Tiêu đề bài báo.
- **D. Cảnh báo tài liệu bất thường / Tiền ấn phẩm**: Cảnh báo các bài báo dạng Preprint (arXiv, Research Square), tài liệu thiếu DOI, DOI không phân giải được hoặc thông tin chưa được thẩm định chính thức.
- **E. Bảng đối soát chi tiết từng Reference**: Liệt kê từng tài liệu kèm trạng thái (Verified / Discrepancy / Missing DOI / Pre-print).

## 6. Kiểm định bắt buộc trước khi bàn giao

1. Trích xuất text, text trong ô bảng, hyperlinks, công thức OMML, chú thích, header/footer và danh sách media từ file gốc và file đích.
2. So sánh before/after bằng hash hoặc diff. Sau khi loại trừ thay đổi style/layout được phép, mọi thay đổi ký tự phải làm trạng thái **FAIL**.
3. Kiểm tra số lượng paragraph, table, row/cell, figure, equation, reference và media.
4. Render cả hai file thành PDF/ảnh để kiểm tra mất hình, tràn chữ, superscript/subscript, công thức và chất lượng ảnh.
5. Chỉ bàn giao file đích khi có `CONTENT PRESERVED: PASS`. Nếu FAIL, giữ file để kiểm tra, không tự sửa lần nữa.

### Tệp đầu ra tối thiểu

- `VJST-[ID]-formatted.docx`: file mới dùng template.
- `REPORT-PROOFREADING-[ID].md`: báo cáo lỗi/đề xuất, không phải bản đã sửa.
- `REPORT-REFERENCES-[ID].md`: báo cáo đối soát, không thay metadata trong Word.
- `CONTENT-DIFF-[ID].md`: bắt buộc nếu phát hiện bất kỳ khác biệt text nào.
