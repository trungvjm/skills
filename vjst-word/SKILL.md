---
name: vjst-word
description: "Chuẩn hóa định dạng file Word VJST trên nội dung có sẵn: Format-Only, bảo toàn 100% nội dung, quét sâu 8 phân đoạn theo Checklist Hậu kiểm 11 tiêu chuẩn (thống nhất đơn vị mV/s và mol/L, % có khoảng cách, địa danh Ha Noi/Viet Nam giữ tên cơ quan, °C, dấu âm −, số mũ SI, en-dash –, in nghiêng tên loài và biến số toán, sub/superscript công thức/ion, sạch EndNote, dấu câu). Mọi sửa lỗi nội dung phải được user duyệt trước và tô xanh lá #2F6C1B vi mô. Tự động backup 1 lần đầu chat, cập nhật DOI header và tạo 2 báo cáo kiểm tra. Alias: /vjst-word"
---

# vjst-word: Chuẩn hóa Định dạng Word Toàn diện cho Tạp chí VJST

Chuẩn hóa trực tiếp trên file Word đã có nội dung (người dùng tự copy vào file/template VJST), tuân thủ nghiêm ngặt các nguyên tắc sau:

---

## 1. Nguyên tắc Cốt lõi & Bất biến

1. **Tự động tạo đúng 1 bản Backup ở đầu lượt chat**: `[Tên file]-backup(N).docx` với chỉ số `N` tăng dần trước khi thực hiện bất kỳ chỉnh sửa nào.
2. **Bảo toàn nội dung tuyệt đối (Format-Only)**:
   - **TUYỆT ĐỐI KHÔNG SỬA ĐỔI NỘI DUNG**: Không viết lại (rewrite), không paraphrase, không tóm tắt, không tự ý sửa số liệu, công thức, hóa chất hay câu chữ của tác giả.
   - **CHỈ THAY ĐỔI FORMAT/STYLE**: Áp dụng Style chuẩn VJST, căn lề, kẻ bảng 3 dòng khoa học, căn giữa ảnh/chú thích, chuẩn hóa References theo VJST CSL, cập nhật DOI Header.
3. **Phê duyệt sửa đổi & Tô màu Vi mô (`#2F6C1B`)**:
   - Khi phát hiện lỗi chính tả, sai số liệu, nhầm thứ tự mục, công thức rỗng... $\rightarrow$ **BÁO CÁO CHO USER DUYỆT TRƯỚC, KHÔNG TỰ Ý SỬA**.
   - Khi được duyệt, **tô màu xanh lá `#2F6C1B` (`RGBColor(0x2F, 0x6C, 0x1B)`)** duy nhất cho đúng từ/ký tự/dấu được sửa (Micro-targeted, không tô cả cụm hay cả câu).
4. **Cập nhật DOI Header**: Thay mã bài `[ID]` vào `xx` trong `https://doi.org/10.15625/2525-2518/xx` (giữ nguyên hyperlink màu xanh dương `0000FF`, không tô xanh lá).

---

## 2. Hệ thống Style chuẩn VJST Word Template

