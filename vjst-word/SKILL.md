---
name: vjst-word
description: "Chuyển bản thảo gốc (.docx) sang một file Word mới dùng template VJST có sẵn style. Tự động tạo file backup tăng dần [Tên file]-backup(N).docx trước khi chuẩn hóa. Giữ nguyên header và footer trong file, chỉ thay thế nội dung, cập nhật DOI theo đúng mã bài. Khi có chuẩn hóa/thay đổi về nội dung, BẮT BUỘC tô chữ màu green (xanh lá) cho các điểm thay đổi. Tạo 2 file báo cáo kiểm tra độc lập. Alias: /vjst-word"
---

# vjst-word: Chuẩn hóa bản thảo Word và Tạo Báo cáo Kiểm tra cho VJST

Kỹ năng này thực hiện các nhiệm vụ chính:
1. **Tự động sao lưu file backup** theo quy tắc tăng dần `[Tên file]-backup(N).docx` trước khi thực hiện chuẩn hóa hoặc sửa chữa.
2. Đưa nội dung bản thảo gốc (`.docx`) vào **một file Word mới** dựa trên template VJST (`VJST-[ID].docx` hoặc `VJST.docx`), áp dụng hệ thống style và bố cục chuẩn, giữ nguyên header/footer và cập nhật DOI theo mã bài.
3. Tạo **2 file báo cáo kiểm tra độc lập** (`REPORT-PROOFREADING-[ID].md` và `REPORT-REFERENCES-[ID].md`) trong thư mục bài báo.

---

## 0. Quy tắc cốt lõi: Backup An toàn, Bảo toàn Header/Footer, Cập nhật DOI & Tô chữ màu Green

### 0.1. Tự động tạo đúng 1 file Backup ở đầu mỗi lượt chat trước khi sửa đổi (Bắt buộc)
- **Tần suất**: **Chỉ tạo đúng 1 bản backup ở đầu mỗi lượt yêu cầu của người dùng (sau mỗi lần chat thêm)** trước khi sửa đổi file Word đích (`VJST-[ID].docx` hoặc file cần sửa). Tuyệt đối **không tạo nhiều bản backup trung gian** trong cùng 1 lần chat nếu phải chạy nhiều bước thử nghiệm nội bộ.
- **Quy cách đặt tên file Backup**:
  $$\text{<Tên file cần chuẩn hóa (bỏ đuôi .docx)>-backup(N).docx}$$
  - Lần chuẩn hóa đầu tiên: `[Tên file]-backup(1).docx` (ví dụ: `VJST-1-NAT-19436-backup(1).docx`)
  - Lần sửa đổi/bổ sung ở các lượt chat tiếp theo: Tự động tăng dần chỉ số `N` lên thành `[Tên file]-backup(2).docx`, `[Tên file]-backup(3).docx`...
  - **Cơ chế xác định chỉ số N trong Python**:
    ```python
    import os, re, shutil

    def create_incremental_backup(target_path):
        base_dir = os.path.dirname(target_path)
        base_name = os.path.splitext(os.path.basename(target_path))[0]
        pattern = re.compile(rf"^{re.escape(base_name)}-backup\((\d+)\)\.docx$")
        existing_indices = [0]
        for fname in os.listdir(base_dir):
            m = pattern.match(fname)
            if m:
                existing_indices.append(int(m.group(1)))
        next_idx = max(existing_indices) + 1
        backup_path = os.path.join(base_dir, f"{base_name}-backup({next_idx}).docx")
        if os.path.exists(target_path):
            shutil.copy2(target_path, backup_path)
            print(f"Created backup: {backup_path}")
        return backup_path
    ```

### 0.2. Mặc định bảo toàn nội dung (Content Integrity)
- Khi chỉ thực hiện định dạng (Format-only): Không tự ý viết lại, diễn giải, dịch hoặc thay đổi cấu trúc câu văn học thuật của tác giả khi không có yêu cầu.
- Không được xóa thân bài mẫu bằng thao tác làm mất đối tượng Word (sectPr, header, footer, margins).
- Bảo đảm 100% đối tượng khoa học (bảng, hình ảnh độ phân giải cao, công thức OMML, liên kết hyperlink) được giữ trọn vẹn.

