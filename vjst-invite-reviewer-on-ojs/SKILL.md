---
name: vjst-invite-reviewer-on-ojs
description: Tự động hóa quy trình thêm và gửi lời mời phản biện trên hệ thống OJS của tạp chí VJST thông qua browser subagent.
---

# Thêm Phản biện trên Hệ thống OJS (VJST)

Kỹ năng này điều khiển `browser` subagent (thông qua lệnh `/browser` hoặc công cụ tương đương) để tự động hóa việc đưa chuyên gia vào hệ thống OJS của Vietnam Journal of Science and Technology (VJST) từ danh sách phản biện đã có (ví dụ: từ báo cáo HTML/CSV).

## Quy trình thực hiện (Dành cho Agent)

Khi người dùng yêu cầu mời một phản biện (Reviewer) trên hệ thống OJS, họ sẽ cung cấp 2 thông tin đầu vào: Link (URL) của trang phản biện và Thư mục chứa file báo cáo danh sách phản biện (HTML).

1. **Chuẩn bị thông tin:** Agent sẽ tìm và đọc file báo cáo danh sách phản biện (`ID-[3]-Reviewer-suggestion.html` hoặc tương tự) trong thư mục được cung cấp để trích xuất thông tin chuyên gia cần mời (Tên, Email, Cơ quan công tác - Affiliation).
2. **Truy cập trang OJS:** Điều khiển trình duyệt truy cập vào đúng đường link URL mà người dùng đã cung cấp. Đợi trang tải hoàn tất phần giao diện của vòng phản biện.
3. **Mở Form Thêm Phản biện:**
   - Click vào nút **"Add Reviewer"**.
   - Trong cửa sổ popup "Locate a Reviewer", cuộn xuống dưới cùng và click vào nút **"Create New Reviewer"**.
4. **Điền thông tin chuyên gia:**
   - **Given Name:** Tách phần tên đầu của chuyên gia. *Ghi chú: Nên thêm tiền tố học hàm/học vị (ví dụ: "Dr." hoặc "Prof.") vào trước tên nếu biết, hoặc theo mặc định là "Dr.".*
   - **Family Name:** Tách phần họ (và tên đệm) của chuyên gia.
   - **Username:** Nhấn vào nút **"Suggest"** kế bên ô Username để hệ thống OJS tự động sinh tên đăng nhập.
   - **Email:** Dán địa chỉ email của chuyên gia vào ô Email.
   - **Affiliation:** Dán đầy đủ thông tin cơ quan công tác vào ô Affiliation.
5. **Gửi lời mời:**
   - Bỏ qua các mục như Reviewing Interests, Review Form (giữ nguyên mặc định trừ khi có yêu cầu khác).
   - **LƯU Ý QUAN TRỌNG:** KHÔNG tích vào ô "Do not send email to Reviewer" (Để hệ thống tự động gửi thư mời).
   - Click nút **"Add Reviewer"** ở cuối cửa sổ để hoàn thành quá trình thêm và gửi lời mời.

## Xử lý ngoại lệ
- Nếu nút "Suggest" không tạo ra username hợp lệ, tự động điền username theo cú pháp `[Tên][Họ]_[Năm]` (ví dụ: `dwang_2026` viết liền không dấu).
- Nếu chuyên gia đã có tài khoản (email đã tồn tại), hệ thống OJS sẽ báo lỗi. Lúc này, agent cần quay lại bước "Locate a Reviewer", tìm kiếm theo email của chuyên gia đó và chọn "Select Reviewer" thay vì "Create New Reviewer".
