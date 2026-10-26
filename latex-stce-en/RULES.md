# Danh mục quy tắc latex-stce-en

Mỗi dòng định nghĩa một mã duy nhất theo dạng `STCE-EN-<NHÓM>-<SỐ>`. Đây là danh mục kiểm tra, chưa phải validator/linter tự động.

- Mức: MUST = bắt buộc; SHOULD = khuyến nghị/mặc định; MAY = tùy chọn có điều kiện.
- Kiểm chứng: SRC = đọc mã nguồn; DIFF = đối chiếu nguồn gốc; PDF = xem PDF; BUILD = biên dịch/log; MANUAL = đánh giá thủ công.
- Nguồn § là mục trong `SKILL.before-rule-ids.md` (416 dòng). `DEC` là mẫu thực tế `Vol.20 No.4 - 12.2026/04-Papers`, gồm các bài .tex và STCE/stce.cls, stce.sty, stce_proof.sty, stce_package.tex.
- `GH` là nội dung đã có trên GitHub tại [c00d465](https://github.com/trungvjm/skills/commit/c00d4657ee9d6f0c470443b86d595a41323f2bce), được ghép khi xuất bản để không làm mất hướng dẫn mới hơn bản cài.
- Không đổi/tái sử dụng mã đã cấp. Một yêu cầu lặp lại ở phần hướng dẫn/checklist chỉ dùng cùng mã. Quy tắc tiếng Anh không dùng tiền tố STCE-VN.
- Các chuẩn hóa không phụ thuộc ngôn ngữ đã được người dùng chốt: khoảng trắng key cite, subcaption viết hoa chữ đầu, không dòng trống trước equation, số cột theo bảng thực tế, caption không có dấu chấm cuối. Giữ tiếng Anh dùng dấu chấm thập phân, et al., Fig., Table, Eq.; không chuyển sang quy ước tiếng Việt.
- `CONFLICTS.md` ghi bằng chứng và trạng thái, không phải danh sách câu hỏi mặc định. Người dùng đã chốt đơn vị tiếng Anh thủ công như tiếng Việt (EN-C10); hiện không còn quyết định biên tập đang chờ.
- Khi kiểm tra, ghi `mã | PASS/FAIL/N/A/BLOCKED | file:dòng hoặc trang PDF | bằng chứng`. N/A có lý do; chưa kiểm chứng không được PASS. Quyết định chưa có và ảnh hưởng tác vụ phải ghi BLOCKED, không đoán.

## CORE — Phạm vi và bảo toàn nội dung

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-CORE-001 | MUST | Áp dụng cho bài tiếng Anh; bài tiếng Việt dùng latex-stce-vn. | Mở đầu; phạm vi skill | SRC |
| STCE-EN-CORE-002 | MUST | Giữ nguyên mọi giá trị số trong văn bản, bảng và phương trình. | Tối thượng; §0 | DIFF |
| STCE-EN-CORE-003 | MUST | Giữ nguyên ký hiệu toán, nhận dạng biến, hoa/thường, chỉ số dưới/trên, dấu mũ/gạch trên; không đoán ký hiệu bị mất. | Tối thượng; §8.1 | DIFF, PDF |
| STCE-EN-CORE-004 | MUST | Không rút gọn, đơn giản hóa hay thay biến/công thức. | Tối thượng | DIFF, PDF |
| STCE-EN-CORE-005 | MUST | Không viết lại câu, thay từ hay thêm/bớt ý; chỉ thực hiện chuẩn hóa biểu diễn/biên tập được quy định, không đổi nghĩa. | Tối thượng; §0 | DIFF |
| STCE-EN-CORE-006 | MUST | Giữ thứ tự nội dung và ranh giới paragraph; không tự gộp/tách đoạn. | Tối thượng; §0; §3.3 | DIFF |
| STCE-EN-CORE-007 | MUST | Giữ nội dung caption; viết hoa đầu subcaption và bỏ dấu chấm kết thúc là chuẩn hóa biên tập, không được dùng làm lý do diễn giải caption. | Tối thượng; §5.5; §6.2; xác nhận chung | DIFF |
| STCE-EN-CORE-008 | MUST | Không rút gọn header bảng hoặc bỏ thành phần tên/tên viết tắt tác giả. | §0 | DIFF |
| STCE-EN-CORE-009 | MUST | Không bổ sung nội dung, metadata, ORCID hoặc ngày tháng chưa có bằng chứng. | §0; DEC | DIFF |
| STCE-EN-CORE-010 | MUST | Không suy `410` thành phi10 hoặc `300C` thành 30°C khi nguồn không xác nhận; báo người dùng nếu mơ hồ. | §0; EN-C05 | DIFF, MANUAL |
| STCE-EN-CORE-011 | MUST | Không rút gọn, dịch hoặc đổi cách viết/giá trị đơn vị của nguồn. | §0 | DIFF, PDF |
| STCE-EN-CORE-012 | MUST | Khi nguồn có vẻ sai, thiếu hoặc không rõ, báo vị trí và hỏi người dùng, không tự sửa nội dung khoa học. | Tối thượng; §0 | DIFF, MANUAL |

## BACKUP — Sao lưu và ghi nhận thay đổi

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-BACKUP-001 | MUST | Trước khi sửa .tex hoặc .bib có sẵn, tạo bản `_original` tương ứng; checklist cũ đã yêu cầu cả hai. | §0; §8.1; EN-C04 | SRC |
| STCE-EN-BACKUP-002 | MUST | Không ghi đè bản `_original` đã có. | §8.1 | SRC |
| STCE-EN-BACKUP-003 | MUST | Chỉ xóa backup khi người dùng xác nhận đã kiểm tra xong. | §0 | MANUAL |
| STCE-EN-BACKUP-004 | MUST | Báo cáo file/dòng gốc và mới, thay đổi trước/sau, lý do; không sửa âm thầm. | §8.1; cùng cơ chế mã hóa latex-stce-vn | DIFF |

## TPL — Template và chế độ đầu ra

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-TPL-001 | MUST | Ghi nhận mẫu thực tế của tác vụ; thay tham chiếu lịch sử 3451_Tai Yi Liu.tex bằng mẫu được người dùng chỉ định/cung cấp khi có. API history lần cập nhật này đối chiếu DEC. | Mở đầu; DEC; EN-C01 | MANUAL |
| STCE-EN-TPL-002 | MUST | Dùng documentclass `\documentclass[3p,times,11pt]{STCE/stce}`. | §1; DEC | SRC, BUILD |
| STCE-EN-TPL-003 | MUST | Chọn package theo đầu ra: bản final DEC dùng STCE/stce; bản proof dùng STCE/stce_proof theo mẫu proof. Không đồng thời bật cả hai chỉ để khớp ví dụ. | §1; DEC; EN-C01 | SRC, BUILD |
| STCE-EN-TPL-004 | MUST | Nạp STCE/stce_package và các phụ thuộc đúng mẫu thực tế; không sao chép thứ tự nạp gây lỗi. | §1; DEC | SRC, BUILD |
| STCE-EN-TPL-005 | MUST | Proof dùng đúng trạng thái uncorrectedproof/correctedproof; bản final không tự thêm watermark proof. | §1; DEC | SRC, PDF |
| STCE-EN-TPL-006 | MUST | Volume, firstpage, copyrightyear và DOI lấy từ metadata đã xác nhận; không mang nguyên metadata của bài mẫu sang bài khác. | §1; §8.1; DEC | DIFF |
| STCE-EN-TPL-007 | MUST | Khai báo id bài bằng newcommand và dùng nhất quán với hình/Bib. | §1 | SRC |
| STCE-EN-TPL-008 | MUST | Giữ trật tự preamble → document → frontmatter → nội dung → bibliography → end document. | §1 | SRC |
| STCE-EN-TPL-009 | MUST | Dùng bibliographystyle STCE/stce và kết thúc bằng end document. | §1; §7.2 | SRC, BUILD |
| STCE-EN-TPL-010 | MUST | Kiểm tra nhãn ISSN, copyright/license/footer và năm thực hiển thị theo mẫu; DEC có chuỗi năm 2026 hard-code, không cho rằng copyrightyear tự đổi mọi vị trí. | DEC/stce.sty:259–265; EN-C11 | SRC, PDF |

## FRONT — Frontmatter và tác giả

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-FRONT-001 | MUST | Đúng thứ tự DOI → title → authors → corresponding info → addresses → history → abstract → keywords. | §2 | SRC |
| STCE-EN-FRONT-002 | MUST | DOI dùng URL đúng metadata, dạng https://doi.org/10.31814/stce.huceYYYY-VV(N)-xx khi được cấp. | §2.1 | SRC, DIFF |
| STCE-EN-FRONT-003 | MUST | Giữ case của source, tên riêng và ký hiệu; PDF theo mẫu tiếng Anh thực tế. DEC/stce.sty:211 tự MakeUppercase tiêu đề; bài01 source HOA, bài08:17 Title Case. Không ép source sang một case khác chỉ vì bảng so sánh cũ hoặc áp Sentence case tiếng Việt; kiểm tra PDF không đổi nhận dạng ký hiệu. | §2.2; DEC; EN-C02 | SRC, DIFF, PDF |
| STCE-EN-FRONT-004 | MUST | Label tác giả [a]/[b]... khớp addresses, giữ đúng danh sách/thứ tự tên. | §2.3 | SRC, DIFF |
| STCE-EN-FRONT-005 | MUST | Tác giả liên hệ có corref{cor}, cortext tương ứng và không có dấu ngoặc nhọn thừa. | §2.3; DEC; EN-C06 | SRC, BUILD |
| STCE-EN-FRONT-006 | MUST | Cortext là `Corresponding author.~\textit{E-mail address:}`. | §2.4 | SRC, PDF |
| STCE-EN-FRONT-007 | MUST | Shortauth/mailauth thuộc tác giả liên hệ, không bị đổi theo headershort. | §2.4 | DIFF |
| STCE-EN-FRONT-008 | MUST | Headershort một tác giả ghi tên viết tắt người đó; hai tác giả ghi đủ cả hai theo thứ tự. | §2.4 | SRC, DIFF |
| STCE-EN-FRONT-009 | MUST | Với từ ba tác giả, headershort dùng tác giả đầu tiên + textit{et al.}, theo ví dụ/DEC và quyết định headershort trước đó; không lấy tác giả liên hệ thay thế. | §2.4; DEC; EN-C03 | SRC, DIFF |
| STCE-EN-FRONT-010 | MUST | Tên Việt Nam viết tắt dạng `Tên, Họ viết tắt. Đệm viết tắt.`; với tên khác theo đúng cấu trúc tên nguồn, không đoán họ từ vị trí. | §2.4; DEC | DIFF |
| STCE-EN-FRONT-011 | MUST | Chỉ nối initials bằng gạch nối nếu tên gốc có gạch nối; tên không gạch nối giữ khoảng cách giữa initials. | §2.4 | DIFF |
| STCE-EN-FRONT-012 | MUST | Addresses giữ nguyên đơn vị/quốc gia nguồn; không tự bổ sung địa chỉ. | §2.5; CORE-009 | DIFF |
| STCE-EN-FRONT-013 | MAY | Ngắt title/author/address dài bằng hai backslash theo bố cục, không đổi nội dung hoặc thành phần tên. | §2.5; DEC | SRC, PDF |
| STCE-EN-FRONT-014 | MUST | Giữ ORCID đã có trong nguồn và đúng tác giả; không tự tạo/đoán ORCID. | DEC | DIFF, PDF |
| STCE-EN-FRONT-015 | MUST | Abstract đặt trong môi trường abstract; nếu nguồn nhiều đoạn, giữ nguyên và báo người dùng số đoạn/vị trí, không tự gộp/cắt/viết lại. | §2.7; quyết định abstract đã chốt; EN-C07 | SRC, DIFF, MANUAL |
| STCE-EN-FRONT-016 | MUST | Keywords ngăn bằng dấu chấm phẩy, kết thúc bằng dấu chấm. | §2.8 | SRC |
| STCE-EN-FRONT-017 | MUST | CR đứng riêng dòng trước end keyword. | §2.8 | SRC |
| STCE-EN-FRONT-018 | MUST | Để từng họ tên tác giả không bị tách khó đọc qua hai dòng; chỉ đổi cách ngắt dòng/khoảng trắng, không đổi thành phần tên. | DEC; yêu cầu bảo toàn tên | SRC, PDF |

## HIST — Article history: received năm trường

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-HIST-001 | MUST | Với template DEC hiện tại, dùng received năm đối số theo đúng thứ tự, không chỉ dừng ở ba ngày của skill cũ. | DEC/stce.cls:273–286; EN-C08 | SRC, BUILD |
| STCE-EN-HIST-002 | MUST | Đối số 1 là Received, ngày nhận bài; không đổi thành ngày sửa/chấp nhận. | DEC/stce.cls:276,285 | DIFF, PDF |
| STCE-EN-HIST-003 | MUST | Đối số 2 là Revised, ngày bản sửa theo metadata. | DEC/stce.cls:276,285 | DIFF, PDF |
| STCE-EN-HIST-004 | MUST | Đối số 3 là Accepted, ngày chấp nhận bài. | DEC/stce.cls:276,285 | DIFF, PDF |
| STCE-EN-HIST-005 | MUST | Đối số 4 là Available online, ngày công bố trực tuyến; không gọi trường này là Version of Record. | DEC/stce.cls:281,285; DEC bài01:34, bài02:24 | DIFF, PDF |
| STCE-EN-HIST-006 | MUST | Đối số 5 là Version of Record, ngày bản chính thức; giữ riêng với ngày online/accepted và xuống dòng riêng theo class DEC. | DEC/stce.cls:285; DEC bài01:34, bài02:24 | DIFF, PDF |
| STCE-EN-HIST-007 | MUST | Chưa có ngày online hoặc Version of Record thì để đối số tương ứng rỗng `{}` và vẫn giữ đủ năm đối số; không tự điền ngày. Class DEC ẩn nhãn tương ứng khi đối số rỗng. | DEC/stce.cls:281,285 | SRC, DIFF, PDF |
| STCE-EN-HIST-008 | MUST | Ngày nhận/sửa/chấp nhận thiếu hoặc nguồn mâu thuẫn phải báo người dùng; không dùng ngày hiện tại, timestamp file hoặc ngày bài mẫu làm thay thế. | CORE-009/012; DEC | DIFF, MANUAL |
| STCE-EN-HIST-009 | MUST | Trước khi đưa năm đối số vào dự án khác, kiểm tra class đang dùng có hỗ trợ; nếu chưa hỗ trợ thì báo thiếu template phù hợp, không tự tạo shim/đổi class ngoài phạm vi. | DEC API; EN-C08 | SRC, BUILD |
| STCE-EN-HIST-010 | MUST | Ngày tháng lấy đúng nguồn; kiểu thể hiện theo mẫu kỳ đang dùng. Ví dụ DEC có DD/M/YYYY; không tự áp quy tắc padding tháng tiếng Việt vào bài Anh hoặc suy thêm ngày chưa có. | DEC bài01:34, bài02:24 | DIFF, PDF |
| STCE-EN-HIST-011 | MUST | Kiểm tra PDF in đúng cả nhãn và ngày: Received, Revised, Accepted, Available online, Version of Record; trường rỗng không để lọt ngày/ngoặc thừa vào abstract. | DEC/stce.cls:273–286 | PDF, BUILD |

## SEC — Cấu trúc và paragraph

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-SEC-001 | MUST | Dùng hierarchy section/subsection/subsubsection; không dùng paragraph/subparagraph. | §3.1 | SRC |
| STCE-EN-SEC-002 | SHOULD | Mục cuối thường là Conclusions; không tự viết thêm kết luận hoặc đổi ý nghĩa heading. | §3.1 | DIFF |
| STCE-EN-SEC-003 | MUST | Acknowledgment nếu có trong nguồn dùng section không đánh số, tên số ít; giữ declarations có sẵn, không tạo lời cảm ơn hay khai báo AI không có nguồn. | §1; §3.1; DEC; EN-C07 | SRC, DIFF |
| STCE-EN-SEC-004 | MUST | Để template đánh số subsubsection a., b., c.; đổi heading giả bold/italic thành heading thật. | §3.2; DEC/stce_package.tex:43 | SRC, PDF |
| STCE-EN-SEC-005 | MUST | Để class xử lý font heading; DEC subsection in nghiêng, subsubsection đứng. Không thêm italic cho subsubsection theo mô tả sai của skill cũ. | §3.2; DEC/stce.cls:482–486; EN-C13 | SRC, PDF |
| STCE-EN-SEC-006 | MUST | Giữa các paragraph độc lập có đúng một dòng trống; không gộp đoạn hoặc chỉ xuống dòng một lần. | §3.3 | SRC, DIFF |
| STCE-EN-SEC-007 | SHOULD | Trước section hai dòng trống, trước subsection/subsubsection một dòng trống. | §3.3 | SRC |
| STCE-EN-SEC-008 | MUST | Không có dòng trống giữa heading và paragraph đầu tiên; ví dụ cũ có dòng trống phải được đồng bộ. | §3.3; EN-C09 | SRC |
| STCE-EN-SEC-009 | MUST | Rà paragraph spacing toàn bộ nội dung sau frontmatter, trước bibliography; không chỉ xem vài đoạn đầu. | §3.3 | SRC |

## EQ — Phương trình và math mode

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-EQ-001 | MUST | Display equation dùng môi trường equation, giữ nguyên công thức. | §4.1 | SRC, DIFF |
| STCE-EN-EQ-002 | MUST | Label phương trình theo chuỗi số 1,2,3... khi cần tham chiếu. | §4.1 | SRC |
| STCE-EN-EQ-003 | MUST | Tham chiếu bằng Eq. và số trong ngoặc, có khoảng cách không ngắt dòng. | §4.1 | SRC, PDF |
| STCE-EN-EQ-004 | MUST | Không có dòng trống ngay trước equation. | §8.1 | SRC |
| STCE-EN-EQ-005 | MUST | Sau equation có một dòng trống nếu đoạn tiếp theo bắt đầu chữ hoa; không có dòng trống nếu tiếp tục bằng chữ thường. | §8.1 | SRC, DIFF |
| STCE-EN-EQ-006 | MUST | Nhiều biểu thức độc lập cùng dòng dùng semicolon + quad; không đổi dấu phân cách nội bộ vector/cases/max thành dấu chấm phẩy. | §8.1 | DIFF, PDF |
| STCE-EN-EQ-007 | MUST | Biến, chỉ số/mũ, Hy Lạp, dấu toán và dấu trừ toán học nằm trong math mode; đối chiếu toàn bài để giữ nhất quán. | §4.2; §8.1 | SRC, DIFF, PDF |
| STCE-EN-EQ-008 | SHOULD | Inline math ngắn dùng dollar; giải thích biến ngay sau equation theo cấu trúc where, không tự bổ sung định nghĩa. | §4.2 | SRC, DIFF |
| STCE-EN-EQ-009 | MUST | Bảo toàn giá trị và ký hiệu khi chuẩn hóa Unicode toán; không thay Unicode tiếng Việt/tên riêng bằng cách xóa dấu. | §8.1; CORE-003 | SRC, DIFF |
| STCE-EN-EQ-010 | MAY | Dòng comment phần trăm trước/sau equation là tùy chọn, không bắt buộc hoặc thay thế quy tắc dòng trống. | §8 bước4; DEC; EN-C09 | SRC |

## UNIT — Đơn vị và số tiếng Anh

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-UNIT-001 | MUST | Đơn vị thông thường dùng thủ công: phần đơn vị trong math mode dùng mathrm, giữ slash và cách viết nguồn; không chuyển đồng loạt sang siunitx. Siunitx chỉ dùng khi cần ký hiệu/prefix đặc biệt. | Người dùng chốt Thủ công như tiếng Việt; EN-C10 | SRC, DIFF, PDF |
| STCE-EN-UNIT-002 | MUST | Giữ cách viết/ngôn ngữ/giá trị đơn vị nguồn; không rút gọn các chiều hoặc tự dịch/đổi đơn vị. | §0; §8.1 | DIFF, PDF |
| STCE-EN-UNIT-003 | MUST | Số thập phân tiếng Anh dùng dấu chấm, không chuyển sang dấu phẩy/{,} của bài Việt. | §8.1 | SRC, DIFF |
| STCE-EN-UNIT-004 | MUST | Có khoảng cách không ngắt dòng giữa số và đơn vị, đặc biệt nhiệt độ: `37~$^\circ\mathrm{C}$`, không viết dính. | §4.3; quyết định đơn vị thủ công | SRC, PDF |
| STCE-EN-UNIT-005 | MUST | Khi dùng siunitx phải kiểm tra PDF giữ đúng đầu ra nguồn, không coi tên macro là bằng chứng hiển thị. | §8.1; cùng cơ chế bảo toàn nguồn | DIFF, PDF |

## TXT — Chữ và ký hiệu

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-TXT-001 | MUST | Dùng et al. đúng chuẩn template tiếng Anh; không đổi thành cs. và không bỏ initials có trong nguồn. | §0; §8.1; DEC | SRC, DIFF, PDF |
| STCE-EN-TXT-002 | MUST | En-dash nối khoảng giá trị hoặc từ ghép trong câu biểu diễn bằng `--`; không áp dụng cho gạch đầu dòng. | §4.3 | SRC, PDF |
| STCE-EN-TXT-003 | MUST | Công thức hóa học dùng ce/mhchem, không subscript/superscript thủ công. | §0; §4.3 | SRC, DIFF |
| STCE-EN-TXT-004 | MUST | Tên khoa học loài/chi/họ dùng textit. | §4.3 | SRC, PDF |
| STCE-EN-TXT-005 | MAY | Sửa khoảng cách typo như stress- strain → stress-strain khi không đổi nội dung. | §0 | DIFF |
| STCE-EN-TXT-006 | MUST | Gạch đầu dòng (bullet/list item ở đầu dòng) phải dùng dấu gạch đơn `-`, **không dùng `--`**. | §4.3; người dùng xác nhận | SRC, PDF |

## FIG — Hình và subcaption

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-FIG-001 | MUST | Đường dẫn Figures/id/FN dùng macro id; label f1,f2,... | §5.1; §5.5 | SRC |
| STCE-EN-FIG-002 | MUST | Tham chiếu bằng Fig. + ref, có khoảng cách không ngắt dòng. | §5.5 | SRC, PDF |
| STCE-EN-FIG-003 | MUST | Panel reference có ngoặc (a),(b), không viết hậu tố a trần. | §5.5 | SRC |
| STCE-EN-FIG-004 | MUST | Figure thông thường dùng [ht!] và căn giữa; wrapfigure theo cú pháp riêng của môi trường, không thêm [ht!] sai vị trí. | §5.1; §5.4–5.5; EN-C15 | SRC, PDF |
| STCE-EN-FIG-005 | SHOULD | Hình đơn thường width0.65textwidth; hai panel thường mỗi width0.47textwidth, không ép mọi hình cùng kích thước. | §5.5 | PDF |
| STCE-EN-FIG-006 | MAY | Dùng height thay width khi cần hai panel đồng đều chiều cao, ví dụ0.38textwidth. | §5.2 | PDF |
| STCE-EN-FIG-007 | SHOULD | Dùng hfill giữa panel; qquad/comment qquad là lựa chọn tùy bố cục, không bắt buộc giữ dòng comment trong mọi figure. | §5.2; DEC | SRC, PDF |
| STCE-EN-FIG-008 | SHOULD | Hai hình cùng hàng có caption/label riêng dùng minipage riêng; không giả thành một caption tổng. | §5.3 | SRC, PDF |
| STCE-EN-FIG-009 | MAY | Dùng wrapfigure khi cần quấn chữ, kiểm tra PDF. | §5.4 | PDF |
| STCE-EN-FIG-010 | MUST | Subcaption viết hoa chữ đầu nội dung, không Title Case toàn câu và không đổi nhãn panel a/b thành A/B. | Ví dụ §5.2; xác nhận chung | SRC, DIFF, PDF |
| STCE-EN-FIG-011 | MUST | Caption hình và subcaption không có dấu chấm kết thúc. | §5.5; xác nhận chung | SRC, DIFF |
| STCE-EN-FIG-012 | MUST | Tất cả ảnh tồn tại, giải mã/mở được và hiển thị đúng trên PDF. | §8.1 | SRC, PDF |

## TAB — Bảng

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-TAB-001 | MUST | Bảng một trang dùng tabularx với textwidth; bảng nhiều trang dùng xltabular trực tiếp, không ép vào float một trang. Số cột theo bảng thực tế, không chép cố định từ ví dụ. | §6.1–6.2; DEC; GH §6.3; EN-C14 | SRC, DIFF, PDF |
| STCE-EN-TAB-002 | MUST | Dùng top/mid/bottomrule theo booktabs; không hline; không tự thêm macro chưa được template định nghĩa. | §6.2; DEC | SRC, BUILD |
| STCE-EN-TAB-003 | MUST | Header dùng lll theo mẫu; rrr gộp hàng, p là phantom, không phân loại macro theo Việt/Anh. | §6.2; DEC/stce_package.tex:51–53 | SRC |
| STCE-EN-TAB-004 | MUST | Label t1,t2,...; tham chiếu bằng Table + ref có khoảng cách không ngắt dòng. | §6.2 | SRC, PDF |
| STCE-EN-TAB-005 | MUST | Bảng một trang có caption trước tabularx, float dùng [ht!]; caption/placement bảng nhiều trang theo môi trường tương ứng. | §6.2; DEC; EN-C14–15 | SRC, PDF |
| STCE-EN-TAB-006 | MAY | Điều chỉnh tabcolsep để dàn cột. | §6.2 | PDF |
| STCE-EN-TAB-007 | MUST | Với bảng một trang, hàng cuối kết thúc đúng một lần trước bottomrule; không thêm hàng trắng. Bảng dài dùng footer riêng ở TAB-017–018. | §6.1–6.2; EN-C09; GH §6.3 | SRC, PDF |
| STCE-EN-TAB-008 | MUST | Không chèn khoảng trắng/padding thừa chỉ để căn cột trong mã. | §6.2 | SRC |
| STCE-EN-TAB-009 | SHOULD | Khi cần căn số theo dấu chấm thập phân, dùng cột S; header cột S bọc trong ngoặc nhọn. S là căn cột số, không tự quyết định mặc định đơn vị. | §6.2 | SRC, PDF |
| STCE-EN-TAB-010 | MUST | Caption bảng không có dấu chấm kết thúc. | §6.2 | SRC, DIFF |
| STCE-EN-TAB-011 | MAY | Dùng S[table-format=M.N] để dự trù M chữ số phần nguyên, N chữ số phần thập phân theo dữ liệu thực tế. | GH §6.2 | SRC, PDF |
| STCE-EN-TAB-012 | MUST | Trong cột S, header/ô không phải số phải bọc ngoặc nhọn hoặc multicolumn phù hợp; dấu gạch ngang biểu thị thiếu dữ liệu viết {-}. | GH §6.2 | SRC, BUILD, PDF |
| STCE-EN-TAB-013 | MUST | Nạp package xltabular trong preamble khi dùng bảng dài nhiều trang. | GH §6.3 | SRC, BUILD |
| STCE-EN-TAB-014 | MUST | Đặt xltabular trực tiếp, không bọc trong float table. | GH §6.3 | SRC, PDF |
| STCE-EN-TAB-015 | MUST | Caption/label đặt ngay đầu xltabular; kết thúc hàng caption bằng hai backslash. | GH §6.3 | SRC, BUILD, PDF |
| STCE-EN-TAB-016 | MUST | Trang sau không lặp caption hoặc caption tiếp nối; chỉ lặp header cột giữa top/midrule trước endhead. | GH §6.3 | SRC, PDF |
| STCE-EN-TAB-017 | MUST | Footer các trang chưa cuối dùng midrule trước endfoot. | GH §6.3 | SRC, PDF |
| STCE-EN-TAB-018 | MUST | Footer trang cuối dùng bottomrule trước endlastfoot. | GH §6.3 | SRC, PDF |
| STCE-EN-TAB-019 | SHOULD | Ưu tiên cột X co giãn hoặc *N{>{centering arraybackslash}X} để tổng rộng theo textwidth; N theo bảng thực tế. | GH §6.3; xác nhận số cột chung | SRC, PDF |

## REF — Citations và bibliography

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-REF-001 | MUST | Trích dẫn dùng cite đúng key; không đổi tài liệu được dẫn khi chuẩn hóa. | §0; §7.1 | SRC, DIFF |
| STCE-EN-REF-002 | MUST | Trích dẫn liền nhau phải gộp vào một lệnh cite, ví dụ `\cite{2, 3, 4}`; không để `\cite{2}, ~\cite{3}`. Giữ nguyên key và thứ tự key. | §7.1; người dùng chốt gộp cite | SRC, DIFF |
| STCE-EN-REF-003 | MUST | Dấu `~` đứng liền chữ trước cite/ref/tham chiếu phương trình (`text~\cite{N}`), không có dấu cách hoặc xuống dòng trước `~`. | §4.3; §7.1 | SRC, PDF |
| STCE-EN-REF-004 | MUST | Nhiều key cite có đúng một dấu cách sau dấu phẩy, không có khoảng trắng trước dấu phẩy; không áp {,} của số thập phân Việt vào cite. | Xác nhận khoảng trắng key cite chung | SRC |
| STCE-EN-REF-005 | MUST | Mọi citation key có trong .bib, mọi label được phân giải sau compile ổn định. | §7.1; §8.1 | SRC, BUILD |
| STCE-EN-REF-006 | MUST | File .bib nằm trong Bib, tên trùng id, bibliography trỏ đúng file. | §7.2 | SRC, BUILD |

## QA — Kiểm chứng và bàn giao

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-QA-001 | MUST | Đối chiếu toàn bộ nguồn/bản chuẩn hóa: metadata, từng paragraph, công thức, bảng, caption, hình, bibliography và các phần cuối bài. | §8.1 | DIFF |
| STCE-EN-QA-002 | MUST | Kiểm tra ký hiệu và đơn vị nhất quán toàn bài; không tự sửa khi nguồn chưa xác định. | §8.1 | DIFF, PDF |
| STCE-EN-QA-003 | MUST | Biên dịch LaTeX/BibTeX phù hợp và đủ lần để ổn định references, có PDF thực. | §8.1 | BUILD |
| STCE-EN-QA-004 | MUST | Không báo hoàn tất khi còn lỗi compile hoặc undefined citation/reference. | §8.1 | BUILD |
| STCE-EN-QA-005 | MUST | Nếu AGY khả dụng hoặc được yêu cầu, đối soát độc lập và xử lý phát hiện có căn cứ. | §8.1 | MANUAL |
| STCE-EN-QA-006 | MUST | Rà overfull/underfull, missing image/font, hyperref, BibTeX; sửa format hoặc ghi rõ warning còn lại. | §8.1 | BUILD, PDF |
| STCE-EN-QA-007 | MUST | Báo file đầu ra, số trang, compile, cảnh báo, thay đổi format và điểm cần người dùng quyết định. | §8.1 | SRC, BUILD, PDF |
| STCE-EN-QA-008 | MUST | Kiểm tra từng mã có bằng chứng trên phiên bản hiện tại; compile thành công/reviewer nhận xét chung không thay các kiểm tra khác. | Cùng cơ chế mã hóa latex-stce-vn | MANUAL |

## WORK — Quy trình và công cụ

| Mã | Mức | Quy tắc | Nguồn | Kiểm chứng |
|---|---|---|---|---|
| STCE-EN-WORK-001 | MUST | Làm từng nhóm thay đổi; file trên500dòng làm incremental. | Lưu ý §8 | MANUAL |
| STCE-EN-WORK-002 | MUST | Chỉ commit khi có Git và được người dùng/quy trình cho phép; không tự tạo repo chỉ để thỏa skill. | Lưu ý §8; EN-C12 | MANUAL |
| STCE-EN-WORK-003 | MUST | Biên dịch sau nhóm thay đổi lớn và kiểm chứng bản xuất cuối. | Lưu ý §8 | BUILD |
| STCE-EN-WORK-004 | MUST | Đọc trực tiếp toàn bộ nội dung để đối chiếu; tìm kiếm chỉ định vị, dùng tool đọc file thực có thay vì phụ thuộc tên view_file. | Lưu ý §8; EN-C12 | MANUAL |
| STCE-EN-WORK-005 | MUST | Sửa trực tiếp bằng công cụ chỉnh sửa file, không script replace hàng loạt nội dung bản thảo. | Lưu ý §8 | MANUAL |

## Bản đồ checklist §8.1

| Mục | Nhóm mã |
|---|---|
| Backup | BACKUP-001–004 |
| Content comparison | CORE-002–012; QA-001 |
| Preamble/template | TPL-001–010; FRONT-001–018 |
| Article history (bổ sung) | HIST-001–011 |
| Math mode | EQ-007–009 |
| Units and numbers | UNIT-001–005 |
| Paragraphs | CORE-006; SEC-006–009 |
| Author wording | TXT-001; FRONT-007–011 |
| Equation spacing | EQ-004–005 |
| Equation environment/labels | EQ-001–003 |
| Equation comments (tùy chọn) | EQ-010 |
| Multiple expressions | EQ-006 |
| Figures/tables | FIG-001–012; TAB-001–019 |
| Citations/references | REF-001–006 |
| Compilation | QA-003–004 |
| AGY cross-check | QA-005 |
| Warnings | QA-006 |
| Report | BACKUP-004; QA-007–008 |

Các mã viết tắt trong bảng bản đồ đều có tiền tố STCE-EN-. Ngày tháng của bài mẫu không phải giá trị mặc định cho bài mới. Khả năng class DEC còn đọc ba/bốn đối số là đặc tính nguồn hiện có, không phải khuyến nghị tiếp tục bỏ hai trường mới.