### 0.3. Bảo toàn Header & Footer, chỉ thay thế nội dung và cập nhật DOI
- **Giữ nguyên Header & Footer**: BẮT BUỘC giữ nguyên cấu trúc phân trang, lề trang (`w:sectPr`), First Page Header, First Page Footer, Running Header và Running Footer có sẵn trong file template `VJST-[ID].docx`.
- **Chỉ thay thế nội dung**: Chỉ xóa hoặc thay thế các đoạn văn/bảng biểu mẫu trong phần thân bài (`doc._body`), tuyệt đối không xóa bỏ `sectPr` hay can thiệp phá vỡ cấu trúc header/footer.
- **Cập nhật DOI (Chỉ thay thế mã bài vào 'xx')**:
  - Trong Header trang đầu (First Page Header), đoạn DOI mẫu chứa style `001Journalname`, run `DOI: ` và thẻ `<w:hyperlink>` màu xanh dương `0000FF` (`https://doi.org/10.15625/2525-2518/xx`).
  - **CHỈ THAY THẾ MÃ BÀI BÁO `[ID]` VÀO KÝ TỰ `xx`**:
    - Thay thế text hiển thị: `https://doi.org/10.15625/2525-2518/[ID]` (chỉ đổi `xx` thành `[ID]`).
    - Cập nhật target URL trong relationship `rId1` của header: `https://doi.org/10.15625/2525-2518/[ID]`.
    - **TUYỆT ĐỐI KHÔNG** gán `p.text = ...` vì sẽ làm mất thẻ `<w:hyperlink>` và làm mất màu xanh hyperlink chuẩn của template.

### 0.4. Quy tắc bắt buộc: Tô chữ màu GREEN (Xanh lá) cho MỌI điểm thay đổi nội dung
- **Khi chuẩn hóa hoặc có bất kỳ thay đổi nào về nội dung** (dù nhỏ nhất như sửa chính tả, chuẩn hóa địa danh, in nghiêng danh pháp Latin, thêm khoảng trắng đơn vị SI/%, sửa affiliation, chuẩn hóa metadata tài liệu tham khảo theo CSL, chuẩn hóa tiêu đề/tác giả/email/lịch sử...):
  - **BẮT BUỘC ĐỔI MÀU CHỮ CỦA PHẦN THAY ĐỔI SANG MÀU XANH LÁ (Green color)**.
  - Mã màu chuẩn: `#008000` (hoặc `#00B050`), RGB: `(0, 128, 0)`.
  - Trong `python-docx`:
    ```python
    from docx.shared import RGBColor
    # Gán màu xanh lá cho run có nội dung thay đổi/chuẩn hóa:
    run.font.color.rgb = RGBColor(0, 128, 0)
    ```
  - Mục đích: Giúp tác giả và Ban biên tập nhận diện trực quan, rõ ràng 100% tất cả các vị trí đã được can thiệp hoặc chuẩn hóa trong bản thảo Word.

---

## 1. Tài liệu và Bài mẫu đối soát chuẩn
- **File CSL quy chuẩn Reference**: `.../VJST/04-Publication/vietnam-journal-of-science-and-technology.csl`
- **File bài mẫu chuẩn xuất bản (Benchmark)**: `.../VJST/04-Publication/2026/VOL64N4/07-Final/VJST-0-REV-23683-ĐD2-30-07-2026.docx`

---

## 2. Hệ thống Style chuẩn của VJST Word Template

