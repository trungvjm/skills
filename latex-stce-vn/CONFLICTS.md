# Đối chiếu mâu thuẫn và phạm vi — latex-stce-vn

Đối chiếu với `SKILL.before-rule-ids.md` (564 dòng), bổ sung đối chiếu GitHub c00d465 khi xuất bản. Không phải mọi điểm bên dưới đều là mâu thuẫn trực tiếp: có ví dụ sai, thiếu phạm vi và vấn đề tương thích môi trường. Không tự coi câu xuất hiện sau là câu ưu tiên.

**Quyết định hiện hành:** người dùng đã chốt C01, C02, C03, C04, C07, C10, C11 và C16. Các cột mô tả đối nghịch dưới đây chỉ lưu bằng chứng từ bản cũ; cột trạng thái là quyết định áp dụng, không được khôi phục nhánh đã bỏ. C14 đã sửa mô tả kỹ thuật: macro theo chức năng/định nghĩa template, không chia theo Việt/Anh.

## Mâu thuẫn trực tiếp hoặc mâu thuẫn có điều kiện

| Mã | Hai yêu cầu đối nghịch | Quy tắc liên quan | Trạng thái / cách xử lý |
|---|---|---|---|
| C01 | §2.2 yêu cầu tiêu đề tiếng Việt Sentence case; §9 bước 2 và bảng §10 yêu cầu HOA toàn bộ. | STCE-VN-FRONT-003; STCE-VN-FRONT-004 (ngừng áp dụng) | **ĐÃ CHỐT:** tiêu đề tiếng Việt dùng Sentence case; giữ hoa đúng tên riêng/từ viết tắt. Bỏ nhánh HOA toàn bộ; không đổi quy tắc tiêu đề tiếng Anh sau TD. |
| C02 | Comment ví dụ §2.4 mô tả headershort lấy tác giả đầu tiên; gạch đầu dòng cho >=3 tác giả lại yêu cầu tác giả liên hệ. | STCE-VN-FRONT-012; STCE-VN-FRONT-013 (ngừng áp dụng) | **ĐÃ CHỐT:** từ ba tác giả trở lên, headershort lấy tác giả đầu tiên + `và cs.`. Shortauth/mailauth vẫn là tác giả liên hệ. |
| C03 | Quy tắc tối thượng/§0 cấm thay từ, viết tắt và caption tuyệt đối; §9.1 yêu cầu viết cộng sự thành cs.; §5.5/§6.3 yêu cầu bỏ dấu chấm cuối caption. | STCE-VN-CORE-005; STCE-VN-CORE-007; STCE-VN-TXT-001; STCE-VN-FIG-012; STCE-VN-FIG-013; STCE-VN-TAB-013 | **ĐÃ CHỐT:** bắt buộc viết tắt cộng sự thành cs. và bỏ dấu chấm cuối caption hình/bảng, kể cả subcaption; viết hoa đầu subcaption theo xác nhận trước. Các ngoại lệ biên tập không cho phép viết lại nội dung khoa học. |
| C04 | Tối thượng/§0 cấm gộp hoặc tách paragraph; §2.7 và §2.8 bắt abstract Việt/Anh thành một paragraph. | STCE-VN-CORE-006; STCE-VN-FRONT-019; STCE-VN-FRONT-023 | **ĐÃ CHỐT:** nếu abstract Việt hoặc Anh có nhiều đoạn, giữ nguyên các đoạn, báo người dùng số đoạn/vị trí và chờ quyết định; không tự gộp, cắt hoặc viết lại. |
| C07 | Đầu §4.3 ưu tiên mathrm thủ công; gạch đầu dòng sau/checklist lại yêu cầu siunitx, kể cả nhiều mẫu số. | STCE-VN-UNIT-001; STCE-VN-UNIT-002 (ngừng áp dụng); STCE-VN-UNIT-007 | **ĐÃ CHỐT:** checklist theo đơn vị thủ công trong math mode, dùng mathrm và slash đúng nguồn. Siunitx chỉ dùng khi cần ký hiệu/prefix đặc biệt; không bắt buộc cho mọi đơn vị hoặc nhiều mẫu số. |

