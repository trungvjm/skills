---
name: vjst-word
description: "Chuẩn hóa định dạng file Word VJST dựa trên nội dung đã được copy sẵn vào file. Áp dụng quy tắc nghiêm ngặt nhất: TUYỆT ĐỐI KHÔNG THAY ĐỔI NỘI DUNG, CHỈ THAY ĐỔI FORMAT/STYLE. Quy tắc quét sâu và quét chậm từng phần (không vội vàng) theo Checklist Hậu kiểm: % có khoảng cách, địa danh Ha Noi/Viet Nam (giữ nguyên tên cơ quan), nhiệt độ °C, dấu âm −, số mũ SI (10⁻⁹, cm⁻¹), gạch en-dash –, in nghiêng tên loài sinh học (E. coli), in nghiêng biến số toán học (R², Epc, ipc, x, y, ν, 2θ), làm sạch mã trường EndNote/REF, xử lý lỗi dính chữ, thừa/thiếu space, lỗi thiếu dấu câu, chuẩn hóa chỉ số trên/dưới cho công thức hóa học/ion (Cu₂MoS₄, Mn²⁺, S²⁻), ưu tiên đơn vị có dấu gạch chéo (mV/s, mol/L) và đảm bảo tính thống nhất của cách dùng trong bài. Mọi sửa đổi nội dung (chính tả, nhầm lẫn tác giả) BẮT BUỘC báo cáo user duyệt trước. Tự động backup 1 lần [Tên file]-backup(N).docx ở đầu lượt chat. Cập nhật DOI header và tạo 2 file báo cáo kiểm tra. Alias: /vjst-word"
---

# vjst-word: Chuẩn hóa Định dạng Word Toàn diện cho Tạp chí VJST (Format-Only & Scientific Typography)

Kỹ năng này thực hiện chuẩn hóa định dạng (format/style) trực tiếp trên file Word đã có sẵn nội dung (người dùng tự copy nội dung vào file Word/template VJST), tuân thủ các nguyên tắc nghiêm ngặt sau:

1. **Tự động sao lưu file backup** theo quy tắc tăng dần `[Tên file]-backup(N).docx` duy nhất 1 lần ở đầu mỗi lượt chat trước khi sửa đổi.
2. **QUY TẮC NGHIÊM NGẶT NHẤT — BẢO TOÀN NỘI DUNG TUYỆT ĐỐI (FORMAT-ONLY)**:
   - **TUYỆT ĐỐI KHÔNG THAY ĐỔI NỘI DUNG**: Không viết lại (rewrite), không diễn giải (paraphrase), không tóm tắt, không tự ý sửa đổi/thêm bớt số liệu thực nghiệm, hóa chất, thông số kỹ thuật, phương trình hay câu chữ của tác giả.
   - **CHỈ THAY ĐỔI FORMAT/STYLE**: Áp dụng hệ thống Style VJST, căn lề chuẩn (Center, Left, Justify), kẻ bảng 3 dòng khoa học, căn giữa hình ảnh/chú thích, chuẩn hóa format tài liệu tham khảo theo VJST CSL, và cập nhật mã bài vào Header DOI.