| Phần | Style áp dụng | Căn lề (Alignment) | Quy cách chi tiết & Quy tắc Tô màu Green |
| :--- | :--- | :---: | :--- |
| **Loại bài báo** | `008_Section 1.` | **Căn giữa (Center)** | 11pt Bold (`RESEARCH PAPER` hoặc `REVIEW PAPER`). |
| **Tiêu đề bài báo** | `002_Title` | **Căn giữa (Center)** | 18pt Bold, Sentence case. Tô green các từ được sửa chữ hoa/thường hoặc tên loài in nghiêng. |
| **Tác giả (Authors)** | `003_Author` | **Căn giữa (Center)** | 12pt Bold. **Chỉ số affiliation và dấu `*` BẮT BUỘC SUPERSCRIPT**. Tô green nếu có sửa đổi. |
| **Địa chỉ (Affiliation)**| `004_Affiliation` | **Căn giữa (Center)** | 11pt Italic. **Chỉ số đầu dòng BẮT BUỘC SUPERSCRIPT**. Tô green địa danh `Viet Nam`, `Ha Noi` chuẩn hóa. |
| **Email liên hệ** | `005_Email` | **Căn giữa (Center)** | 10pt; `*Email: ...` hoặc `*Emails: ...`. |
| **Lịch sử bài báo** | `006_History` | **Căn giữa (Center)** | 10pt; `Received: ...; Accepted for publication: ...`. |
| **Tóm tắt (Abstract)** | `007_Abstract` | **Căn đều 2 bên (Justify)** | 11pt, run đầu **`Abstract. `** in đậm. Tô green các điểm sửa chính tả / đơn vị SI. |
| **Keywords** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | Run `Keywords:` in nghiêng, theo sau là danh sách từ khóa. Tô green các từ chuẩn hóa. |
| **Classification numbers** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | Run `Classification numbers:` in nghiêng, theo sau là các mã số (ví dụ `2.5.2, 2.5.3.`). |
| **Tiêu đề mục cấp 1** | `008_Section 1.` | **Căn giữa (Center)** | 11pt Bold, Sentence case (ví dụ `1. Introduction`, `2. Materials and methods`...). |
| **Tiêu đề mục cấp 2** | `009_Subsection 1.1.` | **Căn trái (Left)** | 11pt Bold, Sentence case (ví dụ `2.1. Materials`...). |
| **Tiêu đề mục cấp 3** | `010_Subsubsection 1.1.1.` | **Căn trái (Left)** | 11pt Bold Italic (ví dụ `2.4.1. Characterization...`). |
| **Đoạn văn nội dung** | `000_Text` | **Căn đều 2 bên (Justify)** | 11pt. In nghiêng danh pháp sinh học (*Kerria lacca*, *E. coli*), chỉ số hóa học. **Tô green toàn bộ các điểm sửa lỗi chính tả, in nghiêng danh pháp, thêm dấu cách `%`/đơn vị**. |
| **Ảnh minh họa** | `012_Figure` | **Căn giữa (Center)** | Căn giữa, chứa hình ảnh chất lượng cao (~5.5 inches). |
| **Chú thích hình** | `013_FigCap` | **Căn giữa (Center)** | Căn giữa; ví dụ *Figure 1.* Chú thích... |
| **Chú thích bảng** | `013_TableCap` | **Căn giữa (Center)** | Căn giữa; ví dụ *Table 1.* Chú thích... |
| **Nội dung bảng** | `014_Table` | **Bảng căn giữa trang** | Kẻ viền 3 dòng khoa học (bỏ viền dọc), header in đậm, số liệu căn giữa. |
| **Lời cảm ơn** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***Acknowledgments.*** theo sau là nội dung tài trợ/cảm ơn. |
| **Đóng góp tác giả** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***CRediT authorship contribution statement.*** theo sau là phân công vai trò. |
| **Xung đột lợi ích** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***Declaration of competing interest.*** theo sau là lời tuyên bố. |
| **Tài liệu tham khảo** | `016_Tailieuthamkhao` | **Căn đều 2 bên (Justify)** | Định dạng theo CSL `vietnam-journal-of-science-and-technology.csl`. **Tô green các thông tin được bổ sung/chuẩn hóa (Volume in đậm, tên viết tắt, DOI link, tác giả)**. |

---

## 3. Quy chuẩn trình bày References theo `vietnam-journal-of-science-and-technology.csl`

- Thứ tự tác giả: `Họ Tên_viết_tắt` (ví dụ: `Sothornvit R., Krochta J. M.`). Nếu $\le 6$ tác giả thì liệt kê đủ; nếu $\ge 7$ tác giả thì liệt kê 6 tác giả đầu + `et al.`.
- Tên bài báo: Sentence case, in nghiêng tên loài hoặc công thức hóa học nếu có.
- Tên tạp chí: Viết tắt chuẩn ISO 4, có dấu chấm sau mỗi từ viết tắt.
- Tập / Số / Trang: **Volume in đậm**, (Năm) trong ngoặc đơn, dải trang nối bằng gạch en-dash `–` (ví dụ: **48** (2000) 6298–6302).
- DOI: Dạng URL đầy đủ `https://doi.org/...`.
- **Tô màu green** cho các trường thông tin được bổ sung/chuẩn hóa so với bản gốc của tác giả.

---

## 4. Quy trình thực hiện tự động bằng Python

Khi người dùng yêu cầu chuẩn hóa bản thảo vào template trong thư mục bài báo (ví dụ `.../VOL64N5/0-REV-23881`):

### Bước 1: Khảo sát và chuẩn bị môi trường
1. Sử dụng `uv run --with python-docx --with pillow python3` để xử lý `.docx` và trích xuất hình ảnh.
2. Xác định file bản thảo gốc (tác giả gửi) và file template đích (`VJST-[ID].docx` hoặc `VJST.docx`).
3. **Tự động tạo file sao lưu (Backup copy)**: Luôn tạo file backup theo quy tắc tăng dần `[Tên file]-backup(N).docx` (ví dụ `VJST-1-NAT-19436-backup(1).docx`) trước khi thực hiện bất kỳ chỉnh sửa nào.

