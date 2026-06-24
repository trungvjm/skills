---
name: academic-search
description: Search for academic papers, summarize research findings, and generate citations (APA, BibTeX). Use when the user asks for scholarly articles, research papers, or needs help with academic literature reviews.
---

# Academic Search & Research

Skill này hỗ trợ tìm kiếm bài báo khoa học, phân tích nội dung học thuật và tạo trích dẫn chuẩn.

## Quy trình thực hiện

1. **Xác định từ khóa**: Chuyển đổi yêu cầu của người dùng thành các query tìm kiếm hiệu quả (sử dụng toán tử `intitle:`, `author:`, v.v.).
2. **Tìm kiếm nguồn**: Sử dụng `google_web_search` tập trung vào các tên miền học thuật như `.edu`, `scholar.google.com`, `arxiv.org`, `researchgate.net`.
3. **Thu thập dữ liệu**: Sử dụng `web_fetch` để đọc nội dung bài báo hoặc tóm tắt (abstract).
4. **Phân tích & Tóm tắt**: Trích xuất các nội dung chính:
    - Mục tiêu nghiên cứu (Objective)
    - Phương pháp (Methodology)
    - Kết quả chính (Key Findings)
    - Kết luận (Conclusion)
5. **Trích dẫn**: Cung cấp trích dẫn theo định dạng APA 7th hoặc BibTeX theo yêu cầu.

## Tài liệu tham khảo

- Xem [sources.md](references/sources.md) để biết thêm về các nguồn dữ liệu và toán tử tìm kiếm nâng cao.

## Ví dụ lệnh

- "Tìm các bài báo mới nhất về ứng dụng của LLM trong y tế."
- "Tóm tắt bài báo này: [URL]"
- "Lấy file BibTeX cho bài báo 'Attention is All You Need'."
- "So sánh các phương pháp nghiên cứu trong 3 bài báo vừa tìm được."

## Lưu ý

- Luôn ưu tiên các nguồn đã qua bình duyệt (peer-reviewed).
- Nếu không tìm được toàn văn bài báo, hãy cung cấp thông tin dựa trên Abstract và thông tin công bố.
- Cảnh báo người dùng nếu nguồn có dấu hiệu không tin cậy hoặc từ các tạp chí "săn mồi" (predatory journals).