3. **QUY TẮC QUÉT SÂU VÀ QUÉT CHẬM TỪNG PHẦN (DEEP & METHODICAL SECTION-BY-SECTION AUDIT — KHÔNG VỘI VÀNG)**:
   - **Tuyệt đối không quét lướt, không làm qua loa hay vội vàng kết luận**.
   - **Bắt buộc chia và quét độc lập theo 8 phân đoạn bài báo**:
     1. *Phần 1: Metadata & Frontmatter*: Tiêu đề bài báo, Danh sách tác giả & Affiliation (kiểm tra chỉ số superscript, email liên hệ, lịch sử nhận bài, địa chỉ `Ha Noi, Viet Nam` vs tên cơ quan).
     2. *Phần 2: Abstract & Keywords*: Abstract (in đậm `Abstract. `, kiểm tra in nghiêng tên loài, công thức hóa học, số mũ, đơn vị), Keywords & Classification numbers.
     3. *Phần 3: Introduction*: Dẫn dắt, trích dẫn nội văn `[1]`, `[1–3]`, danh pháp vật liệu, phương pháp, chữ viết tắt, thuật ngữ, dấu câu.
     4. *Phần 4: Materials and methods / Experimental*: Hóa chất, công thức ngậm nước `·`, nồng độ `mol/L`, `%` có khoảng trắng, thiết bị, thông số đo đạc, nhiệt độ `°C`, góc XRD `°`, scan rate `mV/s`.
     5. *Phần 5: Results and discussion*: Phân tích phổ XRD/SEM/EDX/CV/SWV/EIS, công thức hóa học & điện tích ion ($	ext{Mn}^{2+}$, $	ext{S}^{2-}$), biến số toán/điện hóa (*R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>, *E*$_0$, *K*<sub style="">s</sub>), dấu trừ âm `−`, dải thế, phương trình toán học/điện hóa.
     6. *Phần 6: Chú thích Hình & Bảng (Figures & Tables)*: Format style `012_Figure`, `013_FigCap` (*Figure X.* in nghiêng, kết thúc bằng dấu chấm `.`), `013_TableCap` (*Table X.*), bảng 3 dòng khoa học `014_Table`, các ký hiệu subfigure (a), (b), (c)...
     7. *Phần 7: Conclusions & Backmatter*: Kết luận (đúng tên mục `Conclusions`), Lời cảm ơn (*Acknowledgments.*), Đóng góp tác giả (*CRediT authorship contribution statement.*), Xung đột lợi ích (*Declaration of competing interest.*).
     8. *Phần 8: Tài liệu tham khảo (References)*: Định dạng chuẩn VJST CSL, số lượng tác giả, in đậm Volume, năm (YYYY), dải trang en-dash `–`, link DOI, in nghiêng tên loài hoặc công thức hóa học có chỉ số, dấu chấm kết thúc `.` cho 100% tài liệu.
