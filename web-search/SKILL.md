---
name: web-search
description: Search the web, analyze content, and synthesize results from multiple sources. Use when you need to gather information, summarize articles, or perform general research across the internet.
---

# Web Search & Research Skill

Skill hỗ trợ tìm kiếm thông tin trên web, phân tích nội dung, và tổng hợp kết quả.

## Khả năng

### 1. Tìm kiếm học thuật
- Tìm bài báo khoa học trên Google Scholar
- Trích xuất thông tin từ Scopus (nếu có API key)
- Tổng hợp kết quả theo chủ đề

### 2. Phân tích nội dung web
- Đọc và tóm tắt bài viết
- Phân tích luận điểm và logic
- Phát hiện ngụy biện logic (logical fallacies)
- So sánh nhiều nguồn

### 3. Tổng hợp thông tin
- Tạo báo cáo tổng hợp từ nhiều nguồn
- Format kết quả dạng bảng hoặc markdown
- Đánh giá độ tin cậy của nguồn

## Cách sử dụng

Chỉ cần yêu cầu:
- "Tìm bài báo về [chủ đề]"
- "Phân tích bài viết này: [URL]"
- "So sánh các nguồn về [chủ đề]"

## Cấu hình (tùy chọn)

Nếu có Scopus API key, tạo file `.env` trong workspace:
```
SCOPUS_API_KEY=your_api_key_here
```

## Lưu ý
- Luôn kiểm chứng thông tin từ nhiều nguồn
- Ưu tiên nguồn peer-reviewed cho nghiên cứu học thuật
- Ghi rõ nguồn trích dẫn trong báo cáo