| Phần | Style áp dụng | Căn lề | Quy cách chuẩn |
| :--- | :--- | :---: | :--- |
| **Loại bài báo** | `008_Section 1.` | Giữa | 11pt Bold (`RESEARCH PAPER` hoặc `REVIEW PAPER`). |
| **Tiêu đề bài báo** | `002_Title` | Giữa | 18pt Bold, Sentence case, in nghiêng tên loài sinh học nếu có. |
| **Tác giả (Authors)** | `003_Author` | Giữa | 12pt Bold. Chỉ số affiliation và dấu `*` **SUPERSCRIPT**. |
| **Địa chỉ (Affiliation)**| `004_Affiliation` | Giữa | 11pt Italic. Chỉ số đầu dòng **SUPERSCRIPT**. |
| **Email liên hệ** | `005_Email` | Giữa | 10pt; `*Email: ...` hoặc `*Emails: ...`. |
| **Lịch sử bài báo** | `006_History` | Giữa | 10pt; `Received: ...; Accepted for publication: ...`. |
| **Tóm tắt (Abstract)** | `007_Abstract` | Đều 2 bên | 11pt, đầu đoạn **`Abstract. `** in đậm. In nghiêng tên loài. |
| **Keywords / Classification** | `007_Keyword-Classification` | Đều 2 bên | Run `Keywords:` / `Classification numbers:` in nghiêng. |
| **Tiêu đề mục cấp 1** | `008_Section 1.` | Giữa | 11pt Bold, Sentence case (`1. Introduction`...). |
| **Tiêu đề mục cấp 2 / 3** | `009_Subsection 1.1.` / `010_Sub...` | Trái | 11pt Bold (Cấp 2) / 11pt Bold Italic (Cấp 3). |
| **Đoạn văn nội dung** | `000_Text` | Đều 2 bên | 11pt Regular. |
| **Ảnh minh họa / Bảng biểu** | `012_Figure` / `014_Table` | Giữa | Ảnh căn giữa (~4.5–5.5 in); Bảng kẻ 3 dòng khoa học (bỏ viền dọc). |
| **Chú thích hình / Bảng** | `013_FigCap` / `013_TableCap` | Giữa | *Figure X.* / *Table X.* in nghiêng, kết thúc bằng dấu chấm `.`. |
| **Backmatter (Lời cảm ơn...)**| `007_Keyword-Classification` | Đều 2 bên | ***Acknowledgments.***, ***CRediT authorship...***, ***Declaration...***. |
| **Tài liệu tham khảo** | `016_Tailieuthamkhao` | Đều 2 bên | Chuẩn CSL VJST: **Volume in đậm**, (Năm), dải trang en-dash `–`, DOI, kết thúc `.`. |

---

## 3. Quy trình 8 Phân đoạn (Quét sâu & Chậm — Không vội vàng)

Thực hiện rà soát tuần tự, độc lập và chi tiết qua 8 phân đoạn:
1. **Metadata & Frontmatter**: Tiêu đề, tác giả, superscript affiliation, email, địa chỉ `Ha Noi, Viet Nam` (giữ nguyên tên cơ quan chính thức).
2. **Abstract & Keywords**: `Abstract.`, in nghiêng tên loài, công thức có chỉ số, số mũ, từ khóa.
3. **Introduction**: Trích dẫn nội văn `[1]`, `[1–3]`, tên vật liệu, chữ viết tắt, dấu câu.
4. **Materials and methods**: Hóa chất ngậm nước `·`, nồng độ `mol/L`, `%` có khoảng cách, nhiệt độ `°C`, góc XRD `°`, scan rate `mV/s`.
5. **Results and discussion**: Phổ đo, công thức hóa học & ion ($	ext{Mn}^{2+}$, $	ext{S}^{2-}$), biến số (*R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>, *E*$_0$, *K*<sub style="">s</sub>), dấu âm Unicode `−`, dải thế, phương trình toán.
6. **Figures & Tables**: Căn giữa ảnh, gán đúng style `013_FigCap` / `013_TableCap` (*Figure X.*, *Table X.* kết thúc bằng dấu chấm `.`), tránh nhầm lẫn text thân bài thành FigCap.
7. **Conclusions & Backmatter**: Mục `Conclusions`, *Acknowledgments.*, *CRediT...*, *Declaration...*.
8. **References**: Định dạng CSL, số tác giả, Volume in đậm, năm (YYYY), trang en-dash `–`, link DOI, in nghiêng tên loài/chỉ số công thức, kết thúc bằng dấu chấm `.` cho 100% tài liệu.

---

## 4. Checklist Hậu kiểm Toàn diện (11 Tiêu chuẩn Bắt buộc)

