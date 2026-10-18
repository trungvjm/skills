---
name: vjst-update-paper-to-OJS
description: Đọc dữ liệu từ file Word (.docx) bài báo khoa học VJST (chế độ chỉ đọc, đối chiếu bằng AI Vision) hoặc từ văn bản người dùng cung cấp để chuẩn hóa và tự động cập nhật toàn bộ metadata (Tiêu đề, Tác giả, Email, Affiliation, Tóm tắt, Từ khóa, Tài liệu tham khảo, Số trang, Số Volume/Issue) lên hệ thống OJS VJST qua browser subagent.
---

# vjst-update-paper-to-OJS: Trích xuất File Word & Cập nhật Toàn diện Metadata Bài báo trên OJS VJST

Skill này hướng dẫn agent trích xuất thông tin từ file Word (`.docx`) của bài báo khoa học thuộc tạp chí Vietnam Journal of Science and Technology (VJST), hoặc từ văn bản rời do người dùng cung cấp, sau đó đối chiếu bằng AI Vision, chuẩn hóa theo quy chuẩn VJST và cập nhật lên hệ thống quản trị OJS thông qua `browser` subagent.

---

## 1. NGUYÊN TẮC BẤT KHẢ XÂM PHẠM ĐỐI VỚI FILE WORD

1. **Chỉ đọc (Read-only), tuyệt đối không sửa file Word gốc**:
   - Không mở file `.docx` ở chế độ ghi, không lưu đè, không chỉnh sửa nội dung, định dạng hay thuộc tính của file Word gốc dưới bất kỳ hình thức nào.
   - Mọi thao tác trích xuất hoặc chuyển đổi sang PDF/ảnh phục vụ AI Vision phải xuất kết quả tạm sang thư mục nháp (`scratch`), tuyệt đối không tạo file rác trong thư mục chứa bài báo của người dùng.
2. **Bắt buộc đối chiếu bằng AI Vision (khi đầu vào là file Word)**:
   - Luôn xuất tạm một bản PDF/ảnh trực tiếp từ file Word hiện tại ra thư mục nháp `scratch` để đọc bằng công cụ `view_file` (AI Vision).
   - Không chỉ dựa vào text thô; phải dùng AI Vision để kiểm tra từng chi tiết định dạng (chữ in nghiêng `<i>`, in đậm `<b>`, chỉ số dưới `<sub>`, chỉ số trên `<sup>`, ký tự Hy Lạp/toán học, ngắt đoạn trong Abstract, chỉ số địa chỉ tác giả, số trang và danh sách tài liệu tham khảo).
   - Ngay sau khi đối chiếu xong, **xóa sạch toàn bộ file PDF/ảnh tạm** trong thư mục `scratch` và kiểm tra xác nhận đã dọn dẹp hoàn tất.

---

## 2. HAI CHẾ ĐỘ ĐẦU VÀO VÀ QUY TRÌNH TRÍCH XUẤT

Skill hỗ trợ cả 2 chế độ:
- **Chế độ A (Đầu vào là file Word `.docx`)**: Trích xuất và cập nhật trọn bộ: Mã bài (ID), Số Volume/Issue, Số trang (Pages), Chuyên mục (Section), Tiêu đề (Title), Tên tác giả (Authors), Email, Địa chỉ (Affiliation), Tóm tắt (Abstract), Từ khóa (Keywords), và Danh sách tài liệu tham khảo (References).
- **Chế độ B (Đầu vào là văn bản rời)**: Chuẩn hóa và cập nhật các trường được người dùng cung cấp (ví dụ: ID bài báo + Tác giả + Affiliation + Keywords...).

### Quy trình trích xuất chuẩn cho Chế độ A (File Word `.docx`):

1. **Đọc cấu trúc XML/HTML của file Word (chế độ chỉ đọc)**:
   - Dùng `pandoc "<đường_dẫn_docx>" -f docx -t html` hoặc `unzip -p "<đường_dẫn_docx>" word/header*.xml word/document.xml` để lấy toàn bộ văn bản cùng các thẻ định dạng (`<em>`/`<i>`, `<strong>`/`<b>`, `<sup>`, `<sub>`) và thông tin phần Header/Footer.
