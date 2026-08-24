---
name: vjst-word
description: "Chuẩn hóa định dạng file Word VJST dựa trên nội dung đã được copy sẵn vào file. Áp dụng quy tắc nghiêm ngặt nhất: TUYỆT ĐỐI KHÔNG THAY ĐỔI NỘI DUNG, CHỈ THAY ĐỔI FORMAT/STYLE. Tự động kiểm tra và chuẩn hóa toàn diện theo Checklist Hậu kiểm: nhiệt độ °C, dấu âm −, số mũ SI (10⁻⁹, cm⁻¹), gạch en-dash –, in nghiêng biến số (R², Epc, ipc, in situ), làm sạch mã trường EndNote/REF. Mọi sửa đổi nội dung (chính tả, nhầm lẫn tác giả) BẮT BUỘC báo cáo user duyệt trước. Tự động backup 1 lần [Tên file]-backup(N).docx ở đầu lượt chat. Cập nhật DOI header và tạo 2 file báo cáo kiểm tra. Alias: /vjst-word"
---

# vjst-word: Chuẩn hóa Định dạng Word Toàn diện cho Tạp chí VJST (Format-Only & Scientific Typography)

Kỹ năng này thực hiện chuẩn hóa định dạng (format/style) trực tiếp trên file Word đã có sẵn nội dung (người dùng tự copy nội dung vào file Word/template VJST), tuân thủ các nguyên tắc nghiêm ngặt sau:

1. **Tự động sao lưu file backup** theo quy tắc tăng dần `[Tên file]-backup(N).docx` duy nhất 1 lần ở đầu mỗi lượt chat trước khi sửa đổi.
2. **QUY TẮC NGHIÊM NGẶT NHẤT — BẢO TOÀN NỘI DUNG TUYỆT ĐỐI (FORMAT-ONLY)**:
   - **TUYỆT ĐỐI KHÔNG THAY ĐỔI NỘI DUNG**: Không viết lại (rewrite), không diễn giải (paraphrase), không tóm tắt, không tự ý sửa đổi/thêm bớt số liệu thực nghiệm, hóa chất, thông số kỹ thuật, phương trình hay câu chữ của tác giả.
   - **CHỈ THAY ĐỔI FORMAT/STYLE**: Áp dụng hệ thống Style VJST, căn lề chuẩn (Center, Left, Justify), kẻ bảng 3 dòng khoa học, căn giữa hình ảnh/chú thích, chuẩn hóa format tài liệu tham khảo theo VJST CSL, và cập nhật mã bài vào Header DOI.
3. **CHECKLIST CHUẨN HÓA KHOA HỌC & TYPOGRAPHY (BẮT BUỘC KIỂM TRA & THỰC HIỆN)**:
   - **Nhiệt độ °C**: Luôn có khoảng trắng trước `°C` (ví dụ: `60 °C`, `25 °C`), dùng ký tự độ chuẩn `°` (Unicode `\u00B0`), cấm dùng chữ cái `o` (`60oC`).
   - **Dấu trừ & Dấu âm toán học `−`**: Dùng dấu trừ Unicode `−` (`\u2212`) cho thế điện hóa âm (`−0.7 V`, `−1.8 V`), hệ số âm trong phương trình (không để khoảng trắng thừa như `- 0.115`), và dải giá trị.
   - **Số mũ khoa học & Đơn vị SI**: Tạo superscript chuẩn cho lũy thừa ($10^{-9}$, $10^{-4}$), đơn vị diện tích ($	ext{cm}^2$), đơn vị nghịch đảo ($	ext{cm}^{-1}$, $	ext{s}^{-1}$, $	ext{mol L}^{-1}$, $	ext{V pH}^{-1}$), dấu nhân `×` (thay vì chữ cái `x`).
   - **Dải số trang & Dải giá trị (En-dash `–`)**: Tất cả dải số trang trong References (`1–4`, `515–533`...) và dải giá trị phải dùng gạch en-dash `–` thay vì gạch ngắn hyphen `-`.
   - **Gỡ bỏ mã trường rác & Unlink EndNote**: Tự động gỡ bỏ (unlink) 100% mã trường EndNote (`ADDIN EN.CITE...`, `EN.REFLIST`) chuyển thành **Static Text sạch**, xóa sạch chuỗi mã trường Word rác (`REF _Ref... \h \* MERGEFORMAT`).
   - **Quy chuẩn In nghiêng (Italics) & Chữ đứng (Roman)**:
     - *In nghiêng*: Thuật ngữ Latinh (*in situ*, *operando*, *et al.*), Biến số toán/điện hóa (*R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>, $\Delta$*i*<sub style="">pc</sub>, *E*$_0$, *T*, *R*, *F*, *n*, *K*<sub style="">s</sub>, *m/n*, *SD*), Tiền tố chú thích hình (*Figure 1.*, *Figure 2.*), Tiền tố chú thích bảng (*Table 1.*).
     - *Chữ đứng*: `pH`, `SWV`, `CV`, `SWCSV`, `AAS`, `ICP-MS`, `FE-SEM`, `XRD`, `XPS`, `Ag/AgCl`, `Pt`.
   - **Công thức hóa học & Dấu chấm ngậm nước**: Ký hiệu độ góc XRD `16.2°`, dấu chấm giữa cho tinh thể ngậm nước `MnCl2·4H2O`, `Cu(NO3)2·3H2O`.