| STT | Tiêu chuẩn Hậu kiểm | Chuẩn Đạt (PASS) | Lỗi Không đạt (FAIL) |
|:---:|:---|:---|:---|
| 1 | **Tính thống nhất toàn bài** | Thống nhất 100% tên vật liệu (`Cu-Mo-S`), tên biến (`scan rate`), ưu tiên đơn vị có dấu `/` (`mV/s`, `V/s`, `mol/L`, `µM`, `µA`), tham chiếu (`Figure X`), dải trích dẫn `[1–3]` | Bất nhất `Cu−Mo−S`, `scanrate`, `scanning speed`, lẫn lộn `mV s⁻¹` và `mV/s` |
| 2 | **Nhiệt độ `°C`** | Ký tự độ chuẩn `°` và có khoảng cách (`60 °C`, `25 °C`) | `60oC`, `60°C`, `60 oC` |
| 3 | **Dấu trừ / Dấu âm `−`** | Dùng dấu trừ Unicode `−` (`\u2212`) cho thế âm (`−0.7 V`), dải thế, hệ số âm (`−0.115`) | Dùng hyphen `-0.7 V`, thừa khoảng cách `- 0.115` |
| 4 | **Số mũ SI & Đơn vị** | $10^{-9}$, $10^{-4}$, $	ext{cm}^2$, $	ext{cm}^{-1}$, $	ext{mol/L}$, $	ext{V/pH}$, dấu nhân `×` | Dính đơn vị `0.1M`, chữ `x20k`, số mũ phẳng `10-9`, `cm-1` |
| 5 | **Chỉ số Công thức Hóa học & Ion** | Subscript cho số nguyên tử ($	ext{Cu}_2	ext{MoS}_4$, $	ext{MoS}_2$, $	ext{H}_2	ext{O}$); Superscript cho điện tích ion ($	ext{Mn}^{2+}$, $	ext{S}^{2-}$, $	ext{Cu}^+$) cả bài và Ref | Công thức phẳng `Cu2MoS4`, `MoS2`, `Mn2+`, `S2-` |
| 6 | **Gạch En-dash `–`** | 100% dải trang References (`1–4`, `515–533`...) dùng en-dash `–` (`\u2013`) | Dùng hyphen `1-4`, `515-533` trong dải trang |
| 7 | **Làm sạch Mã trường & Dấu rác** | 0 mã trường EndNote (`ADDIN EN.CITE...`), 0 mã rác `REF _Ref...`, 0 dấu rác `,- ` trong Ref | Sót mã trường nhúng XML, chuỗi `MERGEFORMAT` hoặc dấu `,- ` |
| 8 | **In nghiêng Tên loài & Biến số** | In nghiêng tên loài (*E. coli*), biến số toán/lý/thống kê (*x*, *y*, *t*, *R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>, *SD*, *ν*, *2θ*), từ Latinh (*in situ*), tiền tố *Figure X.*, *Table X.*. Giữ chữ đứng cho hàm số ($\sin$, $\ln$), đơn vị ($	ext{V}$, $	ext{pH}$) và từ viết tắt (CV, SWV) | Tên loài, biến số toán hoặc từ Latinh để chữ đứng thường |
| 9 | **Lỗi dính chữ, thừa/thiếu space** | `%` có khoảng cách (`99 %`); không dính mã trích dẫn (`concentrations`); không dính đơn vị (`0.1 M`); không thừa space trước dấu câu hoặc sau dấu âm | Dính chữ `95%`, `concentrati[1]ons`, dính đơn vị `0.1M`, thừa space `Ha Noi , Viet Nam` |
| 10 | **Lỗi thiếu dấu / thừa dấu câu** | Đầy đủ dấu chấm kết thúc caption hình/bảng và references; tiền tố dùng `Figure X.` (không dùng `Figure X:`); xóa sạch dấu `,- ` trong Ref | Caption thiếu dấu chấm; dùng `Figure X:`; sót dấu rác `,- ` sau tác giả trong Ref; lệch ngoặc |
| 11 | **Công thức & Dấu ngoặc** | Phát hiện và báo cáo các công thức rỗng dấu ngoặc (như `() ln ()`) cho user xem xét | Để sót công thức rỗng mà không báo cáo |

---

## 5. Tệp Bàn giao

1. `[Tên file]-backup(N).docx`: Bản sao lưu an toàn trước khi chuẩn hóa.
2. `VJST-[ID].docx`: File Word đã chuẩn hóa Style/Format & Typography, bảo toàn nguyên vẹn nội dung gốc.
3. `REPORT-PROOFREADING-[ID].md`: Báo cáo chi tiết định dạng, trích dẫn nội văn, kết quả 11 tiêu chuẩn hậu kiểm và các điểm đã sửa / chờ duyệt.
4. `REPORT-REFERENCES-[ID].md`: Báo cáo đối soát tài liệu tham khảo với `.bib` và Crossref/Google Scholar.