2. **Xuất PDF tạm ra thư mục `scratch` để đối chiếu AI Vision**:
   - Chạy lệnh chuyển đổi chỉ đọc sang thư mục `scratch`:
     ```bash
     soffice --headless --convert-to pdf --outdir "<scratch_dir>" "<đường_dẫn_docx>"
     ```
   - Dùng `view_file` để xem trực tiếp file PDF tạm trong `<scratch_dir>` (đặc biệt là trang đầu tiên chứa Header, Title, Authors, Affiliations, Email, Abstract, Keywords và các trang cuối chứa References, số trang kết thúc).
3. **Đối chiếu chéo (Text/HTML vs. AI Vision)** và **Xóa file tạm**:
   - Rà soát từng trường thông tin giữa kết quả trích xuất HTML/XML và hình ảnh hiển thị trên PDF tạm để đảm bảo khớp 100% định dạng và nội dung.
   - Xóa ngay file PDF tạm trong `<scratch_dir>` bằng lệnh `rm -f` ngay sau khi đối chiếu xong.

---

## 3. QUY TẮC CHUẨN HÓA DỮ LIỆU THEO CHUẨN VJST OJS

### A. Mã bài báo (Submission ID), Số Volume/Issue, Số trang (Pages) và Chuyên mục (Section)
- **ID bài báo**: Lấy từ đuôi dòng DOI trên trang 1 (`https://doi.org/10.15625/2525-2518/{ID}`), từ tên file (ví dụ: `VJST-1-NAT-18497.docx` -> `18497`), hoặc từ yêu cầu của người dùng.
- **Volume, Issue (Number) & Year**: Lấy từ dòng Header trang 1: `Vietnam Journal of Science and Technology {Vol}({No}) ({Year}) {StartPage}–{EndPage}` (ví dụ: `64(5) (2026)` -> Volume `64`, Number `5`, Year `2026`).
- **Số trang (Pages)**:
  - Lấy từ Header trang 1. **LƯU Ý BẮT BUỘC**: Dấu gạch giữa các số trang phải là dấu gạch dài en-dash (`–`, Unicode U+2013) đúng như trong file Word (ví dụ: `848–854`), tuyệt đối không dùng dấu gạch nối ngắn (`-`).
  - Đối chiếu bằng AI Vision với số trang đánh ở chân trang đầu và trang cuối cùng của bài báo. Nếu số trang trên Header trang 1 bị lệch so với số trang thực tế ở trang cuối (hoặc còn để `xxx–xxx`), phải cảnh báo rõ cho người dùng.
- **Chuyên mục (Section)**: Nhận diện từ dòng tiêu đề chuyên mục trên trang 1 (ví dụ: `REVIEW PAPER`) hoặc từ tiền tố tên file (`0-REV` -> `REVIEW`, `1-NAT` -> `NATURAL PRODUCTS`, `2-MAT` -> `MATERIALS`, `3-ENV` -> `ENVIRONMENT`, `4-ELE` -> `ELECTRONICS - TELECOMMUNICATION`, `5-MEC` -> `MECHANICAL ENGINEERING - MECHATRONICS`).

### B. Tiêu đề bài báo (Title): Chuẩn hóa theo `/vjst-ojs-metadata`
1. **Kiểu chữ (Sentence case)**:
   - Chữ cái đầu tiên của tiêu đề và chữ cái đầu tiên ngay sau dấu hai chấm (`:`) viết hoa; các từ thông thường còn lại viết thường.
   - **Giữ nguyên ALL CAPS (từ viết tắt)**: Các từ viết hoa toàn bộ như `DNA`, `RNA`, `PCR`, `NMR`, `HR-ESI-MS`, `HPLC-DAD`, `DPPH`, `ABTS`, `ICAM-1`, `VAST`, `HCMUT`... giữ nguyên chữ hoa, không bọc thẻ `<i>`. Nếu từ ALL CAPS đồng thời là công thức hóa học có chỉ số (`CO2`, `H2O`, `CH2Cl2`) thì bọc `<sub>` cho phần chỉ số.
   - **Giữ nguyên Danh từ riêng (Proper Nouns)**: Tên địa danh (`Viet Nam`, `Vietnam`, `Ha Noi`, `Ho Chi Minh City`, `Mekong Delta`...), tên người, tên tổ chức, tên phần mềm/thương mại giữ nguyên chữ cái viết hoa đầu từ.