4. **MỌI SỬA ĐỔI NỘI DUNG BẮT BUỘC PHẢI BÁO CÁO USER DUYỆT TRƯỚC**:
   - Khi phát hiện lỗi chính tả, sai sót số liệu, lỗi ngữ pháp, sai thứ tự mục hoặc nhầm lẫn của tác giả $\rightarrow$ **BẮT BUỘC liệt kê và báo cáo cho user quyết định trước, TUYỆT ĐỐI KHÔNG TỰ Ý SỬA**.
   - Chỉ khi user đồng ý phê duyệt sửa đổi thì mới thực hiện sửa và tô màu xanh lá chuẩn `#2F6C1B` cho đúng từ/ký tự được sửa đó.
5. Tạo **2 file báo cáo kiểm tra độc lập** (`REPORT-PROOFREADING-[ID].md` và `REPORT-REFERENCES-[ID].md`) trong thư mục bài báo.

---

## 0. Quy tắc Cốt lõi & Bất biến

### 0.1. Tự động tạo đúng 1 file Backup ở đầu mỗi lượt chat (Bắt buộc)
- **Tần suất**: **Chỉ tạo đúng 1 bản backup ở đầu mỗi lượt yêu cầu của người dùng (sau mỗi lần chat thêm)** trước khi sửa đổi file Word đích (`VJST-[ID].docx` hoặc file cần sửa). Tuyệt đối **không tạo nhiều bản backup trung gian** trong cùng 1 lần chat.
- **Quy cách đặt tên file Backup**:
  $$\text{<Tên file cần chuẩn hóa (bỏ đuôi .docx)>-backup(N).docx}$$
  - Lần chuẩn hóa đầu tiên: `[Tên file]-backup(1).docx` (ví dụ: `VJST-2-MAT-19150-backup(1).docx`)
  - Lần sửa đổi/bổ sung ở các lượt chat tiếp theo: Tự động tăng dần chỉ số `N` lên thành `[Tên file]-backup(2).docx`, `[Tên file]-backup(3).docx`...
  - **Hàm Python tạo Backup tăng dần**:
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

### 0.2. Quy tắc nghiêm ngặt nhất: Bảo toàn nội dung tuyệt đối (Format-Only)
- **Người dùng copy sẵn nội dung vào file Word**: Agent chỉ làm việc trực tiếp trên file Word đó.
- **Không thay đổi nội dung**: Giữ nguyên vẹn 100% từng câu chữ, đoạn văn, số liệu, hóa chất, công thức, phương trình và lập luận của tác giả. Không được tự ý paraphrase hay tóm tắt dưới bất kỳ hình thức nào.
- **Bảo toàn cấu trúc trang**: Giữ nguyên vẹn `sectPr`, First Page Header, First Page Footer, Running Header và Running Footer của template.

