# Đối chiếu latex-stce-en với mẫu tháng 12

Nguồn lịch sử: `SKILL.before-rule-ids.md` (416 dòng). Nguồn hiện hành: `Vol.20 No.4 - 12.2026/04-Papers` (DEC). Mỗi hồ sơ phân biệt mâu thuẫn thật, ví dụ sai và khác biệt theo chế độ đầu ra; không tự yêu cầu người dùng chọn những gì nguồn đã xác định được.

## Received: hai thông tin mới đã xác định bằng nguồn

| Vị trí | Nhãn thực trong class/PDF | Ý nghĩa |
|---|---|---|
| 1 | Received | Ngày nhận bài |
| 2 | Revised | Ngày bản sửa theo metadata |
| 3 | Accepted | Ngày chấp nhận |
| 4 | Available online | Ngày công bố trực tuyến |
| 5 | Version of Record | Ngày công bố bản chính thức |

Bằng chứng: DEC/STCE/stce.cls:273–286; bài `01_3595_Dinh Viet Cuong.tex:34`, `02_3576_Nguyen Thi Thuy Hien.tex:24`. Các bài 03–08 cũng có năm đối số. PDF bài 01/02 hiển thị nhãn Available online và Version of Record; class đặt Version of Record xuống dòng riêng.

Ngày 16/10/2026 và 25/12/2026 xuất hiện ở trường 4/5 của các bài mẫu số này. Đây là bằng chứng cho số tháng 12, **không phải ngày mặc định cho bài/số khác**. Không suy ngày từ timestamp file, ngày hiện tại hay ngày Accepted.

## Hồ sơ đối chiếu