## Ví dụ hoặc bảng tổng hợp chưa nhất quán

| Mã | Bằng chứng | Quy tắc liên quan | Trạng thái / cách xử lý |
|---|---|---|---|
| C05 | Ví dụ cấu trúc §1 dùng `documentclass{STCE/stce}` và `usepackage{STCE/stce_proof}`; dòng `usepackage{STCE/stce}` chỉ là comment. §9 bước 1 lại lấy `usepackage{STCE/stce}` làm package cần kiểm tra. | STCE-VN-TPL-002; STCE-VN-TPL-003 | Checklist phải trỏ về cấu hình hoạt động của mẫu, không tự bật dòng comment. Đã đặt mã template tương ứng; chưa thay package ở bất kỳ bài nào. |
| C06 | Ví dụ được phép §0 đổi `300C` thành `30~$^\circ$C`, trong khi quy tắc tối thượng cấm đổi giá trị số. Không có bằng chứng `0` thứ hai là ký tự độ bị nhận sai. | STCE-VN-CORE-002; STCE-VN-CORE-009 | **Ví dụ nguy hiểm, không được tự áp dụng.** Chỉ đổi khi nguồn gốc hoặc người dùng xác nhận đó là 30°C. Việc đánh mã không cho phép đoán nhiệt độ. |
| C10 | §4.3 có hướng dẫn `\,!`/ví dụ `$0,\!12g$`, trong khi ngay sau đó bắt buộc dùng `{,}`; ví dụ khác còn chứa `\\gamma` trong code thay vì `\gamma`. | STCE-VN-TXT-005; STCE-VN-TXT-006 | **ĐÃ CHỐT:** dấu phẩy thập phân trong math mode dùng `{,}`. Đã bỏ ví dụ khoảng trắng âm, sửa ví dụ gamma. Không đổi dấu phân cách danh sách/vector hoặc dấu phẩy giữa key cite. |
| C11 | §0 cho phép chuyển `[1, 2]` thành cite không có khoảng trắng; ví dụ §7.1 cũng không có khoảng trắng; gạch đầu dòng §7.1 lại yêu cầu giữ spacing gốc trong cite. | STCE-VN-REF-005 | **ĐÃ CHỐT:** dùng một dấu cách sau mỗi dấu phẩy, ví dụ `\cite{1, 2, 3}`; không có khoảng trắng trước dấu phẩy. Chuẩn hóa spacing dù nguồn dùng kiểu khác, giữ nguyên key và thứ tự key. |
| C14 | §6.2 dùng lll cho header; bảng §10 lại chia ML/p/rrr cho bài Việt và midrule/lll cho bài Anh, dù chúng có chức năng khác nhau. | STCE-VN-TAB-002; STCE-VN-TAB-003 | **ĐÃ ĐỒNG BỘ KỸ THUẬT:** đọc định nghĩa macro của template; lll gộp cột/header, rrr gộp hàng, p là phantom, booktabs kẻ đường. Không chia theo ngôn ngữ; không tự dùng ML nếu mẫu không định nghĩa. Đã đối chiếu mẫu tháng 10. |
| C16 | Ví dụ §4.1 có lệnh sai qaud; ví dụ §6.1 khai báo 17 cột c nhưng header/dữ liệu chỉ minh họa 3 cột. | STCE-VN-EQ-003; STCE-VN-TAB-001; STCE-VN-TAB-014 | **ĐÃ CHỐT:** số cột theo bảng thực tế của bài. Ví dụ được sửa thành ba cột Xcc, qaud thành quad. Đã smoke-compile nguyên văn ví dụ bảng từ skill cùng ví dụ số/phương trình bằng pdflatex hai lần: tạo PDF một trang, không lỗi căn cột, ký tự thiếu hoặc tràn lề. |

