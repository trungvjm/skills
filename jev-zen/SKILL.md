---
name: jev-zen
description: >-
  Phân loại, chấm điểm, ước lượng xác suất và lọc log, diff hoặc danh sách
  miễn phí với Jev 1.13 System One (jev-1.13-free) và các model free trên
  OpenCode Zen. Kích hoạt khi người dùng gọi jev-zen, /jev-zen, jev-1.13-free,
  opencode zen, hoặc yêu cầu phân loại, chấm điểm, gán nhãn, lọc mục yes/no
  chi phí 0 đồng; phân biệt với skill jev dùng OpenRouter trả phí.
---

# Jev Zen: phân loại và chấm điểm miễn phí trên OpenCode Zen

Skill này gọi `jev-1.13-free` qua endpoint System One của OpenCode Zen (`POST https://opencode.ai/zen/v1/systemone`) và các model chat/reasoning miễn phí trên OpenCode Zen với chi phí `0` đồng. Giữ nguyên skill `jev` (`typesafe/jev-1.14` trên OpenRouter trả phí) khi người dùng yêu cầu đích danh OpenRouter hoặc cần kiểu câu hỏi khoanh vùng ảnh `box`.

## Quy tắc cốt lõi

- **Jev quyết định xác suất, Antigravity viết nội dung:** `jev-1.13-free` là System-1 decision model, chỉ trả xác suất đã hiệu chuẩn cho ba kiểu câu hỏi: `noul` (xác suất `0..1`), `choice` (nhãn được chọn kèm `probabilities` và `confidence`), và `score` (điểm kỳ vọng có trọng số trên `2..10` mức kèm `legend`, `probabilities`, và `confidence`). Model không sinh văn bản hay mã nguồn, không trả chuỗi suy luận, và chưa hỗ trợ `box` (cần Jev 1.14).
- **Độ chắc chắn thấp -> Agent quyết (hoặc cascade sang Zen free):** Khi `confidence < 0.7`, `0.3 <= noul <= 0.7` (`verdict: "uncertain"`), hoặc gặp `{"type": "refusal"}`, Antigravity tự đánh giá trực tiếp hoặc ủy thác sang model chat/reasoning miễn phí của OpenCode Zen qua `jev-zen.sh zen`, và ghi rõ `"Agent quyết"` trong báo cáo. `confidence` chỉ đo độ tập trung của phân phối xác suất, không phải cam kết đúng tuyệt đối.
- **Quyền riêng tư (Privacy):** Mọi dữ liệu gửi tới OpenCode Zen đều rời khỏi máy. Trước khi gửi bất kỳ thông tin riêng tư nào (họ tên, email, số điện thoại, địa chỉ, dữ liệu khách hàng, bản thảo chưa công bố, thông tin xác thực), bắt buộc hỏi ý kiến người dùng trước, trừ khi người dùng vừa cung cấp chính dữ liệu đó cho đúng mục đích kiểm tra trong lượt yêu cầu hiện tại. Chỉ gửi tối thiểu các trường cần thiết. Không bao giờ in, ghi log, hoặc sao chép API key ra hội thoại hay sang file khác.
- **Không lạm dụng khi code tĩnh làm được:** Nếu `grep`, `jq`, `git diff --stat`, compiler, hoặc test runner đã trả lời chính xác câu hỏi thì dùng trực tiếp, không gọi model.
- **Xử lý lỗi trung thực:** Mã thoát khác `0` (HTTP 400, 401, 429, 5xx hoặc lỗi kết nối) là lỗi thực thi, không bao giờ được diễn giải thành kết quả phủ định (`no` hoặc `0`).

## Xác thực và giới hạn ngữ cảnh

Script thực thi đặt tại [bin/jev-zen.sh](./bin/jev-zen.sh) (`~/.gemini/config/skills/jev-zen/bin/jev-zen.sh`).

Với `/zen/v1/systemone`, script thử khóa theo thứ tự: biến môi trường `OPENCODE_API_KEY`, trường `opencode.key` trong `~/.local/share/opencode/auth.json`, rồi đến `"public"`. Nếu khóa lưu trong máy đã hết hạn (`HTTP 401 api_key_expired`) khi gọi `jev-1.13-free`, script ghi cảnh báo lên `stderr` và tự thử lại một lần với `Authorization: Bearer public`.