4. **CHECKLIST CHUẨN HÓA KHOA HỌC & TYPOGRAPHY (BẮT BUỘC KIỂM TRA & THỰC HIỆN)**:
   - **Tính thống nhất của cách dùng trong bài (Internal Consistency)**:
     - *Thuật ngữ & Tên vật liệu/phương pháp*: Thống nhất 1 cách viết xuyên suốt bài (ví dụ: `Cu-Mo-S` xuyên suốt, không lẫn lộn `Cu−Mo−S` hay `Cu - Mo - S`; `SWCSV` xuyên suốt; `scan rate` xuyên suốt, không lẫn lộn `scanrate` / `scanning speed`).
     - *Quy chuẩn Đơn vị (Ưu tiên dạng có dấu `/`)*: Ưu tiên thống nhất sử dụng đơn vị có dấu gạch chéo `/` (ví dụ: `mV/s`, `V/s`, `mol/L`, `mg/L`, `µg/L`, `g/L`, `J/(mol K)`) cho trực quan và dễ hiểu, thay vì dùng số mũ âm nghịch đảo (`mV s⁻¹`, `mol L⁻¹`). Thống nhất 100% xuyên suốt toàn bài.
     - *Ký hiệu Micro*: Thống nhất 1 chuẩn ký tự micro (`µM`, `µA`, `µg`).
     - *Tham chiếu hình/bảng*: Thống nhất cách gọi `Figure 1`, `Figure 2(a)`, `Table 1`, `Equation (1)`.
     - *Dải trích dẫn nội văn*: Thống nhất định dạng trích dẫn `[1]`, `[1, 2]`, `[1–3]` (dùng en-dash `–` cho dải số trích dẫn).
   - **Ký hiệu `%` và Đơn vị SI**: Luôn có 1 khoảng trắng giữa số và `%` (ví dụ: `99 %`, `30 %`, `5 %`, `~90 %`, `95 % confidence`).
   - **Quy chuẩn Địa danh vs Tên cơ quan**:
     - `Hanoi` $\rightarrow$ `Ha Noi`, `Vietnam` $\rightarrow$ `Viet Nam` **trong phần mô tả địa điểm** (địa chỉ hành chính, thành phố, quốc gia, ví dụ: `..., 18 Hoang Quoc Viet, Ha Noi, Viet Nam`).
     - **Tên cơ quan, trường đại học, viện nghiên cứu, đơn vị hành chính thì GIỮ NGUYÊN tên riêng tiếng Anh chính thức** (ví dụ: `University of Science and Technology of Hanoi`, `Vietnam Academy of Science and Technology`, `Phenikaa University`).
   - **Nhiệt độ °C**: Luôn có khoảng trắng trước `°C` (ví dụ: `60 °C`, `25 °C`), dùng ký tự độ chuẩn `°` (Unicode `\u00B0`), cấm dùng chữ cái `o` (`60oC`).
   - **Dấu trừ & Dấu âm toán học `−`**: Dùng dấu trừ Unicode `−` (`\u2212`) cho thế điện hóa âm (`−0.7 V`, `−1.8 V`), hệ số âm trong phương trình (không để khoảng trắng thừa như `- 0.115`), và dải giá trị.
   - **Số mũ khoa học & Đơn vị SI**: Tạo superscript chuẩn cho lũy thừa ($10^{-9}$, $10^{-4}$), đơn vị diện tích ($	ext{cm}^2$), số sóng ($	ext{cm}^{-1}$), dấu nhân `×` (thay vì chữ cái `x`).
   - **Chỉ số trên/dưới cho Công thức Hóa học & Ion**:
     - *Chỉ số dưới (Subscript)*: Số nguyên tử trong công thức hóa học ở cả thân bài và tiêu đề References (ví dụ: $	ext{Cu}_2	ext{MoS}_4$, $(	ext{NH}_4)_2	ext{MoS}_4$, $	ext{Cu(NO}_3)_2\cdot 3	ext{H}_2	ext{O}$, $	ext{Cu}_2	ext{S}$, $	ext{MoS}_2$, $\delta	ext{-MnO}_2$, $\gamma	ext{-MnO}_2$, $	ext{ZnFe}_2	ext{O}_4$, $	ext{Cu}_2	ext{MX}_4$).
     - *Chỉ số trên (Superscript)*: Điện tích ion ($	ext{Mn}^{2+}$, $	ext{Cu}^{2+}$, $	ext{S}^{2-}$, $	ext{Cu}^+$, $(	ext{S–S})^{2-}$, $	ext{H}^+$, $2	ext{e}^-$, $	ext{MoS}_4^{2-}$).
   - **Quy chuẩn In nghiêng (Italics) & Chữ đứng (Roman)**:
     - *In nghiêng Tên loài sinh học*: Toàn bộ danh pháp hai phần (Binomial nomenclature) của vi sinh vật, thực vật, động vật phải in nghiêng cả trong thân bài và tài liệu tham khảo (ví dụ: *Escherichia coli*, *Staphylococcus aureus*, *Bacillus subtilis*, *Panax vietnamensis*, *Oryza sativa*, *E. coli*, *S. aureus*...; các từ viết tắt phân loại `sp.`, `spp.`, `subsp.`, `var.` để chữ đứng).
     - *In nghiêng Biến số toán học, vật lý, thống kê*:
       - Biến số và tham số: *$x$*, *$y$*, *$z$*, *$t$*, *$m$*, *$n$*, *$k$*, *$p$*, *$v$*, *$c$*, *$a$*, *$b$*, *$T$*, *$R$*, *$F$*, *$V$*, *$I$*, *$E$*, *$C$*, *$A$*, *$L$*, *$D$*...
       - Biến số có chỉ số: *$R*$^2, *$E*<sub style="">pc</sub>, *$i$*<sub style="">pc</sub>, $\Delta$*$i$*<sub style="">pc</sub>, *$E$*$_0$, *$K$*<sub style="">s</sub>, *$I$*<sub style="">pa</sub>, *$E$*<sub style="">pa</sub>, *$C$*<sub style="">dl</sub>, *$R$*<sub style="">ct</sub>...
       - Biến số thống kê: *$p$* < 0.05, *$n$* = 20, *$SD$*, *$SE$*, *$r$* = 0.99...
       - Ký tự Hy Lạp biểu diễn biến/góc/độ quét: *$\nu$*, *$\lambda$*, *$\theta$* (*$2\theta$*), *$\alpha$*, *$\beta$*, *$\gamma$*, *$\delta$*, *$\mu$*, *$\sigma$*...
       - Thuật ngữ Latinh: *in situ*, *operando*, *in vitro*, *in vivo*, *et al.*
       - Tiền tố chú thích hình/bảng: *Figure 1.*, *Figure 2.*, *Table 1.*
     - *Chữ đứng (Roman)*:
       - Hàm số và toán tử chuẩn: $\sin$, $\cos$, $	an$, $\ln$, $\log$, $\exp$, $\max$, $\min$, $\lim$, $\mathrm{d}x$, $\Delta$, $\Sigma$, $\Pi$.
       - Đơn vị đo lường: $	ext{V}$, $	ext{A}$, $	ext{s}$, $	ext{m}$, $	ext{g}$, $	ext{L}$, $	ext{mol}$, $	ext{Hz}$, $	ext{Pa}$, $	ext{J}$, $	ext{K}$, $	ext{C}$, $	ext{pH}$.
       - Tên phương pháp, thiết bị, vật liệu viết tắt: `SWV`, `CV`, `SWCSV`, `AAS`, `ICP-MS`, `FE-SEM`, `XRD`, `XPS`, `Ag/AgCl`, `Pt`.
   - **Dải số trang & Dải giá trị (En-dash `–`)**: Tất cả dải số trang trong References (`1–4`, `515–533`...) và dải giá trị phải dùng gạch en-dash `–` thay vì gạch ngắn hyphen `-`.
   - **Làm sạch Dấu rác & Unlink EndNote**: Tự động gỡ bỏ (unlink) 100% mã trường EndNote (`ADDIN EN.CITE...`, `EN.REFLIST`) chuyển thành **Static Text sạch**, xóa sạch chuỗi mã trường Word rác (`REF _Ref... \h \* MERGEFORMAT`), xóa dấu nối rác `, -` dính sau tác giả trong References.
   - **Công thức hóa học & Dấu chấm ngậm nước**: Ký hiệu độ góc XRD `16.2°`, dấu chấm giữa cho tinh thể ngậm nước `MnCl2·4H2O`, `Cu(NO3)2·3H2O`.
