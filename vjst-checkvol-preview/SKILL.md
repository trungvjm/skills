---
name: vjst-checkvol-preview
description: "Rà soát, kiểm tra toàn diện và đối soát metadata, số trang, tiêu đề, tác giả, affiliation, DOI và file PDF Galleys của một số báo (Issue Preview) trên hệ thống OJS VJST trước khi xuất bản online (Publish Issue). Alias: /vjst-checkvol-preview"
---

# VJST Check Issue Preview — Rà Soát Số Báo Trước Khi Xuất Bản Online

Kỹ năng tự động hóa và hướng dẫn kiểm tra, đối soát toàn diện trang Preview của một số báo trên hệ thống Open Journal Systems (OJS) của Tạp chí **Vietnam Journal of Science and Technology (VJST)** trước khi bấm **Publish Issue**.

---

## 1. NGUYÊN TẮC TRUY CẬP (BROWSER INTEGRATION)

1. **Bắt buộc dùng Browser Subagent**: Các trang Preview Issue trên OJS (ví dụ: `https://vjs.ac.vn/jst/issue/view/[ISSUE_ID]`) yêu cầu phiên đăng nhập quản trị (session cookies). Công cụ fetch trực tiếp (`read_url_content`) sẽ bị trả về lỗi `403 Forbidden`.
2. **Khởi tạo Browser Subagent**: Luôn khởi tạo hoặc gửi lệnh cho `browser` subagent với URL Preview được cung cấp để rà soát trực tiếp trên giao diện web và tải/đọc file PDF Galleys, PDF Bìa, PDF Mục lục.
3. **Không cần quay màn hình (No Screen Recording)**: Không cần quay video màn hình thao tác trình duyệt. Nếu hệ thống tự động sinh file video (`recording.webm`), tự động xóa bỏ ngay sau khi kiểm tra xong để tiết kiệm tài nguyên.

---

## 2. QUY TRÌNH KIỂM TRA TOÀN DIỆN (CHECKLIST)

### A. Thông tin chung của Số (Issue-Level Metadata)
- **Tập & Số (Volume & Number)**: Kiểm tra Vol., No., và Năm xuất bản (ví dụ: `Vol. 64 No. 4 - 2026`).
- **File Bìa (Cover PDF) & Mục lục (Contents/TOC PDF)**: Đảm bảo có link tải file PDF Bìa và PDF Mục lục đầy đủ.
- **Ảnh bìa đại diện (Issue Cover Image)**: Kiểm tra ô thumbnail ảnh bìa trực quan trên web OJS (`Issue Data > Issue Cover Image`).

---

### B. Đối soát từng bài báo (Article-Level Checklist)

#### 1. Thứ tự bài và Chuyên mục (Sections)
- Kiểm tra các bài báo được phân đúng chuyên mục chuẩn của VJST:
  - `REVIEW`
  - `NATURAL PRODUCTS`
  - `MATERIALS`
  - `ENVIRONMENT`
  - `ELECTRONICS - TELECOMMUNICATION`
  - `MECHANICAL ENGINEERING - MECHATRONICS`
  - (hoặc các chuyên mục khác theo cấu trúc số).

#### 2. Tính liên tục của số trang (Page Continuity)
- **Kiểm tra tính liên tục tuyệt đối**: Trang bắt đầu của bài sau phải liền kề ngay sau trang kết thúc của bài trước (ví dụ: 595–615, 616–626, 627–634...).
- Không được có khoảng trống (hổng trang) hoặc trùng lặp số trang giữa các bài.
- Số trang trên web OJS phải khớp 100% với số trang in trên từng file PDF Galley và file PDF Mục lục số.

#### 3. Tiêu đề bài báo (Title)
- **Sentence case**: Chữ cái đầu câu và chữ cái đầu tiên sau dấu hai chấm (`:`) viết hoa; các từ thông thường còn lại viết thường.
- **Tên loài / Danh pháp sinh học (Latin)**: Bọc trong thẻ `<i>...</i>` (ví dụ: `<i>Escherichia coli</i>`, `<i>Centella asiatica</i>`, `<i>Perna viridis</i>`).
- **Công thức hóa học**: Chỉ số dưới bọc trong thẻ `<sub>...</sub>` (ví dụ: `TiO<sub>2</sub>`, `Fe<sub>3</sub>O<sub>4</sub>`).
- **Chỉ số trên / Số mũ**: Bọc trong thẻ `<sup>...</sup>` (ví dụ: `10<sup>6</sup>`, `Fe<sup>3+</sup>`).
- **Từ viết tắt chuyên ngành (ALL CAPS)**: Giữ nguyên chữ in hoa (ví dụ: `TVB-N`, `PTP1B`, `ABS/PPO`, `CNTs`, `PANI`).
- **Dấu cách**: Không để lỗi 2 dấu cách liên tiếp (`  `).