2. **Định dạng thẻ HTML (đối chiếu kỹ bằng AI Vision với bản Word)**:
   - **Chỉ số dưới (`<sub>...</sub>`)**: Công thức hóa học (`TiO<sub>2</sub>`, `Fe<sub>3</sub>O<sub>4</sub>`, `H<sub>2</sub>O`), chỉ số ký hiệu (`IC<sub>50</sub>`).
   - **Chỉ số trên (`<sup>...</sup>`)**: Số mũ, đơn vị mũ (`10<sup>6</sup>`, `m<sup>2</sup>`), điện tích ion (`Fe<sup>3+</sup>`, `Ca<sup>2+</sup>`), ký hiệu đồng phân/cấu hình mũ (`Δ<sup>7,9(11)</sup>`, `<sup>1</sup>H`, `<sup>13</sup>C`).
   - **Chữ in nghiêng (`<i>...</i>`)**:
     - Tên chi, loài, phân loài sinh vật theo danh pháp Latin (`<i>Saururus</i>`, `<i>Vernonia gratiosa</i>`, `<i>Escherichia coli</i>`). Lưu ý: tên tác giả định danh thực vật đứng sau tên loài như `L.`, `Hance`, `(Lour.) Baill.`, `sp.`, `spp.`, `var.` giữ chữ đứng (không in nghiêng) đúng như trong Word.
     - Tên gene/protein in nghiêng và các từ Latin/ký hiệu hóa học in nghiêng theo quy ước (`<i>in vitro</i>`, `<i>in vivo</i>`, `<i>in situ</i>`, `<i>n</i>-hexane`, `<i>E</i>`, `<i>Z</i>`, `<i>R</i>`, `<i>S</i>`, `<i>O</i>`, `<i>N</i>`...).
3. **Đầu ra Title & Xóa sạch Prefix/Subtitle**:
   - Trả về trên một dòng duy nhất, không có 2 dấu cách liên tiếp.
   - **Xóa sạch Prefix và Subtitle**: Trên giao diện OJS, nếu trường **Prefix** hoặc **Subtitle** có dữ liệu thì **xóa sạch toàn bộ** (để trống hoàn toàn), toàn bộ tiêu đề bài báo chỉ đặt trong ô **Title**.

### C. Tên tác giả (Authors) và Email
1. **Tách Given Name và Family Name**:
   - Từ cuối cùng trong tên mỗi tác giả LUÔN LUÔN là **Family Name** (Họ trên OJS).
   - Toàn bộ các từ đứng trước từ cuối cùng là **Given Name** (Tên trên OJS).
   - *Ví dụ*: `Nguyen Thi Tu Oanh` -> Given Name: `Nguyen Thi Tu`, Family Name: `Oanh`.
2. **Tác giả liên hệ (Corresponding Author / Principal Contact)**:
   - Nhận diện tác giả có dấu sao `*` trên chỉ số mũ trong bài báo để thiết lập làm **Principal Contact** trên OJS.
3. **Email**:
   - Trích xuất địa chỉ email từ dòng `*Email:` trong bài báo và gắn cho tác giả liên hệ (nếu bài báo liệt kê nhiều email cho nhiều tác giả thì ánh xạ tương ứng).
   - **Ưu tiên lấy email chính xác từ bài báo**: Nếu bài báo có cung cấp email cho tác giả (đặc biệt là tác giả liên hệ `*Email:`), luôn cập nhật ô Email trên OJS theo đúng địa chỉ email chính xác từ bài báo. Đối với các tác giả khác không cung cấp email trong bài báo: nếu trên OJS đã có sẵn email thì giữ nguyên không xóa; nếu là tác giả mới chưa có email trên OJS, khai tạm email của tác giả liên hệ (để hệ thống cho phép lưu, người dùng sẽ cập nhật lại sau).