### Bước 2: Trích xuất hình ảnh và phân tích toàn vẹn XML
1. Mở file `.docx` gốc như một file zip, trích xuất tất cả media trong `word/media/` ra thư mục tạm scratch.
2. Quét đệ quy qua các phần tử XML để bảo đảm không thất lạc bất kỳ bảng biểu, hình vẽ hay công thức nào.

### Bước 3: Khởi tạo và ghi nội dung vào file Template
1. Mở file template `VJST-[ID].docx`, bảo toàn nguyên vẹn `sectPr`, First Page Header/Footer và Running Header.
2. **Cập nhật DOI trong First Page Header (Chỉ thay `xx` thành mã bài `[ID]`)**:
   ```python
   def update_header_doi(doc, article_id):
       header = doc.sections[0].first_page_header
       for p in header.paragraphs:
           for t in p._p.xpath('.//w:t'):
               if "2525-2518" in t.text or "doi.org" in t.text:
                   t.text = re.sub(r'(2525-2518/)(xx|\d+)', rf'\g<1>{article_id}', t.text)
       for rel_id, rel in list(header.part.rels.items()):
           if "2525-2518" in rel.target_ref:
               rel._target = re.sub(r'(2525-2518/)(xx|\d+)', rf'\g<1>{article_id}', rel.target_ref)
   ```
3. Xóa các phần tử body mẫu cũ (giữ lại `sectPr`).
4. Ghi lần lượt các khối nội dung với đúng style VJST.
5. **Áp dụng tô màu green (`RGBColor(0, 128, 0)`) cho toàn bộ các run có nội dung được chuẩn hóa, sửa lỗi chính tả, in nghiêng danh pháp, thêm dấu cách `%`/đơn vị SI, hoặc bổ sung metadata tài liệu tham khảo**.
6. Lưu file đích `VJST-[ID].docx`.

---

## 5. Quy chuẩn 2 Báo cáo Kiểm tra (Post-processing Reports)

Sau khi hoàn tất định dạng file Word, tự động tạo 2 file báo cáo bằng Markdown lưu trực tiếp trong thư mục bài báo:

### 1. `REPORT-PROOFREADING-[ID].md` (Báo cáo Hiệu đính, Quy chuẩn Biên tập & Trích dẫn Nội văn)
- **Kiểm tra trích dẫn nội văn (In-text citations)**:
  - **Hình ảnh (Figures)**: Dẫn chiếu Figure 1, Figure 2... trong nội văn.
  - **Bảng biểu (Tables)**: Dẫn chiếu Table 1, Table 2... trong nội văn.
  - **Tài liệu tham khảo (References)**: Dẫn chiếu `[1]` đến `[N]`. **BẮT BUỘC kiểm tra thứ tự trích dẫn (Sequential Order)** xuất hiện lần đầu tăng dần ($[1], [2], [3]\dots$).
- **Hệ đơn vị đo lường chuẩn SI & Ký hiệu %**: Rà soát khoảng cách số và đơn vị/%.
- **Địa danh và tên cơ quan**: Quy chuẩn `Viet Nam`, `Ha Noi`.
- **Chính tả và Danh pháp tiếng Anh**: Rà soát in nghiêng tên loài sinh học, từ chuyên ngành.
- **Cấu trúc báo cáo**:
  1. Bảng tổng quan trạng thái.
  2. Báo cáo chi tiết trích dẫn nội văn (Hình, Bảng, Refs).
  3. Bảng chi tiết các điểm đã được chuẩn hóa (tương ứng với các vị trí tô chữ màu green trong file Word).
  4. Kiến nghị dành cho Biên tập viên.

### 2. `REPORT-REFERENCES-[ID].md` (Báo cáo Đối soát Tài liệu Tham khảo theo `/check-ref`)
- Đối soát 100% tài liệu tham khảo với CSDL trực tuyến (Crossref API & Google Scholar).
- Bảng tổng hợp đối soát (Tổng số, Khớp 100%, Sai lệch/Bổ sung, Mã DOI hợp lệ).
- Bảng đối soát chi tiết từng Reference kèm trạng thái xác thực.

---

## 6. Tệp đầu ra bàn giao

1. `[Tên file]-backup(N).docx`: Bản sao lưu an toàn được tạo tự động trước khi chỉnh sửa.
2. `VJST-[ID].docx`: File Word chuẩn hóa theo template VJST, **đã tô chữ màu green cho tất cả các điểm thay đổi/chuẩn hóa nội dung**.
3. `REPORT-PROOFREADING-[ID].md`: Báo cáo hiệu đính và trích dẫn nội văn.
4. `REPORT-REFERENCES-[ID].md`: Báo cáo đối soát tài liệu tham khảo.