Lệnh con `jev-zen.sh zen` gọi `opencode run --standalone` nên bắt buộc có API key OpenCode Console còn hạn trong `~/.local/share/opencode/auth.json` (hoặc `OPENCODE_API_KEY`). Nếu khóa hết hạn (`api_key_expired`), gia hạn tại `https://opencode.ai/console/account#api-keys` rồi chạy `opencode auth login`.

Giới hạn mặc định của `jev-1.13-free` là `64000` token mỗi request và khoảng `32k` mỗi câu hỏi (nhận văn bản, `image/png`, `image/jpeg`). Thêm cờ `--long-context` để gửi header `TypeSafe-Danger-Zone-Long-Context: true`, nâng trần ngữ cảnh lên `262000` token.

## Cách dùng CLI

Có thể gán biến đường dẫn khi gọi nhiều lần trong cùng phiên shell:

```bash
JEV_ZEN=/Users/trungtranngoc/.gemini/config/skills/jev-zen/bin/jev-zen.sh
```

### 1. Kiểm tra môi trường (`doctor`)

```bash
"$JEV_ZEN" doctor
```

Kiểm tra `curl`, `opencode --version`, trạng thái tồn tại (boolean, không in giá trị khóa) của `OPENCODE_API_KEY` và `~/.local/share/opencode/auth.json`, đồng thời gửi truy vấn thử tới `jev-1.13-free`. Trả về JSON gồm `stored_key_status` (`"valid"`, `"expired"`, `"missing"`, hoặc `"error"`), `jev_systemone_ok`, `billing_source`, và `cost`. Thoát mã `0` khi và chỉ khi `jev_systemone_ok` bằng `true`.

### 2. Tra cứu model miễn phí (`models`)

```bash
"$JEV_ZEN" models
"$JEV_ZEN" models --json
```

Truy vấn trực tiếp `https://opencode.ai/zen/v1/models`, lọc các model có `cost.text.input.price == 0` và `cost.text.output.price == 0` (hoặc có `"free"` trong `id`), kèm `jev-1.13-free` ở đầu bảng. Danh sách model miễn phí trên OpenCode Zen có thể thay đổi theo thời điểm (hiện gồm `jev-1.13-free` và các model chat/reasoning như `deepseek-v4.1-flash-free`, `glm-5.3-flash-free`, `mimo-v2.6-flash-free`, `longcat-2.5-free`, `nemotron-3.5-super-vl-free`, `hy4-flash-free`, `beam-free`, `big-pickle`), nên chạy `models` khi cần đối chiếu thực tế. Mặc định in bảng căn cột; thêm `--json` để xuất mảng JSON.

### 3. Chạy payload JSON (`run`)

```bash
"$JEV_ZEN" run <request.json | -> [--long-context] [--allow-paid]
```

Đọc payload `{"state": ..., "questions": {...}}` tương thích định dạng `jev.py` (trường `"model"` tùy chọn, mặc định `"jev-1.13-free"`) từ file hoặc từ `stdin` khi truyền `-`. Chặn mọi model không có hậu tố `-free` trừ khi có `--allow-paid`. Trả về JSON `{"model", "answers", "usage"}`.

```bash
echo '{"state":"git status --short","questions":{"ro":{"type":"noul","instructions":"Is this command strictly read-only?"}}}' \
  | "$JEV_ZEN" run -
```

### 4. Hỏi nhanh một hoặc nhiều câu (`ask`)

Nguồn `state` (bắt buộc một trong bốn cách): `--state <str>`, `--state-file <path>`, `--state-json <json_str>`, hoặc pipe qua `stdin`.