## Thiếu phạm vi hoặc điều kiện áp dụng

| Mã | Điểm chưa rõ | Quy tắc liên quan | Trạng thái / cách xử lý |
|---|---|---|---|
| C08 | §4.3 cấm trộn slash của per với slash gõ tay; nhưng cùng mục cho ví dụ si cho cm³ rồi `/vòng`, và các ví dụ nhiều mẫu số thủ công. | STCE-VN-UNIT-006; STCE-VN-UNIT-008 | Cần giới hạn lệnh cấm vào biểu diễn gây mơ hồ trong một đơn vị ghép, không cấm từ tiếng Việt đặt ngoài siunitx. Phải giữ dấu slash/ngôn ngữ gốc và kiểm tra PDF. |
| C09 | §4.4 viết “thay thế tất cả ký tự Unicode”, trong khi chính skill yêu cầu giữ văn bản tiếng Việt và đưa ra ví dụ có tiếng Việt. | STCE-VN-TXT-010; STCE-VN-CORE-005 | Phạm vi phải là Unicode toán/ký hiệu được liệt kê, **không phải chữ tiếng Việt**. Registry ghi rõ phạm vi này; không phiên âm/xóa dấu tiếng Việt. |
| C12 | Lưu ý §9 cấm grep/findstr/Select-String tuyệt đối và yêu cầu tool tên `view_file`; môi trường hiện tại dùng read/grep, không có tool view_file. Định vị chuỗi khác với đọc đối chiếu đầy đủ. | STCE-VN-WORK-005 | **Vấn đề tương thích môi trường, không phải mâu thuẫn nội dung học thuật.** Dùng tool hiện có để định vị; vẫn phải đọc trực tiếp nội dung và đối chiếu, không lấy grep làm chứng cứ đã đọc toàn bài. |
| C13 | Mở đầu chỉ một file mẫu cố định; chưa nói cách xử lý khi người dùng chỉ định mẫu số khác (ví dụ tháng 10). | STCE-VN-TPL-001 | **Thiếu thứ tự ưu tiên mẫu.** Ghi lại mẫu người dùng chọn cho tác vụ; không tự lấy metadata tập/kỳ/DOI của mẫu sang bài mới. |
| C15 | Lưu ý §9 yêu cầu commit sau mỗi nhóm thay đổi nhưng không có điều kiện thư mục là Git repo hay người dùng đã cho phép commit. | STCE-VN-WORK-002 | **Thiếu điều kiện môi trường/quyền thao tác.** Không tự tạo repo hoặc commit chỉ để thỏa skill khi tác vụ không dùng Git. |
| C17 | GitHub c00d465 có bảng dài xltabular và chi tiết cột S chưa có trong baseline bản cài; câu LUÔN tabularx/float một trang sẽ mâu thuẫn với bảng dài nếu áp ngoài phạm vi. | STCE-VN-TAB-001; STCE-VN-TAB-006–009; STCE-VN-TAB-015–023 | **Giữ upstream và giới hạn phạm vi:** một trang dùng tabularx/float; nhiều trang dùng xltabular trực tiếp, caption chỉ trang đầu, header lặp và footer theo trang. Cấp mã nối tiếp cho phần được giữ, không đổi các quyết định biên tập đã chốt. |

## Quy tắc bị thiếu hoặc bị đặt quá xa phần hướng dẫn chính

- **STCE-VN-TXT-001 — cs.:** đã có trong checklist cũ §9.1 nhưng chưa được nêu rõ là ngoại lệ của điều khoản bảo toàn text ở đầu skill.
- **STCE-VN-FIG-012 — viết hoa đầu subcaption:** không có câu yêu cầu tường minh trong bản chụp 564 dòng; bổ sung theo xác nhận trực tiếp của người dùng. Không được ghi rằng đây là kiểm tra đã có sẵn trong bản cũ.
- **STCE-VN-EQ-005 — không dòng trống trước equation:** đã có trong checklist cũ §9.1 nhưng không có trong phần hướng dẫn chính §4.1; các ví dụ/triển khai vẫn có thể bỏ sót nếu chỉ đọc §4.1.

