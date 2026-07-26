---
name: vjst-update-aff
description: Tự động cập nhật thông tin tên và Affiliation của tác giả trên hệ thống OJS VJST thông qua browser agent, đảm bảo định dạng và vị trí trường nhập liệu chính xác.
---

# vjst-update-aff: Cập nhật Affiliation và Tên Tác Giả trên OJS VJST

Skill này hướng dẫn agent cách xử lý yêu cầu cập nhật thông tin tác giả trên trang quản trị OJS của Vietnam Journal of Science and Technology (VJST) bằng cách sử dụng `browser` subagent.

## 1. KÍCH HOẠT VÀ KIỂM TRA DỮ LIỆU
Khi người dùng cung cấp **ID bài báo** và **danh sách thông tin tác giả** (bao gồm tên và địa chỉ/affiliation):
1. **Kiểm tra lỗi logic**: Rà soát xem thông tin đầu vào của người dùng có lỗi sai nhỏ nào không (ví dụ: thiếu đánh số, sai chính tả hiển nhiên, tên không khớp với quy tắc...).
2. **Xác nhận**: Trình bày danh sách dữ liệu ĐÃ ĐƯỢC CHUẨN HÓA (xem phần chuẩn hóa bên dưới) cho người dùng xem trước.
3. **CHỜ PHÊ DUYỆT**: Phải đợi người dùng xác nhận "Đồng ý" thì mới được phép chuyển sang bước tiếp theo.

## 2. CHUẨN HÓA DỮ LIỆU
Main agent chuẩn hóa dữ liệu từ người dùng theo định dạng chuẩn của VJST:

### A. Tên tác giả (Authors)
- Hệ thống OJS yêu cầu tách riêng Tên (Given Name) và Họ (Family Name).
- **Quy tắc VJST**: Từ cuối cùng trong tên tác giả LUÔN LUÔN là **Family Name** (Họ). Toàn bộ các từ đứng trước từ cuối cùng là **Given Name**.
  - *Ví dụ*: `Nguyen Dac Truong Giang` -> Given Name: `Nguyen Dac Truong`, Family Name: `Giang`.

### B. Địa chỉ (Affiliation)
- **Đánh số**: Các chỉ số đánh dấu địa chỉ phải được viết dưới dạng superscript của LaTeX để OJS render đúng: `\(^1\)`, `\(^2\)`, `\(^3\)`... (không dùng dạng ngoặc tròn `(1)`, `(2)`).
- **Ngắt dòng**: Nếu một tác giả có từ 2 địa chỉ trở lên, phân tách các địa chỉ bằng thẻ `<br>`. Tuyệt đối không thêm ký tự xuống dòng (như `\n`) vào chuỗi.
  - *Ví dụ*: `\(^1\) Institute of Physics...<br>\(^2\) VNU School...`

## 3. THỰC THI (ỦY QUYỀN CHO BROWSER SUBAGENT)
Sau khi người dùng đã xác nhận, sử dụng tool `invoke_subagent` để gọi `browser` subagent (với `TypeName: "browser"`). Gửi một `Prompt` thật chi tiết và nghiêm ngặt với các yêu cầu sau:

1. **URL**: Yêu cầu truy cập vào `https://vjs.ac.vn/jst/workflow/index/{ID}/4#publication/contributors` (thay thế `{ID}` bằng ID thực tế người dùng cung cấp).
2. **Dữ liệu**: Cung cấp danh sách tác giả đã chuẩn hóa (Given Name, Family Name, và chuỗi Affiliation chính xác).
3. **Thao tác trên giao diện (CỰC KỲ QUAN TRỌNG)**:
   - Mở cửa sổ chỉnh sửa của từng tác giả (click vào nút mở rộng cạnh tên -> Edit) hoặc thêm mới (Add Contributor).
   - Xác minh/sửa đúng **Given Name** và **Family Name**.
   - **Preferred Public Name**: Nếu trường này có dữ liệu, hãy **xóa sạch toàn bộ** (để trống).
   - **Email**: 
     - Bỏ trống nếu tác giả chưa có email trên hệ thống và người dùng cũng không cung cấp.
     - **QUAN TRỌNG**: Nếu tác giả đã có sẵn email trên hệ thống OJS thì **TUYỆT ĐỐI KHÔNG ĐƯỢC XÓA**. Nếu email trên hệ thống có sự sai khác với email do người dùng cung cấp, subagent phải tạm dừng cập nhật trường email của người đó, giữ nguyên hiện trạng và báo cáo lại ngay lập tức để hỏi ý kiến người dùng.
   - **Country**: Chọn quốc gia tương ứng (mặc định là Viet Nam) cho tất cả tác giả.
   - **VỊ TRÍ ĐIỀN AFFILIATION**: Dán chuỗi Affiliation vào **ô text đơn dòng nằm ở trên cùng** có nhãn "Affiliation".
   - **TRÁNH NHẦM LẪN**: Giao diện OJS có một trình soạn thảo văn bản lớn (có các nút bôi đậm, in nghiêng...) ở bên dưới có nhãn "Bio Statement". **TUYỆT ĐỐI KHÔNG** điền thông tin affiliation vào ô Bio Statement này. Nếu ô này đang có bất kỳ dữ liệu affiliation bị điền nhầm nào, hãy **xóa sạch toàn bộ**.
   - Thiết lập người liên hệ chính (Principal Contact) nếu có yêu cầu.
   - Nhấn Save.
4. **Kiểm tra và sắp xếp thứ tự**: Sau khi đã hoàn tất việc điền thông tin và lưu toàn bộ tác giả, subagent **PHẢI** dùng tính năng "Order" (hoặc kéo thả) trên giao diện danh sách Contributors của OJS để điều chỉnh lại thứ tự tác giả sao cho **trùng khớp hoàn toàn** với thứ tự mà người dùng đã cung cấp ban đầu. Nhấn "Done" (nếu có) để lưu thứ tự.
5. Nhấn mạnh việc subagent phải hoàn thành toàn bộ danh sách và báo cáo lại.

## 4. BÁO CÁO VÀ DỌN DẸP
1. Sau khi `browser` subagent báo cáo thành công, kill subagent đó.
2. Thông báo cho người dùng biết công việc đã hoàn tất thành công. (Không yêu cầu quay video màn hình hay gửi file recording).