#### 4. Tác giả & Thứ tự tác giả (Authors & Order)
- **Thứ tự tác giả**: Đối soát kỹ thứ tự từng tác giả trên Web OJS so với file PDF Galley và PDF Mục lục (tránh trường hợp tác giả bị kéo lệch vị trí).
- **Tác giả liên hệ (Corresponding Author)**: Đánh dấu sao `*` đúng tác giả liên hệ.

#### 5. Địa chỉ tác giả (Affiliation)
- **Định dạng chỉ số**: Dùng `\(^1\)`, `\(^2\)`, `\(^3\)` ở đầu mỗi affiliation.
- **Ngắt dòng**: Thêm `<br>` giữa các affiliation.
- **Đơn tác giả**: Nếu bài báo chỉ có 1 tác giả duy nhất (1 đơn vị), không cần để `\(^1\)`.
- **Chuẩn hóa địa giới hành chính Việt Nam (Sau 01/07/2025)**: Chỉ gồm 2 cấp (xã/phường và tỉnh/thành phố), ví dụ: `Nghia Do Ward, Ha Noi, Viet Nam`, `Hanh Thong Ward, Ho Chi Minh City, Viet Nam`.
- **Lỗi văn bản**: Tuyệt đối không để sót chuỗi văn bản rác hoặc dán lặp (paste duplicates) trong ô affiliation.

#### 6. Nhãn file Galley (Galley Labels)
- Nút tải file ngoài trang mục lục và trong trang bài báo phải hiển thị nhãn chữ **`PDF`** (không được hiển thị chuỗi số ID hệ thống như `2543256261`).
- Đường dẫn tải file chuẩn: `https://vjs.ac.vn/jst/article/view/[ARTICLE_ID]/pdf`.

#### 7. Mã định danh số (DOI)
- Kiểm tra cấu trúc DOI chuẩn của VJST: `10.15625/2525-2518/[SUBMISSION_ID]`.

#### 8. Đối soát File PDF Galley
- Mở/đọc từng file PDF Galley:
  - Khớp tiêu đề, danh sách tác giả, affiliation.
  - Khớp ngày nhận bài (`Received`), sửa bài (`Revised`), chấp nhận đăng (`Accepted`).
  - Khớp running header (Vol, No, Year, Pages, DOI) ở đầu và cuối trang.

---

## 3. CẤU TRÚC BÁO CÁO KẾT QUẢ

Báo cáo gửi Ban Biên tập phải được phân chia rõ ràng theo 3 phần:

### Phần I: Các lỗi bắt buộc phải sửa trước khi xuất bản (Critical Errors)
- Liệt kê cụ thể từng bài (Mã bài, Chuyên mục, Mô tả lỗi chi tiết trên Web vs PDF, Hướng dẫn cách bấm sửa trong OJS).

### Phần II: Các điểm khuyến nghị tối ưu (Minor Recommendations)
- Dấu cách thừa, đồng nhất cách viết tắt/đầy đủ của tên loài, bỏ `\(^1\)` thừa...

### Phần III: Bảng tổng hợp đối soát toàn bộ các bài báo trong số
- Bảng Markdown gồm các cột: `STT`, `Mã bài`, `Chuyên mục`, `Tiêu đề rút gọn & Tác giả`, `Số trang`, `DOI`, `Trạng thái PDF & Metadata`.

### Phần IV: Đánh giá kỹ thuật & Kết luận
- Tổng số trang và tính liên tục.
- Xác nhận trạng thái: Đã sẵn sàng bấm **Publish Issue** hay chưa.

---

## 4. QUY ĐỊNH VỀ VIDEO GHI HÌNH (NO SCREEN RECORDING)
- **Không cần quay màn hình**: Quá trình kiểm tra tập trung vào trích xuất và đối soát metadata, không yêu cầu ghi hình màn hình.
- **Tự động dọn dẹp**: Nếu môi trường browser tự động sinh file video `recording.webm`, tiến hành xóa file ngay lập tức và không gửi liên kết video cho người dùng.