5. **MỌI SỬA ĐỔI NỘI DUNG BẮT BUỘC PHẢI BÁO CÁO USER DUYỆT TRƯỚC**:
   - Khi phát hiện lỗi chính tả, sai sót số liệu, lỗi ngữ pháp, sai thứ tự mục hoặc nhầm lẫn của tác giả $\rightarrow$ **BẮT BUỘC liệt kê và báo cáo cho user quyết định trước, TUYỆT ĐỐI KHÔNG TỰ Ý SỬA**.
   - Chỉ khi user đồng ý phê duyệt sửa đổi thì mới thực hiện sửa và tô màu xanh lá chuẩn `#2F6C1B` cho đúng từ/ký tự được sửa đó (quy tắc tô màu vi mô, không tô cả cụm hay cả câu).
6. Tạo **2 file báo cáo kiểm tra độc lập** (`REPORT-PROOFREADING-[ID].md` và `REPORT-REFERENCES-[ID].md`) trong thư mục bài báo.

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

### 0.3. Quy tắc phê duyệt sửa đổi nội dung & Tô màu Vi mô (Micro-targeted Green `#2F6C1B`)
- Mọi trường hợp phát hiện lỗi (lỗi chính tả tiếng Anh, sai địa danh, lỗi ký tự font, nhầm lẫn số thứ tự mục, sai sót số liệu...):
  1. **KHÔNG ĐƯỢC TỰ Ý SỬA** vào văn bản.
  2. **Liệt kê chi tiết vị trí, nguyên văn gốc và đề xuất sửa** trong phản hồi cho người dùng.
  3. **Chỉ thực hiện sửa sau khi người dùng đã xác nhận đồng ý**.
  4. Khi được phê duyệt sửa, **tô màu xanh lá `#2F6C1B` (`RGBColor(0x2F, 0x6C, 0x1B)`)** duy nhất cho đúng từ/ký tự/dấu được sửa đó (Micro-targeted). Tuyệt đối **KHÔNG** tô màu cả cụm từ, cả câu hoặc các chữ nguyên vẹn xung quanh.

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
| **Tiêu đề bài báo** | `002_Title` | **Căn giữa (Center)** | 18pt Bold, Title/Sentence case. In nghiêng tên loài sinh học nếu có. |
| **Tác giả (Authors)** | `003_Author` | **Căn giữa (Center)** | 12pt Bold. **Chỉ số affiliation và dấu `*` BẮT BUỘC SUPERSCRIPT**. |
| **Địa chỉ (Affiliation)**| `004_Affiliation` | **Căn giữa (Center)** | 11pt Italic. **Chỉ số đầu dòng BẮT BUỘC SUPERSCRIPT**. |
| **Email liên hệ** | `005_Email` | **Căn giữa (Center)** | 10pt; `*Email: ...` hoặc `*Emails: ...`. |
| **Lịch sử bài báo** | `006_History` | **Căn giữa (Center)** | 10pt; `Received: ...; Accepted for publication: ...`. |
| **Tóm tắt (Abstract)** | `007_Abstract` | **Căn đều 2 bên (Justify)** | 11pt, run đầu **`Abstract. `** in đậm. In nghiêng tên loài sinh học. |
| **Keywords** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | Run `Keywords:` in nghiêng, theo sau là danh sách từ khóa (in nghiêng tên loài). |
| **Classification numbers** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | Run `Classification numbers:` in nghiêng, theo sau là các mã số (ví dụ `2.2, 5.3.`). |
| **Tiêu đề mục cấp 1** | `008_Section 1.` | **Căn giữa (Center)** | 11pt Bold, Sentence case (ví dụ `1. Introduction`, `2. Materials and methods`...). |
| **Tiêu đề mục cấp 2** | `009_Subsection 1.1.` | **Căn trái (Left)** | 11pt Bold, Sentence case (ví dụ `2.1. Materials`...). |
| **Tiêu đề mục cấp 3** | `010_Subsubsection 1.1.1.` | **Căn trái (Left)** | 11pt Bold Italic (ví dụ `2.1.1. Chemicals`...). |
| **Đoạn văn nội dung** | `000_Text` | **Căn đều 2 bên (Justify)** | 11pt. Giữ nguyên văn bản gốc của tác giả. |
| **Ảnh minh họa** | `012_Figure` | **Căn giữa (Center)** | Chứa hình ảnh căn giữa trang (~4.5 - 5.5 inches). |
| **Chú thích hình** | `013_FigCap` | **Căn giữa (Center)** | Căn giữa; ví dụ *Figure 1.* Chú thích... (*Figure X.* in nghiêng, kết thúc bằng dấu chấm `.`). |
| **Chú thích bảng** | `013_TableCap` | **Căn giữa (Center)** | Căn giữa; ví dụ *Table 1.* Chú thích... (*Table X.* in nghiêng, kết thúc bằng dấu chấm `.`). |
| **Nội dung bảng** | `014_Table` | **Bảng căn giữa trang** | Kẻ viền 3 dòng khoa học (bỏ viền dọc), header in đậm, số liệu căn giữa/phải. |
| **Lời cảm ơn** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***Acknowledgments.*** theo sau là nội dung tài trợ/cảm ơn. |
| **Đóng góp tác giả** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***CRediT authorship contribution statement.*** theo sau là phân công vai trò. |
| **Xung đột lợi ích** | `007_Keyword-Classification` | **Căn đều 2 bên (Justify)** | ***Declaration of competing interest.*** theo sau là lời tuyên bố. |
| **Tài liệu tham khảo** | `016_Tailieuthamkhao` | **Căn đều 2 bên (Justify)** | Định dạng theo CSL `vietnam-journal-of-science-and-technology.csl` (Volume in đậm, dải trang en-dash `–`, link DOI, in nghiêng tên loài sinh học, kết thúc bằng dấu chấm `.`). |