| Mã | Vấn đề và bằng chứng | Quy tắc liên quan | Trạng thái / xử lý |
|---|---|---|---|
| EN-C01 | Skill §1 dùng stce_proof; các bài final DEC (01:2, 02:3) dùng stce.sty, không watermark. | STCE-EN-TPL-001; STCE-EN-TPL-003; STCE-EN-TPL-005 | **Đã phân định phạm vi:** package theo proof/final của đầu ra; không nạp cả hai. Dùng mẫu thực tế, không chép metadata của bài mẫu. |
| EN-C02 | Skill §2.2 không quy định case; bảng so sánh cũ của skill Việt nói English Title case. DEC có bảy bài source HOA, bài08:17 source Title Case; stce.sty:211 tự MakeUppercase khi in PDF. | STCE-EN-FRONT-003 | **Phân biệt source/PDF:** giữ case source, không tạo thêm thao tác chuyển case không cần thiết; PDF theo class hiện hành (HOA). Không áp Sentence case tiếng Việt; không đổi nhận dạng ký hiệu toán/hóa học. Hai cách source đang cho cùng một cách hiển thị nên không cần hỏi thêm chỉ để chọn thao tác nội bộ. |
| EN-C03 | Comment §2.4 nói headershort lấy tác giả đầu; gạch đầu dòng lại lấy tác giả liên hệ. DEC bài01:21–29 có tác giả đầu Tuan, liên hệ Cuong, header Tuan. | STCE-EN-FRONT-007; STCE-EN-FRONT-009 | **Đã thống nhất theo nguồn và quyết định headershort trước đó:** từ ba tác giả lấy tác giả đầu + et al.; shortauth/mailauth vẫn của tác giả liên hệ. |
| EN-C04 | §0 chỉ yêu cầu backup tex; checklist §8.1 yêu cầu cả original.tex và original.bib. | STCE-EN-BACKUP-001–003 | **Đồng bộ kỹ thuật:** backup cả tex/bib có sẵn, không ghi đè bản gốc. |
| EN-C05 | Ví dụ §0 tự đổi 300C thành 30°C dù cấm đổi số. | STCE-EN-CORE-002; STCE-EN-CORE-010 | **Ví dụ không an toàn:** không tự áp dụng; chỉ chuẩn hóa khi giá trị đã được nguồn/người dùng xác nhận. |
| EN-C06 | Ví dụ tác giả §2.3 có một dấu } thừa; §0 nói giữ tên nhưng ví dụ Andisheh K et al → Andisheh et al. lại bỏ K. | STCE-EN-CORE-008; STCE-EN-FRONT-005 | **Lỗi ví dụ:** sửa ngoặc và giữ initials; không phải lựa chọn biên tập cần chốt. |
| EN-C07 | Cấm gộp đoạn nhưng abstract phải một paragraph; skeleton luôn chèn Acknowledgment dù nguyên tắc không cho thêm nội dung. | STCE-EN-CORE-006; STCE-EN-FRONT-015; STCE-EN-SEC-003 | **Theo quyết định bảo toàn nguồn:** abstract nhiều đoạn phải giữ và báo người dùng; chỉ thêm Acknowledgment khi nguồn có, không viết nội dung cảm ơn giả. |
| EN-C08 | Skill §2.6 có ba ngày; DEC class:273–286 hỗ trợ năm trường, hai trường cuối có điều kiện ẩn khi rỗng. | STCE-EN-HIST-001–011 | **Đã xác định API hiện hành:** mặc định viết đủ năm đối số. Chưa có ngày 4/5 thì dùng {} ở đúng vị trí. Class vẫn đọc ba/bốn đối số để tương thích nguồn cũ, không phải lý do bỏ hai trường mới. Không đưa năm đối số vào class cũ chỉ hỗ trợ ba. |
| EN-C09 | Ví dụ subsubsection §3.2 có dòng trống trước paragraph nhưng §3.3 cấm; ví dụ bảng §6.1 khai báo 18 cột cho ba ô; câu chữ kết thúc hàng cuối dễ gây hàng trắng. Bước4 §8 khiến comment phần trăm bị hiểu là bắt buộc, trong khi các bài DEC không yêu cầu chúng. | STCE-EN-SEC-008; STCE-EN-TAB-001; STCE-EN-TAB-007; STCE-EN-EQ-010 | **Đồng bộ ví dụ:** số cột theo bảng thực tế; ba cột phải khai báo ba; hàng cuối chỉ kết thúc một lần trước bottomrule. Comment phần trăm tùy chọn, không thay quy tắc dòng trống. |
| EN-C10 | Nội dung skill Anh cũ dùng nhiệt độ thủ công, checklist §8.1 lại bắt siunitx. DEC dùng cả hai: bài01 đơn vị thủ công; bài02 có unit/qty; bài08 nhiều mathrm. | STCE-EN-UNIT-001–005 | **ĐÃ CHỐT trong lần cập nhật này:** người dùng chọn “Thủ công như tiếng Việt”. Đơn vị thông thường dùng math mode và mathrm, giữ slash/cách viết nguồn; siunitx chỉ cho ký hiệu/prefix đặc biệt. Cột S là căn số, không buộc đổi đơn vị sang siunitx. |
| EN-C11 | DEC/stce.sty:259–265 và stce_proof.sty:260–266 có copyright/license với năm 2026 hard-code; copyrightyear không cập nhật chuỗi đó. | STCE-EN-TPL-010 | **Cảnh báo template:** kiểm tra PDF/footer khi dùng cho năm khác; không tự đổi template trong tác vụ mã hóa skill này. |
| EN-C12 | Lưu ý §8 đòi tool view_file/cấm mọi tìm kiếm và luôn commit, bất kể môi trường. | STCE-EN-WORK-002; STCE-EN-WORK-004 | **Điều kiện môi trường:** dùng tool đọc hiện có, tìm kiếm chỉ hỗ trợ định vị; commit khi có Git và được cho phép. |
| EN-C13 | §3.2 nói subsubsection italic, nhưng DEC/stce.cls:482–486 đặt subsection italic và subsubsection đứng; stce_package:43 đặt nhãn a., b., c. | STCE-EN-SEC-004–005 | **Mô tả sai đã sửa:** để class/template xử lý font và nhãn; không bọc italic cho subsubsection theo skill cũ. |
| EN-C14 | §6.2 nói LUÔN tabularx trong float, trong khi DEC bài08:1034 dùng xltabular cho bảng nhiều trang. | STCE-EN-TAB-001 | **Phân định phạm vi theo mẫu:** tabularx cho bảng một trang; bảng nhiều trang dùng môi trường phù hợp nguồn/mẫu. Không ép bảng nhiều trang vào một float hoặc cắt dữ liệu cho vừa. |
| EN-C15 | §5.5 nói mọi hình dùng [ht!] nhưng §5.4 dùng wrapfigure với placement R; quy tắc float/caption bảng cũng không thể áp nguyên cú pháp tabularx cho xltabular. | STCE-EN-FIG-004; STCE-EN-TAB-005 | **Phân định cú pháp môi trường:** figure/table float thông thường dùng [ht!]; wrapfigure và môi trường nhiều trang theo cú pháp riêng. Không thêm tham số float sai vị trí chỉ để thỏa câu LUÔN trong skill cũ. |
| EN-C16 | Khi xuất bản phát hiện GitHub c00d465 đã có phân biệt shortauth/headershort, cấu hình cột S và template xltabular, nhưng bản cài làm baseline chưa có. | STCE-EN-FRONT-007–009; STCE-EN-TAB-011–019 | **Giữ thay đổi upstream:** ghép hướng dẫn bảng dài/cột S, cấp mã nối tiếp, không renumber hoặc ghi đè mất phần đã xuất bản. Bảng nhiều trang dùng xltabular theo hướng dẫn đã có trên GitHub; quy tắc float một trang được giới hạn đúng phạm vi. |