### D. Địa chỉ tác giả (Affiliation)
1. **Nhận diện và gộp dòng**: Nhận diện từng đơn vị theo chỉ số đầu dòng (`1`, `2`, `3`...), gộp các dòng bị ngắt thành một dòng liên tục cho mỗi đơn vị.
2. **Định dạng chỉ số LaTeX superscript**:
   - Chuyển chỉ số đầu mỗi địa chỉ thành `\(^1\) `, `\(^2\) `, `\(^3\) `... (có 1 khoảng trắng sau chỉ số).
   - Nếu bài báo chỉ có 1 đơn vị duy nhất và không đánh số mũ `1`, giữ nguyên chuỗi địa chỉ không có `\(^1\)`.
3. **Ngắt dòng bằng `<br>`**:
   - Nếu một tác giả có từ 2 địa chỉ trở lên (hoặc khi ghép các địa chỉ thuộc về tác giả đó), phân tách các địa chỉ bằng thẻ `<br>`. Tuyệt đối không dùng ký tự xuống dòng `\n`.
   - *Ví dụ*: `\(^1\) Graduate University of Science and Technology, Vietnam Academy of Science and Technology (VAST), 18 Hoang Quoc Viet, Nghia Do Ward, Ha Noi, Viet Nam<br>\(^2\) Institute of Chemistry, VAST, 18 Hoang Quoc Viet, Nghia Do Ward, Ha Noi, Viet Nam`
4. **Chuẩn hóa địa danh và kiểm tra lỗi chính tả**:
   - **Bắt buộc chuẩn hóa địa danh**: Viết `Viet Nam` (tách 2 từ, không viết liền `Vietnam`), `Ha Noi` (tách 2 từ, không viết liền `Hanoi`) trong địa chỉ.
   - Giữ nguyên các nội dung còn lại theo file Word (không yêu cầu sáp nhập địa giới 2 cấp).
   - Nếu phát hiện có lỗi sai chính tả khác trong địa chỉ, báo rõ ở bước chờ phê duyệt để người dùng xem xét quyết định.

### E. Tóm tắt (Abstract)
1. **Loại bỏ nhãn đầu đoạn**: Bỏ chữ `"Abstract."` (hoặc `"Abstract:"`, `"Abstract"`) ở đầu phần tóm tắt.
2. **Giữ nguyên 100% nội dung và định dạng như trong Word (đối chiếu bằng AI Vision)**:
   - Giữ đầy đủ và chính xác các thẻ HTML tương ứng với định dạng trong Word:
     - `<i>...</i>`: chữ in nghiêng (tên loài `<i>Vernonia gratiosa</i>`, `<i>V. gratiosa</i>`, cụm từ Latin `<i>in vitro</i>`, ký hiệu toán/hóa học in nghiêng như `<i>R<sub>f</sub></i>`, `<i>J</i>`, `<i>m/z</i>`, `<i>c</i>`...).
     - `<b>...</b>`: chữ in đậm (ví dụ số thứ tự hợp chất `<b>1</b>`, `<b>2</b>`).
     - `<sub>...</sub>`: chỉ số dưới (`IC<sub>50</sub>`, `H<sub>2</sub>O`, `CH<sub>2</sub>Cl<sub>2</sub>`, `[α]<sub>D</sub>`...).
     - `<sup>...</sup>`: chỉ số trên (`Δ<sup>7,9(11)</sup>`, `<sup>1</sup>H`, `<sup>13</sup>C`, `[M+Cl]<sup>-</sup>`...).
   - Giữ nguyên mọi ký tự đặc biệt, chữ cái Hy Lạp (`α`, `β`, `γ`, `δ`, `Δ`), dấu cộng trừ (`±`), đơn vị (`µM`, `mL`), dấu gạch nối/en-dash (`–`).
   - **Cấu trúc đoạn văn**:
     - Nếu Abstract chỉ có 1 đoạn: bọc trong `<p>...</p>`.
     - Nếu Abstract chia thành nhiều đoạn (ví dụ bài Review có *Ethnopharmacological relevance:*, *Aim of the study:*, *Materials and methods:*, *Results:*, *Conclusions:*): bọc từng đoạn trong thẻ `<p>...</p>` riêng biệt đúng như bố cục trong file Word.

