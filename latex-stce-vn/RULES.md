# Danh mục quy tắc latex-stce-vn

Mỗi dòng dưới đây định nghĩa một mã duy nhất. Đây là danh mục kiểm tra cho `SKILL.md`, không phải bộ kiểm tra tự động đã được triển khai.

- Tiền tố: `STCE-VN-<NHÓM>-<SỐ>`. Không đổi mã khi sửa câu chữ; không tái sử dụng mã đã bỏ.
- Mức: **MUST** = bắt buộc; **SHOULD** = khuyến nghị/mặc định của skill; **MAY** = tùy chọn có điều kiện.
- Kiểm chứng: **SRC** = đọc mã nguồn; **DIFF** = đối chiếu bản gốc; **PDF** = xem PDF; **BUILD** = biên dịch/log; **MANUAL** = đánh giá thủ công. Một kiểm tra có thể cần nhiều phương thức.
- Nguồn § là mục trong `SKILL.before-rule-ids.md` (bản chụp 564 dòng trước khi đánh mã). Khi một yêu cầu lặp lại ở checklist hoặc bảng tổng hợp, dùng cùng mã, không tạo quy tắc thứ hai.
- `GH` là hướng dẫn đã có tại [trungvjm/skills c00d465](https://github.com/trungvjm/skills/commit/c00d4657ee9d6f0c470443b86d595a41323f2bce), được giữ khi ghép lên GitHub; không lấy bản cài cũ ghi đè các bổ sung đó.
- Mã `Cxx` là hồ sơ đối chiếu lịch sử trong CONFLICTS.md, không tự có nghĩa là đang mâu thuẫn. C01/C02/C03/C04/C07/C10/C11/C16 đã được người dùng chốt; áp dụng quyết định hiện hành, không hỏi lại. C14 là lỗi mô tả kỹ thuật về macro, không phải lựa chọn ngôn ngữ Việt/Anh.
- Các chuẩn hóa biên tập đã được phép: tiêu đề tiếng Việt Sentence case, cộng sự → cs., viết hoa đầu subcaption và bỏ dấu chấm cuối caption. Không thay đổi nội dung khoa học; abstract nhiều đoạn phải giữ nguyên và báo người dùng.
- Trong báo cáo kiểm tra, ghi mã đầy đủ, trạng thái `PASS`/`FAIL`/`N/A`/`BLOCKED`, vị trí và bằng chứng. `N/A` phải có lý do; chưa kiểm chứng không phải `PASS`. Quy tắc còn mâu thuẫn có ảnh hưởng thì ghi `BLOCKED`.

## CORE — Phạm vi và bảo toàn nội dung

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-CORE-001 | MUST | Chỉ áp dụng skill này cho bài tiếng Việt; bài tiếng Anh dùng latex-stce-en. | Mở đầu | SRC |
| STCE-VN-CORE-002 | MUST | Giữ nguyên mọi giá trị số trong văn bản, bảng và phương trình. | Tối thượng; §0 | DIFF |
| STCE-VN-CORE-003 | MUST | Giữ nguyên ý nghĩa và nhận dạng ký hiệu toán học, gồm hoa/thường, chỉ số dưới/trên, dấu mũ, gạch trên và biến. | Tối thượng; §9.1 | DIFF, PDF |
| STCE-VN-CORE-004 | MUST | Không rút gọn, đơn giản hóa hoặc thay biến của công thức/phương trình. | Tối thượng | DIFF, PDF |
| STCE-VN-CORE-005 | MUST | Không viết lại câu, thay từ hoặc thêm/bớt ý; chỉ chuẩn hóa cách viết hoa/viết tắt/dấu câu đã được xác nhận tại FRONT-003, TXT-001, FIG-012, FIG-013 và TAB-013. | Tối thượng; §0; C01/C03 đã chốt | DIFF |
| STCE-VN-CORE-006 | MUST | Giữ nguyên thứ tự nội dung, thứ tự đoạn và ranh giới các đoạn; không tự gộp/tách đoạn. | Tối thượng; §0; §3.4 | DIFF |
| STCE-VN-CORE-007 | MUST | Giữ nguyên nội dung caption; viết hoa đầu subcaption và bỏ dấu chấm cuối caption theo FIG-012, FIG-013, TAB-013 là ngoại lệ biên tập đã được người dùng duyệt. | Tối thượng; §5.5; §6.3; C03 đã chốt | DIFF |
| STCE-VN-CORE-008 | MUST | Chỉ thay đổi cách biểu diễn LaTeX, template, citation, spacing và các chuẩn hóa biên tập được phép. | Tối thượng; §0 | DIFF |
| STCE-VN-CORE-009 | MUST | Không đoán ký hiệu thiếu, số khác thường, công thức hỏng hay lỗi copy-paste; báo người dùng và hỏi khi chưa xác định được nội dung đúng. | Tối thượng; §0; §9.1 | DIFF, MANUAL |
| STCE-VN-CORE-010 | MUST | Không rút gọn tên cột hoặc nội dung header bảng. | §0 | DIFF |
| STCE-VN-CORE-011 | MUST | Không bỏ thành phần tên/tên viết tắt tác giả có trong nguồn. | §0 | DIFF |
| STCE-VN-CORE-012 | MUST | Không tự bổ sung nội dung hay metadata còn thiếu. | §0 | DIFF |
| STCE-VN-CORE-013 | MUST | Không tự đổi ký hiệu/viết tắt có thể làm đổi nghĩa, ví dụ không suy `410` thành phi10. | §0 | DIFF |
| STCE-VN-CORE-014 | MUST | Không rút gọn hoặc dịch đơn vị làm khác bản gốc. | §0; §4.3 | DIFF, PDF |

## BACKUP — Sao lưu và báo cáo thay đổi

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-BACKUP-001 | MUST | Trước khi chuẩn hóa file .tex/.bib có sẵn, tạo bản sao cùng thư mục mang hậu tố `_original`. | §0 | SRC |
| STCE-VN-BACKUP-002 | MUST | Không ghi đè bản `_original` đã có. | §9.1 | SRC |
| STCE-VN-BACKUP-003 | MUST | Chỉ xóa bản sao lưu sau khi người dùng xác nhận đã kiểm tra xong. | §0 | MANUAL |
| STCE-VN-BACKUP-004 | MUST | Báo cáo đầy đủ mọi thay đổi đã thực hiện, không sửa âm thầm. | §0; §9.1 | DIFF |
| STCE-VN-BACKUP-005 | MUST | Mỗi thay đổi phải có file, vị trí dòng gốc/dòng mới, nội dung trước/sau và lý do. | §0; §9.1 | DIFF |

## TPL — Template và cấu trúc tài liệu

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-TPL-001 | SHOULD | Mẫu mặc định được chỉ tên là `01_3330_Dinh Van Thuat.tex`; ghi nhận mẫu thực tế được người dùng chỉ định nếu khác. | Mở đầu; C13 | MANUAL |
| STCE-VN-TPL-002 | MUST | Dùng documentclass `\documentclass[3p,times,11pt]{STCE/stce}`. | §1 | SRC, BUILD |
| STCE-VN-TPL-003 | MUST | Nạp `\usepackage{STCE/stce_proof}`; không đồng thời tự kích hoạt package thay thế từ dòng comment trong ví dụ. | §1; §9 bước 1; C05 | SRC, BUILD |
| STCE-VN-TPL-004 | MUST | Nạp `\input{STCE/stce_package}`. | §1 | SRC, BUILD |
| STCE-VN-TPL-005 | MUST | Chọn đúng một trạng thái proof phù hợp, uncorrectedproof hoặc correctedproof. | §1; §9.1 | SRC, PDF |
| STCE-VN-TPL-006 | MUST | Khai báo/kiểm tra volume, firstpage và copyrightyear đúng metadata đã được cung cấp; không đoán giá trị thiếu. | §1; §9.1; CORE-012 | SRC, DIFF |
| STCE-VN-TPL-007 | MUST | Khai báo mã bài bằng `\newcommand\id{...}`. | §1 | SRC |
| STCE-VN-TPL-008 | MUST | Giữ trật tự: preamble → document → frontmatter → nội dung → bibliography → end document. | §1 | SRC |
| STCE-VN-TPL-009 | MUST | Dùng `\bibliographystyle{STCE/stce}`. | §1; §7.2 | SRC, BUILD |
| STCE-VN-TPL-010 | MUST | File kết thúc bằng `\end{document}`. | §1; §9 bước 8 | SRC, BUILD |

## FRONT — Frontmatter và metadata

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-FRONT-001 | MUST | Kiểm tra thứ tự: DOI → title → authors → cortext/shortauth/mailauth/headershort → addresses → dates → abstract → keyword block. | §2 | SRC |
| STCE-VN-FRONT-002 | MUST | Khi DOI đã có, biểu diễn bằng `\doi{https://doi.org/10.31814/stce.huceYYYY-VV(NV)-xx}` với thông tin kỳ đúng, kể cả hậu tố V. | §2.1; CORE-012 | DIFF, SRC |
| STCE-VN-FRONT-003 | MUST | Tiêu đề tiếng Việt dùng Sentence case: viết hoa chữ đầu, giữ hoa đúng tên riêng/từ viết tắt; không HOA toàn bộ. | §2.2; C01 người dùng đã chốt | SRC, PDF |
| STCE-VN-FRONT-005 | MUST | Gán label tác giả [a], [b]... khớp label address tương ứng. | §2.3 | SRC, DIFF |
| STCE-VN-FRONT-006 | MUST | Tác giả liên hệ có `\corref{cor1}`. | §2.3–2.4 | SRC, DIFF |
| STCE-VN-FRONT-007 | MUST | Giữ thứ tự tên Việt Nam Họ Đệm Tên. | §2.3 | DIFF |
| STCE-VN-FRONT-008 | MUST | Cortext dùng `Tác giả đại diện. \textit{Địa chỉ e-mail:}`. | §2.4 | SRC, PDF |
| STCE-VN-FRONT-009 | MUST | `\shortauth` là tên viết tắt của tác giả liên hệ; `\mailauth` là email của tác giả đó. | §2.4 | DIFF |
| STCE-VN-FRONT-010 | MUST | Với một tác giả, headershort ghi tên viết tắt người đó. | §2.4 | SRC, DIFF |
| STCE-VN-FRONT-011 | MUST | Với hai tác giả, headershort ghi đủ tên viết tắt cả hai theo thứ tự. | §2.4 | SRC, DIFF |
| STCE-VN-FRONT-012 | MUST | Từ ba tác giả trở lên, headershort dùng tên viết tắt tác giả đầu tiên + `và cs.`; không lấy tác giả liên hệ thay thế. | §2.4; C02 người dùng đã chốt | SRC, DIFF |
| STCE-VN-FRONT-014 | MUST | Tên viết tắt tiếng Việt theo dạng `Tên, Họ viết tắt. Đệm viết tắt.`, giữ đúng Đ/D. | §2.4 | DIFF |
| STCE-VN-FRONT-015 | MUST | Address trình bày bằng tiếng Việt, giữ nguyên nội dung nguồn. | §2.5 | DIFF |
| STCE-VN-FRONT-016 | MAY | Ngắt address dài bằng `\\` khi cần bố cục. | §2.5 | PDF |
| STCE-VN-FRONT-017 | MUST | `\received` chứa lần lượt ngày nhận, sửa và chấp nhận. | §2.6 | DIFF |
| STCE-VN-FRONT-018 | MUST | Tháng 1–2 viết 01–02, tháng 3–9 không thêm 0, tháng 10–12 giữ hai chữ số; không đổi ngày thực tế. | §2.6 | SRC, DIFF |
| STCE-VN-FRONT-019 | MUST | Abstract tiếng Việt thường là một paragraph; nếu nguồn có nhiều đoạn, giữ nguyên, báo số đoạn/vị trí cho người dùng và chờ quyết định, không tự gộp/cắt/viết lại. | §2.7; C04 người dùng đã chốt | SRC, DIFF, MANUAL |
| STCE-VN-FRONT-020 | MUST | Keywords tiếng Việt ngăn bằng `;`, kết thúc bằng `.`. | §2.8 | SRC |
| STCE-VN-FRONT-021 | MUST | Keyword block song ngữ giữ thứ tự keywords Việt → TD → ABS → KW → CR. | §2.8 | SRC |
| STCE-VN-FRONT-022 | MUST | Tiêu đề tiếng Anh sau `\TD` viết HOA. | §2.8 | SRC, PDF |
| STCE-VN-FRONT-023 | MUST | Abstract tiếng Anh đặt trong otherlanguage{english}; nếu nguồn có nhiều đoạn, giữ nguyên, báo số đoạn/vị trí cho người dùng và chờ quyết định, không tự gộp/cắt/viết lại. | §2.8; C04 người dùng đã chốt | SRC, DIFF, MANUAL |
| STCE-VN-FRONT-024 | MUST | Keywords tiếng Anh ngăn bằng `;`, kết thúc bằng `.`. | §2.8 | SRC |
| STCE-VN-FRONT-025 | MUST | `\CR` đứng riêng một dòng trước `\end{keyword}`. | §2.8 | SRC |

## SEC — Sections và paragraph

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-SEC-001 | MUST | Dùng hierarchy section → subsection → subsubsection; không dùng paragraph/subparagraph. | §3.1 | SRC |
| STCE-VN-SEC-002 | SHOULD | Mục đầu thường là Giới thiệu, mục cuối thường là Kết luận; không tự đổi nội dung heading chỉ để khớp tên thường dùng. | §3.1–3.2; CORE-005 | DIFF |
| STCE-VN-SEC-003 | MUST | Chỉ thêm Lời cảm ơn nếu nguồn có; trình bày bằng section không đánh số. | §1; §3.1 | SRC, DIFF |
| STCE-VN-SEC-004 | MUST | Để class tự đánh số subsubsection a., b., c.; chuyển heading giả bằng bold/italic sang lệnh heading thật. | §3.3 | SRC, PDF |
| STCE-VN-SEC-005 | SHOULD | Giữ kiểu in nghiêng của subsubsection do class xử lý. | §3.3 | PDF |
| STCE-VN-SEC-006 | MUST | Giữa hai paragraph nội dung độc lập có đúng một dòng trống; không gộp hai đoạn trên một dòng hay chỉ xuống dòng một lần. | §3.4; §9.1 | SRC, DIFF |
| STCE-VN-SEC-007 | SHOULD | Trước section có hai dòng trống. | §3.4 | SRC |
| STCE-VN-SEC-008 | SHOULD | Trước subsection và subsubsection có một dòng trống. | §3.4 | SRC |
| STCE-VN-SEC-009 | MUST | Không có dòng trống thừa giữa heading và paragraph đầu tiên. | §3.4 | SRC |
| STCE-VN-SEC-010 | MUST | Rà paragraph spacing trên toàn bộ nội dung sau frontmatter, trước bibliography; báo cáo riêng kết quả. | §3.4 | SRC |

## EQ — Phương trình

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-EQ-001 | MUST | Display equation dùng môi trường equation; giữ nguyên công thức nguồn. | §4.1 | SRC, DIFF |
| STCE-VN-EQ-002 | MUST | Khi cần label để tham chiếu phương trình, dùng chuỗi số `1`, `2`, `3` theo quy định tại §4.1. | §4.1 | SRC |
| STCE-VN-EQ-003 | MUST | Nhiều biểu thức độc lập cùng dòng ngăn bằng `;\quad`; không áp dụng vào dấu phân cách nội bộ vector, max, cases hoặc cấu trúc toán khác. | §4.1; §9.1 | DIFF, PDF |
| STCE-VN-EQ-004 | MUST | Không có dấu câu kết thúc display equation. | §4.1 | SRC, PDF |
| STCE-VN-EQ-005 | MUST | Không có dòng trống ngay trước môi trường equation; áp dụng cho toàn bộ file. | §9.1; người dùng xác nhận | SRC |
| STCE-VN-EQ-006 | MUST | Sau equation có đúng một dòng trống nếu đoạn tiếp theo bắt đầu chữ hoa; không có dòng trống nếu phần tiếp theo bắt đầu chữ thường. | §9.1 | SRC, DIFF |
| STCE-VN-EQ-007 | MAY | Không bắt buộc thêm dòng `%` quanh equation; nếu nguồn có thì giữ. Dòng comment không được coi là paragraph mới. | §4.1 | SRC |
| STCE-VN-EQ-008 | MUST | Các biến, toán tử, hàm, số mũ/chỉ số, ký hiệu Hy Lạp và đơn vị dạng toán học nằm trong math mode, kể cả khi đứng riêng trong câu. | §4.2 | SRC, PDF |
| STCE-VN-EQ-009 | SHOULD | Dùng `$...$` cho biểu thức inline ngắn. | §4.2 | SRC |
| STCE-VN-EQ-010 | SHOULD | Đặt phần mô tả biến ngay sau equation bằng cấu trúc `trong đó ...`; không tự thêm định nghĩa còn thiếu. | §4.2; CORE-012 | DIFF |

## UNIT — Đơn vị

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-UNIT-001 | MUST | Đơn vị thông thường dùng math mode, mathrm và slash thủ công đúng nguồn; checklist cũng kiểm tra cách này, không bắt buộc siunitx cho mọi đơn vị. | §4.3; §9.1; C07 người dùng đã chốt | SRC, DIFF, PDF |
| STCE-VN-UNIT-003 | SHOULD | Dùng siunitx khi cần prefix/ký hiệu đặc biệt như micro. | §4.3 | SRC, PDF |
| STCE-VN-UNIT-004 | MUST | Giữ cách viết, ký hiệu, ngôn ngữ và dấu phân cách đơn vị theo nguồn khi chúng rõ nghĩa. | §4.3 | DIFF, PDF |
| STCE-VN-UNIT-005 | MUST | Không đặt `per-mode` toàn cục nếu chưa có yêu cầu rõ và chưa kiểm tra mọi đơn vị ghép. | §4.3 | SRC, MANUAL |
| STCE-VN-UNIT-006 | SHOULD | Mẫu số không phải đơn vị SI dùng slash thủ công, giữ nguyên từ gốc. | §4.3 | SRC, PDF |
| STCE-VN-UNIT-007 | MUST | Với nhiều mẫu số, giữ biểu diễn thủ công và dấu phân cách rõ nghĩa của nguồn; không bắt buộc dùng một si chứa nhiều per. Từ tiếng Việt trong đơn vị dùng text, không đặt trong mathrm. | §4.3; C07 người dùng đã chốt | SRC, DIFF, PDF |
| STCE-VN-UNIT-008 | MUST | Không trộn slash sinh bởi per với slash gõ tay theo cách gây mơ hồ; xem C08 về ngoại lệ từ tiếng Việt ngoài siunitx. | §4.3; C08 | SRC, PDF |
| STCE-VN-UNIT-009 | MUST | Khi si đứng sau số, có `~` trước si; SI tự xử lý khoảng cách số–đơn vị. | §4.3 | SRC |
| STCE-VN-UNIT-010 | MUST | Không viết dính số–đơn vị; dùng khoảng cách không ngắt dòng theo cách biểu diễn đã chọn. | §4.3 | SRC, PDF |
| STCE-VN-UNIT-011 | MUST | Không dịch người/giờ/năm/vòng thành person/hour/year/revolution khi người dùng chưa yêu cầu. | §4.3 | DIFF, PDF |
| STCE-VN-UNIT-012 | MUST | Với đơn vị tùy chỉnh, đọc khai báo DeclareSIUnit và kiểm tra nội dung thực sự hiển thị; tên macro không quyết định ngôn ngữ. | §4.3 | SRC, PDF |
| STCE-VN-UNIT-013 | MUST | Đối chiếu mọi đơn vị với nguồn và kiểm tra PDF; nếu không rõ hoặc dự kiến khác cách hiển thị thì hỏi trước khi đổi. | §4.3 | DIFF, PDF |

## TXT — Chữ, ký tự và cách viết

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-TXT-001 | MUST | Chuẩn hóa `và cộng sự`/`cùng cộng sự` thành `và cs.` trong phần nội dung; không sửa tên riêng hay nhan đề được trích nguyên văn chỉ vì có cùng chuỗi chữ. | §9.1; người dùng xác nhận; C03 | SRC, DIFF |
| STCE-VN-TXT-002 | MUST | En-dash trong text dùng `--`. | §4.3–4.4 | SRC, PDF |
| STCE-VN-TXT-003 | MUST | Biểu diễn công thức hóa học bằng ce, không dùng subscript/superscript thủ công. | §0; §4.3 | SRC, DIFF, PDF |
| STCE-VN-TXT-004 | MUST | Tên khoa học loài/chi/họ in nghiêng bằng textit. | §4.3 | SRC, PDF |
| STCE-VN-TXT-005 | MUST | Số thập phân trong phần tiếng Việt dùng dấu phẩy; giữ giá trị, không áp dụng đổi dấu cho abstract tiếng Anh hoặc chuỗi định danh/DOI. | §4.3; phạm vi C10 đã làm rõ | SRC, DIFF |
| STCE-VN-TXT-006 | MUST | Dấu phẩy thập phân trong math mode dùng `{,}`, không dùng dấu phẩy trần hoặc chèn khoảng trắng âm để thay thế; không đổi dấu phân cách vector/danh sách hoặc dấu phẩy giữa key cite thành dấu thập phân. | §4.3; C10 người dùng đã chốt | SRC, DIFF, PDF |
| STCE-VN-TXT-007 | MUST | Dấu phần trăm dùng `\%`. | §4.3 | SRC, PDF |
| STCE-VN-TXT-008 | MUST | Ngoặc kép trong text dùng hai grave accent mở và hai apostrophe đóng, không giữ dấu ASCII kép hoặc smart double quote. | §4.3–4.4 | SRC, PDF |
| STCE-VN-TXT-009 | MUST | Smart single quote chuyển sang grave accent/apostrophe tương ứng; phân biệt dấu prime toán học với dấu nháy văn bản. | §4.4; CORE-003 | SRC, DIFF |
| STCE-VN-TXT-010 | MUST | Thay Unicode toán/ký hiệu được liệt kê bằng lệnh LaTeX tương ứng: nhân, độ, trừ, dash, bất đẳng thức, cộng trừ, xấp xỉ, vô cùng, mũi tên, Hy Lạp, mũ/chỉ số. Không xóa Unicode tiếng Việt; xem C09. | §4.4; C09 | SRC, DIFF, PDF |
| STCE-VN-TXT-011 | MAY | Chuẩn hóa khoảng cách typo như `stress- strain` thành `stress-strain` khi không đổi từ hay ý nghĩa. | §0 | DIFF |

## FIG — Hình và chú thích

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-FIG-001 | MUST | Đường dẫn hình theo `Figures/\id/FN`, dùng id bài và số thứ tự. | §5.1; §5.5 | SRC |
| STCE-VN-FIG-002 | MUST | Label hình theo `f1`, `f2`, ... | §5.5 | SRC |
| STCE-VN-FIG-003 | MUST | Tham chiếu hình bằng `Hình~\ref{fN}`, không dùng Fig. trong phần tiếng Việt. | §5.5; §8 | SRC, PDF |
| STCE-VN-FIG-004 | MUST | Tham chiếu panel có ngoặc: `Hình~\ref{fN}(a)`, không viết hậu tố a trần. | §5.5 | SRC |
| STCE-VN-FIG-005 | MUST | Float hình dùng placement `[ht!]`. | §5.5 | SRC |
| STCE-VN-FIG-006 | SHOULD | Hình đơn dùng figure và căn giữa; kích thước tham khảo `.7\textwidth`. | §5.1; §5.5 | SRC, PDF |
| STCE-VN-FIG-007 | SHOULD | Với subfigure cần đồng đều chiều cao, ưu tiên tham số height; kích thước tham khảo `0.38\textwidth`. | §5.2; §5.5 | PDF |
| STCE-VN-FIG-008 | SHOULD | Dùng hfill giữa các panel để căn hai bên; có thể dùng qquad khi cần khoảng cách cố định. | §5.2 | SRC, PDF |
| STCE-VN-FIG-009 | MUST | Giữ dòng comment `%\qquad` trong nhóm subfigure để có thể thay hfill. | §5.2; §5.5 | SRC |
| STCE-VN-FIG-010 | SHOULD | Hai hình cùng hàng có caption/label riêng dùng các minipage riêng, không giả thành các panel dùng chung caption. | §5.3 | SRC, PDF |
| STCE-VN-FIG-011 | MAY | Dùng wrapfigure theo ví dụ khi cần hình quấn chữ; kiểm tra bố cục thực tế. | §5.4 | PDF |
| STCE-VN-FIG-012 | MUST | Viết hoa chữ cái đầu nội dung mỗi subcaption; không đổi nhãn panel (a), (b) thành (A), (B), không Title Case toàn bộ câu. | Người dùng xác nhận trong phiên; thiếu trong bản cũ | SRC, DIFF, PDF |
| STCE-VN-FIG-013 | MUST | Bỏ dấu chấm kết thúc caption hình và subcaption, giữ nguyên nội dung còn lại; đây là ngoại lệ biên tập được phép. | §5.5; C03 người dùng đã chốt | SRC, DIFF, PDF |
| STCE-VN-FIG-014 | MUST | Mọi tệp hình phải tồn tại, mở/giải mã được và xuất hiện đúng trên PDF. | §9.1 | SRC, PDF |

## TAB — Bảng

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-TAB-001 | MUST | Bảng một trang dùng tabularx với textwidth; bảng dài nhiều trang dùng xltabular trực tiếp theo template và hướng dẫn bảng dài. | §6.3; GH §6.4 | SRC, PDF |
| STCE-VN-TAB-002 | MUST | Dùng top/mid/bottomrule theo booktabs; không dùng hline. Chỉ dùng ML khi đã đọc định nghĩa thực tế và xác nhận đúng vai trò. Không phân loại các lệnh đường kẻ theo ngôn ngữ Việt/Anh. | §6.3; C14 đã đồng bộ kỹ thuật | SRC, BUILD |
| STCE-VN-TAB-003 | MUST | Header bảng dùng lll theo mẫu; rrr là gộp hàng, p là phantom, không phải lệnh thay thế header hay midrule. Chỉ dùng macro có định nghĩa phù hợp trong template, không chia chúng thành nhóm Việt/Anh. | §6.2; §10; C14 đã đồng bộ kỹ thuật | SRC, PDF |
| STCE-VN-TAB-004 | MUST | Label bảng theo `t1`, `t2`, ... | §6.3 | SRC |
| STCE-VN-TAB-005 | MUST | Tham chiếu bằng `Bảng~\ref{tN}`, không dùng Table trong phần tiếng Việt. | §6.3; §8 | SRC, PDF |
| STCE-VN-TAB-006 | MUST | Bảng một trang có caption trước tabularx; bảng dài có caption/label ở đầu xltabular theo TAB-019. | §6.3; GH §6.4 | SRC, PDF |
| STCE-VN-TAB-007 | MAY | Điều chỉnh tabcolsep để dàn cột. | §6.3 | PDF |
| STCE-VN-TAB-008 | MUST | Với bảng một trang, hàng cuối kết thúc bằng hai backslash trước bottomrule/end tabularx; không thêm hàng trắng. Bảng dài dùng footer riêng ở TAB-021–022. | §6.3; GH §6.4 | SRC, PDF |
| STCE-VN-TAB-009 | MUST | Float bảng một trang dùng [ht!]; xltabular không bọc float. | §6.3; GH §6.4 | SRC |
| STCE-VN-TAB-010 | MUST | Không chèn padding/khoảng trắng thừa chỉ để căn các cột trong mã; giữ mã compact. | §6.3 | SRC |
| STCE-VN-TAB-011 | SHOULD | Khi cần căn số theo dấu thập phân, dùng cột S; header cột S bọc trong ngoặc nhọn. | §6.3 | SRC, PDF |
| STCE-VN-TAB-012 | MUST | Giữ các dòng comment tabcolsep, fontsize, arraystretch và vspace trong mỗi bảng. | §6.3 | SRC |
| STCE-VN-TAB-013 | MUST | Bỏ dấu chấm kết thúc caption bảng, giữ nguyên nội dung còn lại; đây là ngoại lệ biên tập được phép. | §6.3; C03 người dùng đã chốt | SRC, DIFF, PDF |
| STCE-VN-TAB-014 | MUST | Khai báo số cột và kiểu cột theo từng bảng thực tế của bài; header và mọi hàng phải khớp số cột hiệu dụng, có tính các ô gộp multicolumn. Không mặc định số cột từ ví dụ/template. | §6.1; C16 người dùng đã chốt | SRC, DIFF, PDF |
| STCE-VN-TAB-015 | MAY | Dùng S[table-format=M.N] để dự trù số chữ số phần nguyên/thập phân; M.N là cú pháp cấu hình, không đổi quy tắc dấu phẩy của dữ liệu tiếng Việt. | GH §6.3 | SRC, PDF |
| STCE-VN-TAB-016 | MUST | Trong cột S, header/ô không phải số bọc ngoặc nhọn hoặc multicolumn phù hợp; dấu gạch ngang biểu thị thiếu dữ liệu viết {-}. | GH §6.3 | SRC, BUILD, PDF |
| STCE-VN-TAB-017 | MUST | Nạp package xltabular trong preamble khi dùng bảng dài nhiều trang. | GH §6.4 | SRC, BUILD |
| STCE-VN-TAB-018 | MUST | Đặt xltabular trực tiếp, không bọc trong float table. | GH §6.4 | SRC, PDF |
| STCE-VN-TAB-019 | MUST | Caption/label ở đầu xltabular; hàng caption kết thúc bằng hai backslash. | GH §6.4 | SRC, BUILD, PDF |
| STCE-VN-TAB-020 | MUST | Trang sau không lặp caption hay thêm Bảng tiếp theo; chỉ lặp header cột giữa top/midrule trước endhead. | GH §6.4 | SRC, PDF |
| STCE-VN-TAB-021 | MUST | Footer các trang chưa cuối dùng midrule trước endfoot. | GH §6.4 | SRC, PDF |
| STCE-VN-TAB-022 | MUST | Footer trang cuối dùng bottomrule trước endlastfoot. | GH §6.4 | SRC, PDF |
| STCE-VN-TAB-023 | SHOULD | Ưu tiên X co giãn hoặc *N{>{centering arraybackslash}X}, tổng rộng theo textwidth; số cột theo dữ liệu thực tế. | GH §6.4; C16 | SRC, PDF |

## REF — Trích dẫn và bibliography

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-REF-001 | MUST | Chuyển số trích dẫn trong nội dung thành lệnh cite với đúng key, không đổi tài liệu được trích. | §0; §7.1 | SRC, DIFF |
| STCE-VN-REF-002 | MUST | Các trích dẫn liền nhau phải gộp vào một lệnh cite, ví dụ `[2], [3], [4]` → `\cite{2, 3, 4}`; không để `\cite{2}, ~\cite{3}`. Giữ nguyên key và thứ tự key. | §7.1; người dùng chốt gộp cite | SRC, DIFF |
| STCE-VN-REF-003 | MUST | Dấu `~` đứng liền chữ trước cite/ref/tham chiếu phương trình (`text~\cite{N}`), không có dấu cách hoặc xuống dòng trước `~`. | §4.3; §7.1 | SRC, PDF |
| STCE-VN-REF-004 | MUST | Số key trong cite phải tồn tại trong BibTeX và tương ứng tài liệu nguồn. | §7.1; §9.1 | SRC, DIFF, BUILD |
| STCE-VN-REF-005 | MUST | Trong lệnh cite nhiều key, đặt đúng một dấu cách sau mỗi dấu phẩy, không có khoảng trắng trước dấu phẩy, ví dụ `\cite{1, 2, 3}`. Chuẩn hóa spacing dù nguồn dùng kiểu khác; giữ nguyên key và thứ tự key. | §0; §7.1; C11 người dùng đã chốt | SRC, DIFF |
| STCE-VN-REF-006 | MUST | Đặt .bib trong thư mục Bib, tên file trùng id bài, bibliography trỏ đúng file đó. | §1; §7.2 | SRC, BUILD |
| STCE-VN-REF-007 | MUST | Tham chiếu mục bằng `Mục~\ref{...}` trong phần tiếng Việt. | §8 | SRC, PDF |
| STCE-VN-REF-008 | MAY | Tham chiếu phương trình bằng số trong ngoặc hoặc diễn đạt tự nhiên; không bắt buộc viết tắt Eq. | §8 | SRC, PDF |
| STCE-VN-REF-009 | MUST | Mọi tham chiếu label phải phân giải được sau khi biên dịch ổn định. | §9.1 | SRC, BUILD |

## QA — Bằng chứng và bàn giao

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-QA-001 | MUST | Đọc và đối chiếu toàn bộ nguồn/bản đã chuẩn hóa theo khối, gồm frontmatter, đoạn văn, caption, bảng, phương trình, citation và bibliography. | §9.1 | DIFF |
| STCE-VN-QA-002 | MUST | Ghi rõ mọi nội dung thêm/bỏ/đổi nghĩa; không kết luận đạt nếu còn thay đổi chưa được chấp thuận. | §9.1 | DIFF, MANUAL |
| STCE-VN-QA-003 | MUST | Kiểm tra tính nhất quán của từng ký hiệu trên toàn bài, bảng, hình, caption và tham chiếu. | §9.1 | DIFF, PDF |
| STCE-VN-QA-004 | MUST | Chạy chu trình LaTeX/BibTeX phù hợp và LaTeX đủ lần để cross-reference ổn định, có PDF thực. | §9.1 | BUILD |
| STCE-VN-QA-005 | MUST | Không báo hoàn tất khi có lỗi biên dịch hoặc undefined citation/reference. | §9.1 | BUILD |
| STCE-VN-QA-006 | MUST | Nếu AGY khả dụng hoặc được yêu cầu, chạy đối soát độc lập sau cùng và xử lý các phát hiện có căn cứ. | §9.1 | MANUAL |
| STCE-VN-QA-007 | MUST | Rà overfull/underfull, missing image/font, hyperref và BibTeX; sửa lỗi format hoặc ghi rõ cảnh báo còn lại. | §9.1 | BUILD, PDF |
| STCE-VN-QA-008 | MUST | Báo cáo file đầu ra, số trang PDF, trạng thái compile, lỗi/cảnh báo và thay đổi format chính. | §9.1 | SRC, BUILD, PDF |
| STCE-VN-QA-009 | MUST | Không lấy compile thành công hoặc nhận xét chung của reviewer làm bằng chứng thay cho kiểm tra từng quy tắc. | Cơ chế kiểm tra được người dùng yêu cầu trong phiên | MANUAL |
| STCE-VN-QA-010 | MUST | Chỉ ghi PASS cho quy tắc đã kiểm chứng trên phiên bản đầu ra hiện tại; phải chỉ ra vị trí/bằng chứng. | Cơ chế kiểm tra được người dùng yêu cầu trong phiên | MANUAL |

## WORK — Cách thực hiện

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-VN-WORK-001 | MUST | Thực hiện từng bước thay vì chuẩn hóa một lần không kiểm soát. | Lưu ý cuối §9 | MANUAL |
| STCE-VN-WORK-002 | MUST | Chỉ commit khi môi trường có Git và người dùng/quy trình cho phép; yêu cầu commit mọi nhóm thay đổi trong bản cũ chưa có điều kiện, xem C15. | Lưu ý cuối §9; C15 | MANUAL |
| STCE-VN-WORK-003 | MUST | Biên dịch sau mỗi nhóm thay đổi lớn và kiểm chứng đầu ra cuối. | Lưu ý cuối §9 | BUILD |
| STCE-VN-WORK-004 | MUST | Với file trên 500 dòng, làm incremental theo khối để kiểm soát sai khác. | Lưu ý cuối §9 | MANUAL |
| STCE-VN-WORK-005 | MUST | Đọc trực tiếp đầy đủ nội dung để đối chiếu; tìm kiếm chỉ hỗ trợ định vị, không thay việc đọc. Bản cũ cấm grep tuyệt đối và gọi tên tool không tồn tại; xem C12. | Lưu ý cuối §9; C12 | MANUAL |
| STCE-VN-WORK-006 | MUST | Sửa bằng công cụ chỉnh sửa trực tiếp; không dùng script replace hàng loạt để thay nội dung bản thảo. | Lưu ý cuối §9 | MANUAL |

## Liên kết checklist cũ → nhóm mã

| Checklist §9.1 | Mã áp dụng |
|---|---|
| Backup | BACKUP-001–003 |
| Đối chiếu nội dung gốc | CORE-002–014; QA-001–002 |
| Preamble/template | TPL-002–010; FRONT-001–025 |
| Math mode | EQ-008–010 |
| Đồng nhất ký hiệu | CORE-003; QA-003 |
| Đơn vị và số | UNIT-001–013; TXT-005–010 |
| Paragraph | CORE-006; SEC-006–010 |
| Cách viết tác giả | TXT-001; FRONT-009–014 |
| Khoảng cách quanh phương trình | EQ-005–007 |
| Nhiều biểu thức trong một phương trình | EQ-003 |
| Figures/tables | FIG-001–014; TAB-001–023 |
| Citations/references | REF-001–009; TPL-009 |
| Biên dịch | QA-004–005 |
| Kiểm tra chéo AGY | QA-006 |
| Warnings | QA-007 |
| Báo cáo | BACKUP-004–005; QA-008–010 |

Các dải mã viết tắt trong bảng này đều có tiền tố `STCE-VN-`. Chúng là tham chiếu, không phải định nghĩa mã mới. Nội dung STCE tiếng Anh trong bảng so sánh §10 chỉ để tham khảo; không tự biến thành quy tắc tiếng Việt.

## Mã ngừng áp dụng — không tái sử dụng

Các mã dưới đây chỉ là dấu vết lịch sử, không phải quy tắc kiểm tra đang áp dụng. Không đổi số các mã còn lại để lấp chỗ trống.

| Mã | Trạng thái | Lý do / quy tắc hiện hành |
|---|---|---|
| STCE-VN-FRONT-004 | RETIRED | Nhánh tiêu đề tiếng Việt HOA toàn bộ bị bỏ theo C01; áp dụng STCE-VN-FRONT-003. |
| STCE-VN-FRONT-013 | RETIRED | Nhánh headershort lấy tác giả liên hệ bị bỏ theo C02; áp dụng STCE-VN-FRONT-012. |
| STCE-VN-UNIT-002 | RETIRED | Checklist bắt buộc siunitx cho mọi đơn vị bị bỏ theo C07; áp dụng STCE-VN-UNIT-001. |