Các cờ câu hỏi và điều khiển:
- `-q`, `--question <instructions>`: nội dung câu hỏi đơn.
- `-k`, `--key <id>`: tên khóa kết quả của `-q` (mặc định `"result"`).
- `-t`, `--type <noul|choice|score>`: kiểu câu hỏi (mặc định `"noul"`). Truyền `-t box` trên `jev-1.13*` sẽ báo lỗi và thoát khác `0` vì `box` cần Jev 1.14.
- `-o`, `--option <name=desc>`: lặp lại được, tách tại dấu `=` đầu tiên. Bắt buộc từ 2 lựa chọn trở lên với `-t choice`; tùy chọn `true=...` và `false=...` với `-t noul`.
- `-l`, `--level <desc>`: lặp lại được, từ `2` đến `10` mức theo thứ tự tăng dần với `-t score`.
- `--questions <json_str>` hoặc `--questions-file <path>`: truyền đối tượng JSON nhiều câu hỏi để chấm song song trong một request.
- `--noul-yes <float>` (mặc định `0.7`), `--noul-no <float>` (mặc định `0.3`): ngưỡng gắn nhãn `"verdict": "yes" | "no" | "uncertain"` cho `noul`.
- `--raw`: trả nguyên bản trường `answers` từ API. Mặc định (không có `--raw`) trả `{"model", "results", "usage"}`, bổ sung `"verdict"` cho `noul` (giữ nguyên `{"type": "refusal"}` nếu model từ chối) và `"top_level"` (nhãn `legend` có xác suất cao nhất) cho `score`.
- `--model <id>` (mặc định `"jev-1.13-free"`), `--long-context`, `--allow-paid`.

Ví dụ thực thi:

```bash
# noul qua stdin
git diff --stat | "$JEV_ZEN" ask \
  -k docs_only -t noul \
  -q "Does this diff modify documentation files only?" \
  -o "true=Only markdown or documentation files changed" \
  -o "false=Any source code, script, build, or config file changed"

# choice với tên khóa có nghĩa
"$JEV_ZEN" ask \
  --state "fix(parser): guard against empty header line" \
  -k intent -t choice \
  -q "Classify this commit message by primary intent." \
  -o "bugfix=Fixes broken runtime behavior or crash" \
  -o "feature=Adds new user-visible or API capability" \
  -o "maintenance=Refactor, docs, test, or build change"

# score trên thang có thứ tự
"$JEV_ZEN" ask \
  --state-file patch.diff \
  -k risk -t score \
  -q "Rate the deployment risk of this patch." \
  -l "0: Comments, docs, or formatting only" \
  -l "1: Isolated internal change" \
  -l "2: Public interface, auth, or schema change"

# nhiều câu hỏi chạy song song
"$JEV_ZEN" ask \
  --state-file patch.diff \
  --questions '{
    "public_api": {"type": "noul", "instructions": "Does this patch alter CLI flags or exported signatures?"},
    "has_tests": {"type": "noul", "instructions": "Does this patch add or update automated tests?"}
  }'
```

### 5. Lọc và chấm điểm danh sách theo lô (`batch`)

```bash
cat app.log | "$JEV_ZEN" batch \
  --context "Application runtime log lines." \
  -t noul --min-noul 0.7 --chunk-size 25 \
  -q "Does this log line report a crash, unhandled exception, or fatal error?"
```

Các cờ của `batch`:
- Đầu vào: `--items-file <path>` hoặc các dòng không rỗng từ `stdin`; thêm `--jsonl` nếu mỗi dòng là một bản ghi JSON.
- Câu hỏi và ngữ cảnh: `--context <str>` (mặc định `"Batch item evaluation."`), `-q`/`--question <instructions>` (bắt buộc), `-t`/`--type <noul|choice|score>` (mặc định `"noul"`), `-o`/`--option <name=desc>`, `-l`/`--level <desc>`.
- Chia lô và lọc ngưỡng: `--chunk-size <int>` (mặc định `25`, tối đa `50`; mỗi lô nhúng từng mục thành câu hỏi `item_{idx}` để đánh giá song song với chi phí `0` đồng), `--min-noul <float>` (chỉ giữ các mục có `noul >= min_noul`), `--noul-yes` (`0.7`), `--noul-no` (`0.3`), `--long-context`, `--model` (`"jev-1.13-free"`), `--allow-paid`.
- Đầu ra: JSON `{"model", "total_items", "returned_items", "items": [{"index", "item", "answer"}], "usage": {"input_tokens", "output_tokens", "cost"}}`.