---

## 2. Quy chuẩn Trình bày References theo `vietnam-journal-of-science-and-technology.csl`

- **Tác giả**: `Họ Tên_viết_tắt` (ví dụ: `Lucchini R. G., Aschner M., Landrigan P. J., Cranmer J. M.`). Nếu $\le 6$ tác giả thì liệt kê đủ; nếu $\ge 7$ tác giả thì liệt kê 6 tác giả đầu + `et al.`.
- **Tên bài báo**: Sentence case, **in nghiêng tên loài sinh học** hoặc công thức hóa học có chỉ số nếu có.
- **Tên tạp chí**: Viết tắt chuẩn ISO 4, có dấu chấm sau mỗi từ viết tắt.
- **Tập / Số / Trang**: **Volume in đậm**, (Năm) trong ngoặc đơn, dải trang nối bằng gạch en-dash `–` (ví dụ: **64** (2018) 1–4).
- **DOI**: Dạng URL đầy đủ `https://doi.org/...`.
- **Dấu kết thúc**: Mỗi trích dẫn phải kết thúc bằng đúng 1 dấu chấm `.`.

---

## 3. Quy trình Thực hiện Chuẩn hóa

Khi nhận yêu cầu `/vjst-word` cho một bài báo (ví dụ `VJST-2-MAT-19150.docx` hoặc file trong folder bài báo):

