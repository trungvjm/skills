---
name: vjst-reviewer
description: >-
  Sử dụng khả năng đa phương thức (Vision) nguyên bản để đọc tài liệu PDF học thuật,
  trích xuất văn bản, biểu đồ, bảng biểu và công thức toán học thành PaperDossier.
  Ngay sau đó, tự động điều phối qua kỹ năng academic-research-suite để đánh giá bản thảo.
---

# VJST Reviewer

## Overview
Kỹ năng này tự động hóa toàn bộ quy trình đọc và đánh giá bản thảo bằng sức mạnh đa phương thức của Gemini. Nó sẽ trực tiếp "nhìn" vào file PDF, trích xuất dữ liệu đa phương thức, kiểm chứng chéo các luận điểm với hình ảnh, lập hồ sơ dữ liệu (PaperDossier), và tự động gọi kỹ năng `academic-research-suite` để thực hiện phản biện (Peer-review).

## Dependencies
- `academic-research-suite`: Bắt buộc sử dụng để thực hiện bước đánh giá bản thảo sau khi đã trích xuất dữ liệu.
- `avoid-ai-writing`: Sử dụng để tinh chỉnh văn phong của báo cáo phản biện, loại bỏ các mẫu câu rập khuôn của AI.

## Quick Start
Khi người dùng tải lên một bài báo PDF và nói: "Dùng vjst-reviewer để xử lý bài này."

## Workflow

### 1. Phân tích Đa phương thức (Multimodal Extraction)
- Đọc file PDF hoặc hình ảnh bài báo do người dùng cung cấp.
- Quét và ghi nhận cẩn thận:
  - **Văn bản cốt lõi:** Tóm tắt (Abstract), Luận điểm (Claims), Kết luận.
  - **Hình ảnh / Biểu đồ:** Đọc dữ liệu, xu hướng đồ thị.
  - **Bảng biểu:** Cấu trúc lại bảng số liệu.
  - **Công thức (Equations):** Quét và chuyển đổi các công thức toán học trong bài thành định dạng LaTeX.

### 2. Xác minh chéo (Cross-Verification)
- Đối chiếu các luận điểm khoa học (claims) trong văn bản với dữ liệu thực tế thể hiện trên hình ảnh/bảng biểu.
- Lập một bản đồ bằng chứng (Evidence Map).
- Chú thích rõ những khối thông tin không chắc chắn (Uncertain Blocks) nếu hình bị mờ hoặc có sự bất đồng giữa văn bản và biểu đồ.

### 3. Lập hồ sơ (PaperDossier Generation)
- Đóng gói dữ liệu thu được thành một cấu trúc `PaperDossier` mạch lạc (bao gồm: Title, Summary, Claims, Evidence Map, Uncertain Blocks, Key Contributions, và Equations).

### 4. Đánh giá Bản thảo (Automatic ARS Handoff)
- **Bắt buộc:** Sau khi hoàn thành `PaperDossier`, Agent phải TỰ ĐỘNG gọi các kỹ năng trong `academic-research-suite` (cụ thể là chế độ `/ars-reviewer` hoặc quy trình trong `ars/academic-paper-reviewer/WORKFLOW.md`).
- Sử dụng toàn bộ `PaperDossier` làm tài liệu đầu vào cho hội đồng phản biện mô phỏng để đánh giá tính logic của phương pháp, phát hiện lỗ hổng, và ra quyết định biên tập.
- **Cấu trúc Báo cáo Phản biện:** Yêu cầu báo cáo phải bao gồm phần kết luận (Conclusion) rõ ràng và đặt ra các câu hỏi sắc bén dành cho tác giả (Questions for Authors) giống như một phản biện viên thực thụ.

### 5. Tinh chỉnh Văn phong (Humanize Review)
- Trước khi xuất kết quả cuối cùng cho người dùng, **bắt buộc** phải chuyển toàn bộ nội dung bản nhận xét qua kỹ năng `avoid-ai-writing` (hoặc lệnh `/avoid-ai-writing`).
- Đảm bảo văn phong tự nhiên, loại bỏ các từ ngữ sáo rỗng (clichés) của AI, mang lại cảm giác đây là một bản phản biện do con người viết.

### 6. Xuất Báo cáo Đa ngữ (Bilingual Artifact Export)
- **Bắt buộc:** Lưu bản nhận xét cuối cùng thành một file Markdown (`.md`) dưới dạng Artifact trong workspace của người dùng (không chỉ in ra màn hình chat).
- Đảm bảo file `.md` này chứa **cả 2 phiên bản: Tiếng Việt và Tiếng Anh** để người dùng có thể tiện nộp cho các tạp chí quốc tế hoặc hội đồng trong nước. Công thức toán học (LaTeX) phải được hiển thị chuẩn xác trong file này.

## Common Mistakes
- **Bỏ quên công thức:** Không chuyển đổi công thức sang LaTeX, khiến hội đồng phản biện phía sau không thẩm định được thuật toán/toán học.
- **Dừng lại nửa chừng:** Quên không tự động gọi `academic-research-suite` ở bước cuối cùng mà chỉ xuất mỗi Dossier.
- **Ảo giác số liệu:** Tự bịa số liệu trong hình ảnh mờ thay vì trung thực đưa chúng vào danh sách "Uncertain Blocks".
