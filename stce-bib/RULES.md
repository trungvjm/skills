# Danh mục quy tắc stce-bib

Mỗi dòng dưới đây định nghĩa một mã quy tắc duy nhất cho `stce-bib`.

- Tiền tố: `STCE-BIB-<NHÓM>-<SỐ>`.
- Mức: **MUST** = bắt buộc; **SHOULD** = khuyến nghị.
- Kiểm chứng: **SRC** = đọc mã nguồn `.bib`/`.bbl`; **DIFF** = đối chiếu danh mục tài liệu gốc; **BUILD** = chạy `bibtex`/`pdflatex`; **PDF** = kiểm tra hiển thị trên PDF.

| Mã | Mức | Quy tắc | Kiểm chứng |
|---|---|---|---|
| STCE-BIB-CORE-001 | MUST | Không tự ý thay đổi nội dung học thuật/metadata gốc (không tự sửa năm đúng hay thêm tác giả không có trong nguồn). | DIFF |
| STCE-BIB-KEY-001 | MUST | Tách từng tài liệu tham khảo riêng biệt, giữ nguyên thứ tự gốc và đánh key số tăng dần từ `1`, `2`, `3`, ... | SRC, DIFF |
| STCE-BIB-TXT-001 | MUST | Trường `title` định dạng theo sentence case ("normal case"): chỉ viết hoa chữ cái đầu tiên, chữ cái đầu sau dấu hai chấm `:`, và danh từ riêng/từ viết tắt; thuật ngữ in nghiêng (như tên loài) dùng `\textit{}`. | SRC, PDF |
| STCE-BIB-TXT-002 | MUST | Giữ nguyên Unicode tiếng Việt cho mọi trường ngoài `author`. | SRC, PDF |
| STCE-BIB-JRN-001 | MUST | Khi bài báo có DOI, tên tạp chí trong trường `journal` phải khớp với dữ liệu chính thức (`container-title`) từ DOI Crossref hoặc DOI của nhà cung cấp khác. | SRC, DIFF |
| STCE-BIB-AUTH-001 | MUST | Chữ viết tắt tên tác giả có đúng một khoảng trắng sau mỗi dấu chấm (ví dụ: `Asmone, A.S.` → `Asmone, A. S.`). | SRC |
| STCE-BIB-AUTH-002 | MUST | Chữ `Đ` hoặc `đ` trong trường `author` chuyển thành `{\DJ}` hoặc `{\dj}` (chỉ áp dụng trong trường `author`). | SRC, PDF |
| STCE-BIB-TYPE-001 | MUST | `@article` giữ nguyên kiểu mục; ưu tiên trường `doi` nếu có. | SRC |
| STCE-BIB-TYPE-002 | MUST | `@book` và `@inproceedings` (`@inproceeding`) giữ nguyên kiểu mục; nếu có `doi` thì phải chuyển thành `url = {https://doi.org/...}` và xóa trường `doi`. | SRC, PDF |
| STCE-BIB-TYPE-003 | MUST | `@techreport` chuyển thành `@manual`; giữ `author`, `title`, `year`, `url` (nếu có); đưa các thông tin còn lại vào `address`. | SRC, PDF |
| STCE-BIB-TYPE-004 | MUST | `@incollection` chuyển thành `@inproceedings` (`@inproceeding`). | SRC, BUILD |
| STCE-BIB-TYPE-005 | MUST | `@misc` chuyển thành `@manual`. | SRC |
| STCE-BIB-STD-001 | MUST | Tài liệu tiêu chuẩn chuyển thành `@manual`; đặt mã hiệu tiêu chuẩn (ví dụ: `BS EN 1052-1:1999`, `TCVN 14334:2025`, `ASTM C618-12`) vào trường `note`; giữ `title` và `url` (nếu có); đưa các thông tin còn lại (cơ quan ban hành, nơi xuất bản) vào `address`. | SRC, PDF |
| STCE-BIB-STD-002 | MUST | Với tài liệu tiêu chuẩn (`@manual`), nếu mã hiệu trong trường `note` **đã có năm ban hành** (ví dụ `TCVN 14334:2025`, `BS EN 1052-1:1999`, `ASTM C618-12`, `ASTM C39/C39M-21`), **PHẢI bỏ trường `year`** để không bị in lặp năm trên PDF (như `TCVN 14334:2025 (2025).`). Chỉ giữ `year` khi trong `note` chưa có năm. | SRC, PDF |