### 0.3. Quy tắc phê duyệt sửa đổi nội dung (No Silent Edits)
- Mọi trường hợp phát hiện lỗi (lỗi chính tả tiếng Anh, sai địa danh, lỗi ký tự font, nhầm lẫn số thứ tự mục, sai sót số liệu...):
  1. **KHÔNG ĐƯỢC TỰ Ý SỬA** vào văn bản.
  2. **Liệt kê chi tiết vị trí, nguyên văn gốc và đề xuất sửa** trong phản hồi cho người dùng.
  3. **Chỉ thực hiện sửa sau khi người dùng đã xác nhận đồng ý**.
  4. Khi được phê duyệt sửa, **tô màu xanh lá `#2F6C1B` (`RGBColor(0x2F, 0x6C, 0x1B)`)** duy nhất cho phần chữ/ký tự được sửa đó để theo dõi.

### 0.4. Cập nhật DOI Header
- Trong Header trang đầu (First Page Header), đoạn DOI mẫu chứa style `001Journalname`, run `DOI: ` và thẻ `<w:hyperlink>` màu xanh dương `0000FF` (`https://doi.org/10.15625/2525-2518/xx`).
- **CHỈ THAY THẾ MÃ BÀI BÁO `[ID]` VÀO KÝ TỰ `xx`**:
  - Text hiển thị: `https://doi.org/10.15625/2525-2518/[ID]` (chỉ đổi `xx` thành `[ID]`).
  - URL trong relationship `rId1`: `https://doi.org/10.15625/2525-2518/[ID]`.
  - **Giữ nguyên màu xanh dương `0000FF` của hyperlink, KHÔNG tô màu xanh lá**.
  - **TUYỆT ĐỐI KHÔNG** gán `p.text = ...` vì sẽ làm mất thẻ `<w:hyperlink>`.

---

## 1. Hệ thống Style chuẩn của VJST Word Template

| Phần | Style áp dụng | Căn lề (Alignment) | Quy cách định dạng chuẩn |
| :--- | :--- | :---: | :--- |
| **Loại bài báo** | `008_Section 1.` | **Căn giữa (Center)** | 11pt Bold (`RESEARCH PAPER` hoặc `REVIEW PAPER`). |
| **Tiêu đề bài báo** | `002_Title` | **Căn giữa (Center)** | 18pt Bold, Title/Sentence case. |
| **Tác giả (Authors)** | `003_Author` | **Căn giữa (Center)** | 12pt Bold. **Chỉ số affiliation và dấu `*` BẮT BUỘC SUPERSCRIPT**. |
| **Địa chỉ (Affiliation)**| `004_Affiliation` | **Căn giữa (Center)** | 11pt Italic. **Chỉ số đầu dòng BẮT BUỘC SUPERSCRIPT**. |
| **Email liên hệ** | `005_Email` | **Căn giữa (Center)** | 10pt; `*Email: ...` hoặc `*Emails: ...`. |
| **Lịch sử bài báo** | `006_History` | **Căn giữa (Center)** | 10pt; `Received: ...; Accepted for publication: ...`. |
| **Tóm tắt (Abstract)** | `007_Abstract` | **Căn đều 2 bên (Justify)** | 11pt, run đầu **`Abstract. `** in đậm. Giữ nguyên 100% văn bản tác giả. |
| **Keywords** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | Run `Keywords:` in nghiêng, theo sau là danh sách từ khóa. |
| **Classification numbers** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | Run `Classification numbers:` in nghiêng, theo sau là các mã số (ví dụ `2.2, 5.3.`). |
| **Tiêu đề mục cấp 1** | `008_Section 1.` | **Căn giữa (Center)** | 11pt Bold, Sentence case (ví dụ `1. Introduction`, `2. Materials and methods`...). |
| **Tiêu đề mục cấp 2** | `009_Subsection 1.1.` | **Căn trái (Left)** | 11pt Bold, Sentence case (ví dụ `2.1. Materials`...). |
| **Tiêu đề mục cấp 3** | `010_Subsubsection 1.1.1.` | **Căn trái (Left)** | 11pt Bold Italic (ví dụ `2.1.1. Chemicals`...). |
| **Đoạn văn nội dung** | `000_Text` | **Căn đều 2 bên (Justify)** | 11pt. Giữ nguyên văn bản gốc của tác giả. |
| **Ảnh minh họa** | `012_Figure` | **Căn giữa (Center)** | Chứa hình ảnh căn giữa trang (~4.5 - 5.5 inches). |
| **Chú thích hình** | `013_FigCap` | **Căn giữa (Center)** | Căn giữa; ví dụ *Figure 1.* Chú thích... (*Figure X.* in nghiêng). |
| **Chú thích bảng** | `013_TableCap` | **Căn giữa (Center)** | Căn giữa; ví dụ *Table 1.* Chú thích... (*Table X.* in nghiêng). |
| **Nội dung bảng** | `014_Table` | **Bảng căn giữa trang** | Kẻ viền 3 dòng khoa học (bỏ viền dọc), header in đậm, số liệu căn giữa/phải. |
| **Lời cảm ơn** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***Acknowledgments.*** theo sau là nội dung tài trợ/cảm ơn. |
| **Đóng góp tác giả** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***CRediT authorship contribution statement.*** theo sau là phân công vai trò. |
| **Xung đột lợi ích** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***Declaration of competing interest.*** theo sau là lời tuyên bố. |
| **Tài liệu tham khảo** | `016_Tailieuthamkhao` | **Căn đều 2 bên (Justify)** | Định dạng theo CSL `vietnam-journal-of-science-and-technology.csl` (Volume in đậm, dải trang en-dash `–`, link DOI). |

