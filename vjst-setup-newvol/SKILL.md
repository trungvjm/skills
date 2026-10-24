---
name: vjst-setup-newvol
description: Tự động hóa việc tạo thư mục con cho Volume mới của VJST, sao chép/đổi tên file mẫu VJST.docx và cập nhật đường link DOI theo mã ID bài báo.
---

# Kỹ năng `vjst-setup-newvol`

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

### 4. Cập nhật Đường link DOI theo Mã ID Bài báo
*   Trong mỗi file `VJST-[Tên thư mục].docx` vừa tạo, cập nhật đường link DOI mẫu ở phần header (`word/header3.xml` và `word/_rels/header3.xml.rels`).
*   Thay thế chuỗi `https://doi.org/10.15625/2525-2518/xx` bằng `https://doi.org/10.15625/2525-2518/[ID]` (trong đó `[ID]` là mã số bài báo tương ứng, ví dụ `https://doi.org/10.15625/2525-2518/23683`).
*   Thực hiện trực tiếp trên bộ nhớ bằng lệnh `python3 -c` (tránh tạo file `.py` tạm trên ổ đĩa) và kiểm tra lại cả `word/header3.xml` lẫn `word/_rels/header3.xml.rels` sau khi ghi.

**Mẫu lệnh cập nhật DOI tham khảo:**
```bash
python3 -c '
import io, zipfile

base = "/path/to/VOL64N6"
dirs = ["0-REV-23683", "1-NAT-21761", "2-MAT-19390"]

for d in dirs:
    pid = d.split("-")[-1]
    path = f"{base}/{d}/VJST-{d}.docx"
    old_doi = b"https://doi.org/10.15625/2525-2518/xx"
    new_doi = f"https://doi.org/10.15625/2525-2518/{pid}".encode("utf-8")
    buf = io.BytesIO()
    with zipfile.ZipFile(path, "r") as zin, zipfile.ZipFile(buf, "w") as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if item.filename in ("word/header3.xml", "word/_rels/header3.xml.rels"):
                data = data.replace(old_doi, new_doi)
            zout.writestr(item, data)
    with open(path, "wb") as f:
        f.write(buf.getvalue())
'
```

## Lưu ý khi thực thi
- Agent cần chủ động đề xuất dùng bash command (`run_command`) để tự động hóa hoàn toàn quy trình này.
- Báo cáo kết quả danh sách các thư mục và file đã tạo để người dùng kiểm tra sau khi hoàn tất.
