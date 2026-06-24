---
name: setup-newvol
description: Tự động hóa việc tạo thư mục con cho Volume mới của VJST và sao chép/đổi tên file mẫu VJST.docx.
---

# Kỹ năng `setup-newvol`

Kỹ năng này được sử dụng để tự động hóa quy trình thiết lập cấu trúc thư mục cho một tập san (Volume/Issue) mới của tạp chí VJST.

## Các bước thực hiện

### 1. Phân tích ID và Phân loại (Categories)
*   Người dùng sẽ cung cấp danh sách các ID bài báo cùng phân loại của chúng (có thể thông qua văn bản hoặc hình ảnh).
*   Ánh xạ các phân loại (Categories) thành các tiền tố (Prefixes) tương ứng như sau:
    *   `REV` -> `0-REV`
    *   `NAT` -> `1-NAT`
    *   `MAT` -> `2-MAT`
    *   `ENV` -> `3-ENV`
    *   `ELE` -> `4-ELE`
    *   `MEC` -> `5-MEC`
*   Định dạng tên thư mục sẽ là: `[Tiền tố]-[ID]` (Ví dụ: `0-REV-23683`).

### 2. Tạo Thư Mục
*   Xác định thư mục Volume đích từ người dùng (ví dụ: `.../04-Publication/2026/VOL64N4`).
*   Sử dụng lệnh shell để tạo hàng loạt các thư mục con tương ứng với danh sách ID đã phân tích.
*   Lệnh ví dụ: `mkdir -p "VOL.../0-REV-23683" "VOL.../1-NAT-21761"`

### 3. Sao chép và Đổi tên File Mẫu
*   Xác định đường dẫn của file mẫu `VJST.docx`. Thường file này nằm ở thư mục gốc `04-Publication` (ví dụ: `/Users/trungtranngoc/Library/CloudStorage/GoogleDrive-tranngoctrung.tnt@gmail.com/My Drive/VJST/04-Publication/VJST.docx`).
*   Sử dụng vòng lặp trong bash để sao chép file `VJST.docx` vào từng thư mục con vừa tạo.
*   Đổi tên file đã sao chép theo định dạng `VJST-[Tên thư mục].docx` (Ví dụ: `VJST-0-REV-23683.docx`).

**Mẫu kịch bản Bash (bash script) tham khảo để thực thi nhanh:**
```bash
# Đặt biến SRC trỏ tới file VJST.docx
SRC="../../VJST.docx" # Điều chỉnh đường dẫn tương đối hoặc tuyệt đối cho chính xác

# Chạy vòng lặp qua các tên thư mục con
for dir in 0-REV-23683 1-NAT-21761 2-MAT-19390; do
  cp "$SRC" "$dir/VJST-$dir.docx"
done
```

## Lưu ý khi thực thi
- Agent cần chủ động đề xuất dùng bash command (`run_command`) để tự động hóa hoàn toàn quy trình này.
- Báo cáo kết quả danh sách các thư mục và file đã tạo để người dùng kiểm tra sau khi hoàn tất.