---

## 2. Quy chuẩn Trình bày References theo `vietnam-journal-of-science-and-technology.csl`

- **Tác giả**: `Họ Tên_viết_tắt` (ví dụ: `Lucchini R. G., Aschner M., Landrigan P. J., Cranmer J. M.`). Nếu $\le 6$ tác giả thì liệt kê đủ; nếu $\ge 7$ tác giả thì liệt kê 6 tác giả đầu + `et al.`.
- **Tên bài báo**: Sentence case, in nghiêng tên loài hoặc công thức hóa học nếu có.
- **Tên tạp chí**: Viết tắt chuẩn ISO 4, có dấu chấm sau mỗi từ viết tắt.
- **Tập / Số / Trang**: **Volume in đậm**, (Năm) trong ngoặc đơn, dải trang nối bằng gạch en-dash `–` (ví dụ: **64** (2018) 1–4).
- **DOI**: Dạng URL đầy đủ `https://doi.org/...`.

---

## 3. Quy trình Thực hiện Chuẩn hóa

Khi nhận yêu cầu `/vjst-word` cho một bài báo (ví dụ `VJST-2-MAT-19150.docx` hoặc file trong folder bài báo):

### Bước 1: Khởi tạo và Backup
1. **Tạo đúng 1 bản backup tăng dần**: `[Tên file]-backup(N).docx` trước khi thực hiện bất kỳ thao tác chỉnh sửa nào.
2. Đọc và phân tích cấu trúc file Word hiện tại.

### Bước 2: Cập nhật DOI Header
- Thay thế mã bài `[ID]` vào `xx` trong First Page Header (giữ nguyên hyperlink màu xanh `0000FF`, không tô xanh lá).

### Bước 3: Áp dụng Format/Style chuẩn VJST & Checklist Typography
1. Gán đúng Style và Alignment cho từng đoạn văn, tiêu đề, hình ảnh, bảng biểu và tài liệu tham khảo theo bảng Style ở Mục 1.
2. **Thực hiện Checklist Khoa học & Typography (Mục 3 ở đầu tài liệu)**:
   - Chuẩn hóa khoảng trắng `°C`, dấu âm `−`, số mũ SI, dải trang en-dash `–`, dấu nhân `×`.
   - Gỡ bỏ sạch sẽ mã trường EndNote (`ADDIN EN.CITE...`) và mã trường rác (`REF _Ref...`).
   - In nghiêng chuẩn thuật ngữ Latinh (*in situ*, *et al.*), biến số (*R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>), tiền tố chú thích (*Figure X.*).
3. Đảm bảo toàn bộ hình ảnh và caption căn giữa (`012_Figure`, `013_FigCap`), bảng căn giữa và kẻ viền 3 dòng (`014_Table`).
4. Giữ nguyên 100% nội dung chữ, số liệu, phương trình của tác giả.