## Phạm vi quyết định

- Không hỏi lại các quy tắc không phụ thuộc ngôn ngữ đã được người dùng chốt: khoảng trắng giữa key cite, số cột thực tế, subcaption viết hoa đầu, không dòng trống trước equation, caption bỏ dấu chấm cuối, abstract nhiều đoạn báo người dùng.
- Giữ đặc thù Anh: dấu chấm thập phân, et al., Fig./Table/Eq., corref{cor}, frontmatter một ngôn ngữ.
- Đã xác nhận mặc định đơn vị tiếng Anh (EN-C10); hiện không còn lựa chọn biên tập bắt buộc đang chờ. Case source và padding ngày hợp lệ được giữ theo nguồn; chỉ hỏi khi metadata thực tế thiếu/mâu thuẫn. Không hỏi tên hai trường received vì class và PDF đã cung cấp bằng chứng trực tiếp.
- Chưa triển khai validator/linter cho toàn bộ quy tắc. Việc tra mã hoặc compile ví dụ chỉ chứng minh phần thực sự được kiểm tra.

## Kiểm chứng lần mã hóa này

- Ở bước mã hóa ban đầu, danh mục có **125 mã duy nhất / 14 nhóm**: 111 MUST, 7 SHOULD, 7 MAY. Đã kiểm tra mã trùng, thứ tự số, tham chiếu/range, liên kết và code fence. Số mã sau khi ghép upstream được ghi ở mục xuất bản bên dưới.
- Dùng bản sao template DEC, chạy pdflatex → BibTeX → pdflatex → pdflatex cho năm fixture tạm: đủ năm ngày; hai trường mới rỗng; chỉ có Available online; chỉ có Version of Record; bản proof đủ năm ngày.
- Cả năm sinh PDF một trang, không undefined citation/reference; BibTeX không có warning. Kiểm tra được nhãn/ngày đúng vị trí, trường rỗng bị ẩn, mỗi ngày chỉ xuất hiện đúng số lần, nội dung sau history còn nguyên và Version of Record xuống dòng riêng.
- Đã xem PDF final/proof và các vùng history rỗng: watermark chỉ ở proof; bảng ba cột, lll/rrr/p và đơn vị thủ công hiển thị đúng; subsection italic, subsubsection đứng. Citation có khoảng trắng giữa key vẫn phân giải.
- Vẫn có warning không chặn build về tên class/package theo đường dẫn, caption nhận dạng class, mhchem chưa chỉ định version, ctable/TikZ transparency và font-size substitution. Warning unused captionsetup[figure] xuất hiện vì fixture không có hình. Không sửa template để che warning.
- Checksum bản backup 416 dòng và bốn file class/style/proof-style/package nguồn DEC không đổi trong quá trình kiểm chứng. Không sửa bài thật của số tháng 12; fixture tạm được dọn sau kiểm tra.
- Bản `SKILL.before-rule-ids.md` chỉ lưu lịch sử để đối chiếu, không phải quy tắc hiện hành. Kết quả trên chứng minh cấu trúc danh mục và các tình huống thực sự đã chạy, **không phải PASS cho toàn bộ quy tắc trên một bài báo**, cũng không phải validator tự động.

## Đồng bộ khi xuất bản lên GitHub

- Baseline GitHub: [c00d465](https://github.com/trungvjm/skills/commit/c00d4657ee9d6f0c470443b86d595a41323f2bce). Giữ bổ sung upstream về vị trí sử dụng shortauth/headershort, table-format, ô S không phải số và xltabular; không lấy bản cài cũ ghi đè.
- Cấp thêm TAB-011–019, giữ nguyên mã cũ. Danh mục hiện hành có **134 mã / 14 nhóm**: 118 MUST, 8 SHOULD, 8 MAY. Đã kiểm tra tính duy nhất, dải số, tham chiếu và liên kết.
- Smoke phần ghép bằng template Anh tháng 12 và template Việt đã dùng cho TESD: mỗi fixture có 80 hàng/tám cột, bảng dài trải bốn trang, caption chỉ xuất hiện một lần, header lặp đủ tám cột, không mất/lặp hàng; footer giữa mảnh, footer cuối đậm. Thêm một trang kiểm tra cột S chứa số âm, dấu gạch thiếu dữ liệu và N/A.
- Mỗi fixture sinh PDF năm trang sau ba lần pdflatex; không lỗi compile, undefined reference, overfull hoặc ký tự thiếu. Đã xem PDF: ở cột S, dấu thập phân Anh là chấm, Việt là phẩy; ô không phải số hiển thị đúng.
- Fixture được dọn sau kiểm tra; không đưa PDF thử, dữ liệu bài báo, metadata cài đặt hoặc thông tin xác thực vào commit.