### Bước 1: Khởi tạo và Backup
1. **Tạo đúng 1 bản backup tăng dần**: `[Tên file]-backup(N).docx` trước khi thực hiện bất kỳ thao tác chỉnh sửa nào.
2. Đọc và phân tích cấu trúc file Word hiện tại.

### Bước 2: Cập nhật DOI Header
- Thay thế mã bài `[ID]` vào `xx` trong First Page Header (giữ nguyên hyperlink màu xanh `0000FF`, không tô xanh lá).

### Bước 3: Áp dụng Format/Style chuẩn VJST & Quét sâu từng phân đoạn
1. Gán đúng Style và Alignment cho từng đoạn văn, tiêu đề, hình ảnh, bảng biểu và tài liệu tham khảo theo bảng Style ở Mục 1.
2. **Thực hiện Quét sâu & Quét chậm 8 phân đoạn (Mục 3 ở đầu tài liệu)**:
   - **Đảm bảo tính thống nhất**: Thống nhất thuật ngữ, tên vật liệu (`Cu-Mo-S`), tên biến (`scan rate`), ưu tiên đơn vị có dấu gạch chéo (`mV/s`, `mol/L`, `µM`, `µA`).
   - Chuẩn hóa `%` có khoảng cách, khoảng trắng `°C`, dấu âm `−`, số mũ SI, dải trang en-dash `–`, dấu nhân `×`.
   - Chuẩn hóa chỉ số trên/dưới cho công thức hóa học ($	ext{Cu}_2	ext{MoS}_4$, $	ext{MoS}_2$) và ion ($	ext{Mn}^{2+}$, $	ext{S}^{2-}$).
   - In nghiêng tên loài sinh học (*E. coli*, *S. aureus*...) và biến số toán học (*R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>, *x*, *y*, *ν*, *2θ*).
   - Chuẩn hóa địa danh `Ha Noi`, `Viet Nam` (giữ nguyên tên cơ quan chính thức).
   - Gỡ bỏ sạch sẽ mã trường EndNote (`ADDIN EN.CITE...`), mã trường rác (`REF _Ref...`), xóa dấu nối rác `, -` trong References.
   - Đảm bảo đầy đủ dấu chấm kết thúc ở caption hình/bảng và references.
3. Đảm bảo toàn bộ hình ảnh và caption căn giữa (`012_Figure`, `013_FigCap`), bảng căn giữa và kẻ viền 3 dòng (`014_Table`).
4. Giữ nguyên 100% nội dung chữ, số liệu, phương trình của tác giả.

### Bước 4: Báo cáo các điểm phát hiện cần sửa đổi (nếu có)
- Nếu phát hiện lỗi chính tả, sai địa danh, nhầm thứ tự mục, thiếu từ, công thức rỗng... $\rightarrow$ **Dừng lại, ghi rõ vào báo cáo/chat để hỏi ý kiến user, KHÔNG tự ý sửa**.
- Chỉ khi user chỉ đạo sửa $\rightarrow$ thực hiện sửa và tô xanh lá `#2F6C1B` đúng từ/ký tự (micro-targeted).

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

Trước khi bàn giao kết quả và tạo file `REPORT-PROOFREADING-[ID].md`, **BẮT BUỘC** chạy kiểm tra tự động qua 11 hạng mục hậu kiểm sau:

| STT | Hạng mục Hậu kiểm | Tiêu chuẩn Đạt (PASS) | Lỗi Không đạt (FAIL) |
|:---:|:---|:---|:---|
| 1 | **Tính thống nhất toàn bài (Consistency)** | Thống nhất 100% cách viết thuật ngữ (`Cu-Mo-S`), biến số (`scan rate`), ưu tiên đơn vị có dấu gạch chéo (`mV/s`, `V/s`, `mol/L`, `µM`, `µA`), tham chiếu (`Figure X`, `Table X`, `Equation (X)`), dải trích dẫn `[1–3]` | Bất nhất: lúc viết `Cu-Mo-S` lúc `Cu−Mo−S`, lúc `scanrate` lúc `scanning speed`, lúc `mV s⁻¹` lúc `mV/s` |
| 2 | **Nhiệt độ `°C`** | 100% có ký tự độ chuẩn `°` và khoảng trắng (ví dụ: `60 °C`, `25 °C`) | Xuất hiện `60oC`, `60°C`, `60 oC`, `60 ° C` |
| 3 | **Dấu trừ / Dấu âm `−`** | Dùng dấu trừ Unicode `−` (`\u2212`) cho thế âm (`−0.7 V`), dải thế, hệ số âm | Xuất hiện `-0.7 V`, `- 0.115` (khoảng trắng thừa) |
| 4 | **Số mũ SI & Đơn vị** | $10^{-9}$, $10^{-6}$, $10^{-4}$, $	ext{cm}^2$, $	ext{cm}^{-1}$, $	ext{s}$, $	ext{mol/L}$, $	ext{V/pH}$, dấu nhân `×` | Dính đơn vị `0.1M`, chữ cái `x20k`, số mũ phẳng `10-9`, `cm-1` |
| 5 | **Chỉ số Công thức Hóa học & Ion** | Tạo subscript cho số nguyên tử ($	ext{Cu}_2	ext{MoS}_4$, $	ext{MoS}_2$, $	ext{H}_2	ext{O}$); superscript cho điện tích ion ($	ext{Mn}^{2+}$, $	ext{S}^{2-}$, $	ext{Cu}^+$) ở cả thân bài và Ref | Xuất hiện công thức phẳng `Cu2MoS4`, `MoS2`, `Mn2+`, `S2-`, `H2O` |
| 6 | **Gạch En-dash `–`** | 100% dải trang References (`1–4`, `515–533`...) dùng en-dash `–` (`\u2013`) | Dùng gạch ngắn hyphen `1-4`, `515-533` trong dải trang |
| 7 | **Làm sạch Mã trường & Dấu rác** | 0 mã trường EndNote (`ADDIN EN.CITE...`), 0 mã rác `REF _Ref...`, 0 dấu rác `,- ` trong Ref | Còn sót mã trường nhúng XML, chuỗi `MERGEFORMAT` hoặc dấu `,- ` |
| 8 | **In nghiêng Tên loài & Biến số Toán học** | In nghiêng tên loài sinh học (*E. coli*, *S. aureus*...); in nghiêng biến số toán/lý/thống kê (*x*, *y*, *t*, *R*$^2$, *E*<sub style="">pc</sub>, *i*<sub style="">pc</sub>, *p* < 0.05, *SD*, *ν*, *2θ*); in nghiêng từ Latinh (*in situ*, *et al.*); in nghiêng tiền tố *Figure X.*, *Table X.*. Giữ chữ đứng cho hàm số ($\sin$, $\ln$), đơn vị ($	ext{V}$, $	ext{A}$, $	ext{pH}$) và tên viết tắt (CV, SWV) | Tên loài sinh học, biến số toán học hoặc từ Latinh để chữ đứng thường |
| 9 | **Lỗi dính chữ, thừa/thiếu space** | Ký hiệu `%` có khoảng cách (`99 %`, `95 % confidence`); không dính mã trích dẫn (`concentrations`); không dính đơn vị (`0.1 M`); không thừa space trước dấu câu (`Ha Noi, Viet Nam`) hoặc sau dấu âm (`−0.115`) | Xuất hiện dính chữ `95%`, `concentrati[1]ons`, dính đơn vị `0.1M`, thừa space `Ha Noi , Viet Nam` hoặc `- 0.115` |
| 10 | **Lỗi thiếu dấu / thừa dấu câu** | Đầy đủ dấu chấm kết thúc ở caption hình/bảng và references; tiền tố dùng `Figure X.` (không dùng `Figure X:`); xóa sạch dấu nối rác `, -` trong References; không lệch ngoặc `()` hay `[]` | Caption thiếu dấu chấm; dùng `Figure X:`; sót dấu rác `,- ` sau tác giả trong Ref; lệch ngoặc |
| 11 | **Công thức & Dấu ngoặc** | Phát hiện và báo cáo các công thức rỗng dấu ngoặc (như `() ln ()`) | Để sót công thức rỗng mà không báo cáo |