### Bước 4: Báo cáo các điểm phát hiện cần sửa đổi (nếu có)
- Nếu phát hiện lỗi chính tả, sai địa danh, nhầm thứ tự mục, thiếu từ, công thức rỗng... $ightarrow$ **Dừng lại, ghi rõ vào báo cáo/chat để hỏi ý kiến user, KHÔNG tự ý sửa**.
- Chỉ khi user chỉ đạo sửa $ightarrow$ thực hiện sửa và tô xanh lá `#2F6C1B` cho đúng điểm được sửa.

### Bước 5: Thực hiện Hậu kiểm Toàn diện (Chạy Checklist Mục 5) & Tạo 2 File Báo cáo Kiểm tra
1. `REPORT-PROOFREADING-[ID].md`: Báo cáo chi tiết định dạng, trích dẫn nội văn, kết quả Checklist Hậu kiểm toàn diện và danh sách các kiến nghị sửa đổi (nếu có) chờ user duyệt.
2. `REPORT-REFERENCES-[ID].md`: Báo cáo đối soát tài liệu tham khảo với file `.bib` và Crossref/Google Scholar.

---

## 4. Tệp Đầu ra Bàn giao

1. `[Tên file]-backup(N).docx`: Bản sao lưu an toàn trước khi chuẩn hóa.
2. `VJST-[ID].docx`: File Word đã chuẩn hóa Style/Format & Typography, bảo toàn nguyên vẹn nội dung gốc.
3. `REPORT-PROOFREADING-[ID].md`: Báo cáo kiểm tra định dạng, kết quả hậu kiểm và đề xuất chỉnh sửa (nếu có).
4. `REPORT-REFERENCES-[ID].md`: Báo cáo đối soát tài liệu tham khảo.

---

## 5. Checklist Hậu kiểm Toàn diện (Mandatory Post-processing Quality Audit)

Trước khi bàn giao kết quả và tạo file `REPORT-PROOFREADING-[ID].md`, **BẮT BUỘC** chạy kiểm tra tự động qua 8 hạng mục hậu kiểm sau:

| STT | Hạng mục Hậu kiểm | Tiêu chuẩn Đạt (PASS) | Lỗi Không đạt (FAIL) |
|:---:|:---|:---|:---|
| 1 | **Nhiệt độ `°C`** | 100% có ký tự độ chuẩn `°` và khoảng trắng (ví dụ: `60 °C`, `25 °C`) | Xuất hiện `60oC`, `60°C`, `60 oC`, `60 ° C` |
| 2 | **Dấu trừ / Dấu âm `−`** | Dùng dấu trừ Unicode `−` (`\u2212`) cho thế âm (`−0.7 V`), dải thế, hệ số âm | Xuất hiện `-0.7 V`, `- 0.115` (khoảng trắng thừa) |
| 3 | **Số mũ SI & Đơn vị** | $10^{-9}$, $10^{-6}$, $10^{-4}$, $	ext{cm}^2$, $	ext{cm}^{-1}$, $	ext{s}^{-1}$, $	ext{mol L}^{-1}$, $	ext{V pH}^{-1}$, dấu nhân `×` | Dính đơn vị `0.1M`, chữ cái `x20k`, số mũ phẳng `10-9`, `cm-1` |
| 4 | **Gạch En-dash `–`** | 100% dải trang References (`1–4`, `515–533`...) dùng en-dash `–` (`\u2013`) | Dùng gạch ngắn hyphen `1-4`, `515-533` trong dải trang |
| 5 | **Làm sạch Mã trường** | 0 mã trường EndNote (`ADDIN EN.CITE...`) và 0 mã rác `REF _Ref...` | Còn sót mã trường nhúng XML hoặc chuỗi `MERGEFORMAT` |
| 6 | **In nghiêng / Chữ đứng** | In nghiêng *in situ*, *operando*, *et al.*, *R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>, *Figure X.*; Chữ đứng `pH`, `SWV` | Biến số hoặc từ Latinh để chữ đứng thường |
| 7 | **Dính chữ / Trích dẫn** | Không có ký hiệu trích dẫn dính vào giữa từ ngữ | Xuất hiện lỗi như `concentrati[1]ons` |
| 8 | **Công thức & Dấu ngoặc** | Phát hiện và báo cáo các công thức rỗng dấu ngoặc (như `() ln ()`) | Để sót công thức rỗng mà không báo cáo |
