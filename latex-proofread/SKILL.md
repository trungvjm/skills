---
name: latex-proofread
description: Chuyên gia hiệu đính văn bản khoa học tiếng Anh (English Proofreading) sử dụng LaTeX changes package. Alias gọi nhanh: /latex-proofread, /proofread
---

# latex-proofread: Hướng dẫn Hiệu đính Tiếng Anh (English Proofreading Guidelines)

Kỹ năng này cung cấp các tiêu chuẩn và quy tắc để hiệu đính (proofread) văn bản khoa học tiếng Anh, đặc biệt trong môi trường LaTeX.

## 1. Quy tắc sử dụng gói `changes` (Markup Rules)
- Sử dụng các lệnh markup ở mức độ từ/cụm từ (word/phrase level):
  - `\replaced{new}{old}` cho thay thế.
  - `\added{new}` cho thêm mới.
  - `\deleted{old}` cho xoá bỏ.
- **QUY TẮC CỐT LÕI VỀ \replaced (Tránh lặp từ):** Tuyệt đối không lặp lại những từ không thay đổi vào bên trong nội dung của lệnh `\replaced`. Chỉ đặt markup vào đúng từ/tiền tố/hậu tố có sự thay đổi để tối ưu hoá việc đọc lịch sử chỉnh sửa.
  - *Sai:* `\replaced{theoretical investigations}{theoretical investigation}`
  - *Đúng:* `theoretical \replaced{investigations}{investigation}`
  - *Sai:* `\replaced{Let us consider}{Let consider}`
  - *Đúng:* `Let \added{us} consider`

## 2. Quy tắc an toàn trong LaTeX (Safety Rules)
- KHÔNG thay đổi nội dung khoa học, số liệu, công thức, citation key, label/ref.
- KHÔNG đặt bất kỳ lệnh markup nào (`\replaced`, `\added`, `\deleted`) vào bên trong môi trường toán học (như `$ ... $` hoặc `\begin{equation} ... \end{equation}`). Nếu sửa text xung quanh công thức, phải để các ký hiệu toán học bên ngoài markup.
- Luôn đảm bảo dấu ngoặc `{ }` cân bằng và lệnh citation được giữ nguyên vẹn để không làm lỗi file LaTeX.
- Không tự ý compile (biên dịch) LaTeX mặc định sau khi sửa trừ khi người dùng yêu cầu rõ ràng.

## 3. Các nhóm lỗi thường gặp cần chú ý
- **Lỗi Mạo từ (Articles):** Bổ sung mạo từ xác định "the" cho các danh từ cụ thể/đã được định nghĩa, hoặc mạo từ "a/an" cho danh từ đếm được số ít. Xoá mạo từ "the" thừa (ví dụ trước sở hữu cách hoặc danh từ chung chung).
- **Lỗi Dạng từ & Ngữ pháp:** Số ít/số nhiều, V-ing/V-ed (nhất là sau giới từ), phân biệt chủ động/bị động.
- **Lỗi Từ vựng (Vocabulary):** Sửa các từ dùng chưa chuẩn trong văn cảnh khoa học (ví dụ: dùng `assumed` thay cho `supposed`, `embedded` thay cho `imbedded`, `agree well` thay cho `tie in well`).