### F. Từ khóa (Keywords)
- Trích xuất từ dòng `Keywords:` trong bài báo.
- Tách từng từ khóa theo dấu phân cách thực tế trong bài (dấu phẩy `,` hoặc dấu chấm phẩy `;`).
- Xóa dấu chấm câu thừa (`.`) ở cuối từ khóa cuối cùng.
- Giữ nguyên thứ tự các từ khóa đúng như trong file Word.

### G. Danh sách tài liệu tham khảo (References)
- Trích xuất toàn bộ danh sách dưới mục `REFERENCES` của file Word.
- Gộp các dòng bị ngắt trong cùng một tài liệu tham khảo thành một dòng liên tục.
- **Giữ nguyên số thứ tự `1.`, `2.`, `3.`... ở đầu mỗi tài liệu tham khảo** đúng như trong Word.
- Mỗi tài liệu tham khảo nằm trên 1 dòng riêng biệt.
- Dùng AI Vision kiểm tra trang đầu và trang cuối của phần `REFERENCES` để đảm bảo đủ số lượng tài liệu tham khảo và không bị lẫn dòng running header/số trang vào nội dung tài liệu tham khảo.

---

## 4. TRÌNH BÀY KẾT QUẢ & CHỜ PHÊ DUYỆT (BẮT BUỘC)

Trước khi thao tác trên OJS, main agent phải trình bày bản tổng hợp dữ liệu đã trích xuất, chuẩn hóa và đối chiếu AI Vision cho người dùng kiểm tra, bao gồm:
1. **Thông tin bài báo & Số đăng**: ID bài báo, Chuyên mục (Section), Volume/Issue/Year, Số trang (Pages).
2. **Tiêu đề (Title)** đã chuẩn hóa HTML (đặt trong code block để dễ kiểm tra thẻ `<i>`, `<sub>`, `<sup>`).
3. **Danh sách Tác giả, Email & Affiliation**:
   - Bảng hoặc danh sách rõ từng tác giả: STT, Given Name, Family Name, Email, Vai trò (Author / Principal Contact `*`), và chuỗi Affiliation (`\(^1\)...<br>\(^2\)...`).
   - Ghi chú báo người dùng xem xét nếu phát hiện lỗi sai chính tả hoặc thiếu thông tin trong địa chỉ.
4. **Tóm tắt (Abstract)** dạng HTML đã đối chiếu AI Vision (đặt trong code block).
5. **Danh sách Từ khóa (Keywords)** theo đúng thứ tự.
6. **Danh sách Tài liệu tham khảo (References)**: Nêu tổng số lượng tài liệu tham khảo trích xuất được (ví dụ: `11 tài liệu tham khảo` hoặc `103 tài liệu tham khảo`) và hiển thị đầy đủ (hoặc hiển thị các mục đầu/cuối nếu danh sách quá dài) để người dùng xác nhận.

**CHỜ PHÊ DUYỆT**: Phải đợi người dùng xác nhận ("Đồng ý", "OK", hoặc chỉ định sửa đổi) thì mới được chuyển sang bước gọi `browser` subagent.

---

## 5. THỰC THI TRÊN HỆ THỐNG OJS (ỦY QUYỀN CHO BROWSER SUBAGENT)

Sau khi người dùng xác nhận, sử dụng công cụ `invoke_subagent` để gọi `browser` subagent (với `Model: "inherit"`). Gửi `Prompt` chi tiết với đầy đủ dữ liệu đã được duyệt để thực hiện tuần tự các bước sau trên trang `https://vjs.ac.vn/jst/workflow/index/{ID}/4` (hoặc `/5`):

> **Lưu ý trạng thái bài báo trên OJS**: Nếu phiên bản hiện tại trên OJS đang ở trạng thái **Published** (đã xuất bản khóa chỉnh sửa), subagent phải báo cáo lại hoặc kiểm tra nút **Unpublish** theo chỉ dẫn của người dùng, tuyệt đối không tự ý bấm "Create New Version" nếu chưa được phép.