### 6. Gọi model chat/reasoning miễn phí (`zen`)

```bash
"$JEV_ZEN" zen [-m <free-model>] [-f <file>] [--format <default|json>] [--allow-paid] "<prompt>"
```

Chạy lệnh này khi `jev-1.13-free` trả độ chắc chắn thấp hoặc khi cần tóm tắt lý do cho các mục đã lọc:
- `-m`, `--model <id>`: mặc định `"deepseek-v4.1-flash-free"` (tự bỏ tiền tố `opencode/` nếu có). Script kiểm tra model phải kết thúc bằng `-free`, bằng `big-pickle`, hoặc có giá `input = 0` và `output = 0` trên `/zen/v1/models` trước khi chạy `opencode run --standalone -m opencode/<model_id>`.
- `-f`, `--file <path>`: đính kèm file đầu vào (lặp lại được).
- `--format <default|json>`: định dạng kết quả của `opencode run` (mặc định `"default"`).
- `--allow-paid`: bỏ chặn model trả phí (mặc định tắt).
- Nếu pipe dữ liệu vào `stdin`, script tự nối nội dung đó vào cuối `<prompt>` trong cặp thẻ `<stdin>...</stdin>`.

## Thiết kế câu hỏi chuẩn

1. Mỗi câu hỏi chỉ kiểm tra một phán đoán quan sát được trực tiếp từ `state` (tên hàm, mã trạng thái, dòng diff, nội dung log), tránh tiêu chí mơ hồ hoặc đòi hỏi suy đoán ngoài dữ liệu.
2. Tách câu ghép chứa `và` hoặc `hoặc` thành nhiều câu hỏi song song. Các câu trong cùng đối tượng `questions` chạy độc lập và không nhìn thấy câu trả lời của nhau; hãy tách riêng từng điều kiện (ví dụ `changes_public_api` và `adds_tests`) rồi kết hợp logic ở tầng Agent.
3. Mô tả rõ cả hai nhánh `true` và `false` cho `noul` qua `criteria: {"true": "...", "false": "..."}` (hoặc `-o "true=..." -o "false=..."`) khi có các trường hợp giáp ranh dễ nhầm.
4. Đặt tên khóa `choice` có nghĩa như `bugfix`, `feature`, `refactor` thay vì ký hiệu `A`, `B`, kèm mô tả loại trừ lẫn nhau.
5. Kèm thêm câu `noul` phụ khi tập nhãn của `choice` không bao phủ hết dữ liệu thực tế. Do `choice` luôn chuẩn hóa tổng xác suất bằng `1`, mục không khớp phương án nào vẫn bị ép vào một nhãn nếu không lọc điều kiện áp dụng bằng một câu `noul` đi kèm.
6. Đọc phân phối `probabilities` và `confidence` của `score` bên cạnh điểm kỳ vọng trung bình. Trên `jev-1.13-free`, `legend` và `probabilities` của `score` là object đánh khóa chuỗi (`"0"`, `"1"`, ...). Điểm kỳ vọng quanh `1.0` trên thang `0..2` có thể xuất phát từ xác suất tập trung ở mức `"1"` (`confidence` cao) hoặc phân cực ở hai đầu `"0"` và `"2"` (`confidence` thấp).

## Định dạng báo cáo kết quả

- Trình bày theo từng mục hoặc từng câu hỏi: kết luận kèm xác suất (`noul` hoặc `probabilities`) và `confidence`.
- Ghi rõ `"Agent quyết"` ở mọi dòng có `confidence < 0.7`, `0.3 <= noul <= 0.7` (`verdict: "uncertain"`), hoặc `{"type": "refusal"}` mà Antigravity đã tự đánh giá hoặc chuyển tiếp qua `jev-zen.sh zen`.
- Luôn ghi tổng chi phí từ `usage.cost` ở cuối báo cáo (bằng `0` khi dùng `jev-1.13-free` và các model free trên OpenCode Zen).