## Phạm vi lần cập nhật này

1. Giữ nguyên bản skill trước đánh mã trong `SKILL.before-rule-ids.md`.
2. Tạo `RULES.md`: mỗi quy tắc có một mã, mức yêu cầu, nguồn và cách kiểm chứng; quy tắc lặp lại dùng cùng mã.
3. Cập nhật đồng bộ SKILL.md, RULES.md và hồ sơ này theo quyết định C01/C02/C03/C04/C07/C10/C11/C16; đồng bộ kỹ thuật C14, không thay đổi template gốc.
4. Giữ các mã đã cấp; đánh dấu FRONT-004, FRONT-013 và UNIT-002 ngừng áp dụng, không tái sử dụng hoặc đánh lại số. Không sửa bản thảo TESD trong tác vụ này.
5. Chưa triển khai validator/linter. Việc có mã chưa phải bằng chứng các quy tắc đã được máy kiểm tra.

## Còn cần người dùng chốt gì?

Trong 17 điểm đã đối chiếu (gồm C17 khi xuất bản), không còn lựa chọn biên tập chung nào đang chờ người dùng quyết định.

- C01/C02/C03/C04/C07/C10/C11/C16: đã có quyết định trực tiếp của người dùng.
- C05/C06/C08/C09/C12/C13/C15: cấu hình template, bảo toàn số/ngôn ngữ hoặc điều kiện môi trường; xác định từ nguồn và công cụ, không hỏi lại như lựa chọn phong cách.
- C10/C14/C16: đã đồng bộ hướng dẫn/ví dụ số thập phân, macro và số cột. Đã biên dịch ví dụ thành PDF một trang và kiểm tra hiển thị dấu thập phân, header ba cột, gộp hàng bằng rrr và khoảng trống p; không lỗi biên dịch/căn cột. Đây là smoke test ví dụ, chưa phải validator cho toàn bộ quy tắc.
- Khi một bản thảo cụ thể có abstract nhiều đoạn, ký hiệu mơ hồ hoặc metadata thiếu, vẫn báo người dùng theo quy tắc tương ứng; đó là xử lý dữ liệu của bài, không phải mở lại các quyết định biên tập đã chốt.

## Đồng bộ khi xuất bản lên GitHub

- Giữ hướng dẫn đã có tại [c00d465](https://github.com/trungvjm/skills/commit/c00d4657ee9d6f0c470443b86d595a41323f2bce): vị trí sử dụng shortauth/headershort, table-format và ô S không phải số, xltabular với caption/header/footer đúng trang.
- Thêm TAB-015–023 và SEC-011; không đổi/tái sử dụng mã cũ. Danh mục hiện có **161 mã đã cấp, 158 đang áp dụng / 13 nhóm**; ba mã FRONT-004, FRONT-013, UNIT-002 vẫn ngừng áp dụng.
- Đã kiểm tra mã trùng, dải số, tham chiếu và liên kết của cả hai skill. Smoke bằng template Việt đang dùng và template Anh tháng 12: bảng tám cột/80 hàng trải bốn trang, caption một lần, header lặp đủ, không mất/lặp hàng; chân giữa mảnh và chân cuối đậm.
- Mỗi fixture có thêm trang kiểm tra cột S với số âm, {-} và N/A, tổng năm trang; chạy pdflatex ba lần, không lỗi compile/undefined reference/overfull/ký tự thiếu. Đã xem PDF: ở cột S, dấu thập phân tiếng Việt hiển thị phẩy, tiếng Anh hiển thị chấm.
- Không sửa bài thật hoặc template nguồn; fixture được dọn sau kiểm tra, không đưa vào commit. Bản before-rule-ids chỉ giữ lịch sử, không phải nhánh quy tắc đang áp dụng.