### BƯỚC 1: Cập nhật Tiêu đề và Tóm tắt (Title & Abstract)
1. **URL**: Truy cập `https://vjs.ac.vn/jst/workflow/index/{ID}/4#publication/titleAbstract`.
2. **Cập nhật Title & Xóa sạch Prefix/Subtitle**:
   - **Xóa sạch Prefix và Subtitle**: Nếu trường **Prefix** hoặc **Subtitle** có dữ liệu, hãy **xóa sạch toàn bộ** (để trống).
   - Điền chuỗi Title đã chuẩn hóa (chứa các thẻ `<i>`, `<sub>`, `<sup>` nếu có) vào ô **Title**.
3. **Cập nhật Abstract (giữ nguyên định dạng HTML)**:
   - Ô **Abstract** trên OJS sử dụng trình soạn thảo TinyMCE.
   - Để giữ nguyên 100% các thẻ `<p>`, `<i>`, `<b>`, `<sub>`, `<sup>` và ký tự đặc biệt mà không bị mất định dạng khi dán văn bản thuần, sử dụng JavaScript API của TinyMCE trên trang (ví dụ: tìm editor của trường abstract qua `tinymce.editors` hoặc `tinymce.get(...)` và gọi `.setContent(abstractHtml); editor.save();`, đồng thời kích hoạt sự kiện `input`/`change` trên textarea/vue component tương ứng) hoặc dán qua chế độ mã nguồn/rich-text, sau đó kiểm tra trực quan trên khung soạn thảo xem các chữ in nghiêng, in đậm, chỉ số trên/dưới và chia đoạn đã hiển thị đúng chưa.
4. Nhấn **Save** ở cuối tab `Title & Abstract` và đợi thông báo lưu thành công.

### BƯỚC 2: Cập nhật Thông tin Tác giả, Email và Affiliation (Contributors)
1. **URL**: Truy cập `https://vjs.ac.vn/jst/workflow/index/{ID}/4#publication/contributors`.
2. **Thao tác cho từng tác giả**:
   - Mở cửa sổ chỉnh sửa (click mũi tên mở rộng cạnh tên tác giả -> **Edit**) hoặc thêm mới (**Add Contributor**) nếu thiếu tác giả.
   - **Given Name** & **Family Name**: Điền chính xác theo dữ liệu đã tách.
   - **Preferred Public Name**: Nếu ô này có dữ liệu, **xóa sạch toàn bộ** (để trống).
   - **Email**:
     - **Ưu tiên lấy email chính xác từ bài báo**: Nếu bài báo có cung cấp email cho tác giả (đặc biệt là tác giả liên hệ `*Email:`), luôn điền/cập nhật ô Email theo đúng email từ bài báo.
     - Đối với tác giả không có email trong bài báo: Nếu trên hệ thống OJS đã có sẵn email thì **giữ nguyên không xóa**; nếu là tác giả mới chưa có email, khai tạm email của tác giả liên hệ để hệ thống cho phép lưu (người dùng sẽ cập nhật lại sau).
   - **Country**: Chọn quốc gia tương ứng (mặc định là `Viet Nam`).
   - **Affiliation**:
     - Dán chuỗi Affiliation chuẩn hóa (`\(^1\) ...<br>\(^2\) ...`) vào **ô text đơn dòng nằm ở trên cùng** có nhãn **"Affiliation"**.
     - **TRÁNH NHẦM LẪN**: Giao diện OJS có một khung soạn thảo lớn ở bên dưới có nhãn **"Bio Statement"**. **TUYỆT ĐỐI KHÔNG** điền affiliation vào ô Bio Statement. Nếu ô Bio Statement đang có dữ liệu affiliation bị điền nhầm trước đó, hãy **xóa sạch toàn bộ**.
   - **Principal Contact**: Tick chọn `Principal contact for editorial correspondence` cho đúng tác giả liên hệ (`*`).
   - Nhấn **Save**.
3. **Sắp xếp thứ tự tác giả (Order)**:
   - Dùng tính năng **Order** trên danh sách Contributors để kiểm tra và sắp xếp lại thứ tự các tác giả sao cho **trùng khớp 100%** với thứ tự trong bài báo Word. Nhấn **Done** để lưu thứ tự.

### BƯỚC 3: Cập nhật Từ khóa (Keywords) và Tài liệu tham khảo (References)
1. **URL**: Truy cập `https://vjs.ac.vn/jst/workflow/index/{ID}/4#publication/metadata` (và kiểm tra tab `#publication/citations` nếu mục References được tách riêng trên thanh menu Publication).
2. **Cập nhật Keywords**:
   - Xóa sạch toàn bộ các keyword cũ sẵn có trong ô **Keywords**.
   - Nhập **LẦN LƯỢT TỪNG KEYWORD MỘT** theo đúng thứ tự trong bài báo.
   - Sau khi nhập mỗi keyword, **BẮT BUỘC NHẤN ENTER** để OJS tạo thành một tag/chip riêng biệt. **TUYỆT ĐỐI KHÔNG** dán nguyên cả chuỗi chứa dấu phẩy hay dấu chấm phẩy.
   - Kiểm tra lại danh sách tag hiển thị đúng thứ tự từ đầu đến cuối.
3. **Cập nhật References (Danh sách tài liệu tham khảo)**:
   - Tìm ô **References** (trong tab `Metadata` hoặc tab `Citations`/`References`).
   - Xóa nội dung cũ (nếu có) và điền toàn bộ danh sách tài liệu tham khảo đã chuẩn hóa (giữ nguyên số thứ tự `1.`, `2.`, `3.`... ở đầu mỗi dòng, mỗi tài liệu tham khảo nằm trên 1 dòng).
4. Nhấn nút **Save** và xác nhận thông báo lưu thành công.

### BƯỚC 4: Cập nhật Số Volume/Issue, Chuyên mục (Section) và Số trang (Pages)
1. **URL**: Truy cập `https://vjs.ac.vn/jst/workflow/index/{ID}/4#publication/issue`.
2. **Kiểm tra / Gán Số Volume (Issue)**:
   - Kiểm tra xem bài báo đã được gán vào đúng số báo (`Vol. {Vol} No. {No} ({Year})`) chưa. Nếu chưa gán hoặc gán sai, bấm **Assign to Issue** / **Change Issue** và chọn đúng Volume/Issue tương ứng.
3. **Kiểm tra Chuyên mục (Section)**:
   - Kiểm tra mục **Section** đã chọn đúng chuyên mục của bài báo (`REVIEW`, `NATURAL PRODUCTS`, `MATERIALS`, `ENVIRONMENT`, `ELECTRONICS - TELECOMMUNICATION`, `MECHANICAL ENGINEERING - MECHATRONICS`...) chưa; nếu chưa đúng thì chọn lại.
4. **Cập nhật Số trang (Pages)**:
   - Điền số trang vào ô **Pages**. **BẮT BUỘC** phải dùng dấu gạch dài en-dash (`–`, Unicode U+2013) đúng như trong file Word (ví dụ: `848–854`), tuyệt đối không dùng dấu gạch nối ngắn (`-`).
5. Nhấn nút **Save** và xác nhận thông báo lưu thành công.
6. **Lên lịch hoặc Xuất bản (Schedule For Publication / Publish)**:
   - Sau khi chọn xong Issue, Section, Pages và lưu thành công:
     - **Nếu bài báo thông thường (chưa có ngày xuất bản)**: Nhấn nút **"Schedule For Publication"** ở góc trên bên phải trang Publication để đưa bài báo vào lịch xuất bản của số đã chọn.
     - **Nếu bài báo đã được xuất bản online trước đó (đã có sẵn ngày xuất bản / Date Published)**: Khi chọn số xong, chọn nút **"Publish"** (thay vì Schedule For Publication) để chính thức xuất bản bài báo vào số đã chọn.

---

## 6. BÁO CÁO VÀ DỌN DẸP

1. Sau khi `browser` subagent hoàn tất và báo cáo kết quả, đóng/kill subagent đó.
2. Nếu hệ thống trình duyệt tự động sinh file video (`recording.webm`), xóa bỏ file đó.
3. Đảm bảo mọi file PDF/ảnh tạm trong thư mục `scratch` đã được xóa sạch và file Word gốc của người dùng không bị thay đổi.
4. Báo cáo kết quả từng mục đã cập nhật trên OJS (Title, Abstract, Contributors, Keywords, References, Issue & Pages) kèm các điểm cần lưu ý (ví dụ: trường hợp phát hiện xung đột email trên OJS).
