---
name: jev
description: Use Jev (TypeSafe decision model via OpenRouter) to classify, score or estimate probabilities for items fast and almost free. Trigger when the user says "dùng Jev để phân loại/chấm điểm/..." or asks to route, triage, label, rate or yes/no-judge any list of items.
---

# Jev — decision model usage

## Rules (from the user)
- **Jev decides, Claude writes.** Jev only returns choice / score / probability; Claude writes any text, replies or reports from those results.
- **Low certainty → Claude decides.** If confidence is low (rule of thumb < 0.7), a noul is near 0.5 (0.3–0.7), or the answer is `refusal`, Claude makes the call itself and says so.
- **Privacy:** everything sent to Jev leaves the machine. Before sending ANY private info (names, emails, phones, addresses, customer data, unpublished work, credentials), **ask the user first**, unless the user supplied that exact text for that exact purpose in this request. Send the minimum fields needed.
- **API key:** lives in `.env` as `OPENROUTER_API_KEY` (user's project folder, e.g. `JEVCLAUDE/.env`). Never print it, copy it to another file, or put it in chat. Use `jev.py`, which reads it internally.

## API (alpha — re-read docs before use; they change fast)
Docs: https://openrouter.ai/docs/guides/community/jev and https://openrouter.ai/docs/guides/community/jev-tutorial (if docs differ from this file, follow the docs and update this file).
- `POST https://openrouter.ai/api/alpha/decisions`, `Authorization: Bearer <key>`
- Pin model: `typesafe/jev-1.14` (script default).
- Body: `{"model", "state", "questions"}`; `state` = string/object/array; `questions` = map name → question. Several questions in one call are answered in parallel and can't see each other.
- Question types:
  - `noul` — probability (0–1) that something is true. Optional `instructions`, `criteria: {"true":..., "false":...}`.
  - `choice` — pick one; `criteria` = {option: description} (required).
  - `score` — ordered scale; `criteria` = ordered array (required); returns probability-weighted index (e.g. 1.96 ≈ item 2).
  - (`box` = image region, not needed.)
- Answers: noul → `noul`; choice → `choice`, `probabilities`, `confidence`; score → `score`, `probabilities`, `legend`, `confidence`; refusal → `{"type":"refusal"}` (others still answered). Confidence = how concentrated the distribution is, not a correctness guarantee.
- Billing per input token only (~$0.00002 per small call). Limit 262k tokens; >32KB text is slower/less accurate. No reasoning trace returned.
- Errors: 400 bad input, 401 key, 402 credits, 429 rate limit, 5xx/524/529 provider → retry once, then tell the user.

## How to run
1. Build request JSON in the scratchpad (not in the project): `{"state": ..., "questions": {...}}`.
2. Run from the folder containing `.env`:
   `PYTHONIOENCODING=utf-8 python -I ~/.claude/skills/jev/jev.py request.json .env`
   Prints model, answers, usage only.
3. Batch of N items ("phân loại danh sách"): one call per item (or a few items per call as an array only if cheap/short); same `questions`, items as `state`. Collect results into a table; flag low-confidence rows where Claude decided.
4. Write good criteria: concise, mutually exclusive option descriptions; ordered score levels with concrete anchors.

## Report format
Per item: answer(s) + confidence/probability; mark "Claude quyết" where Jev was uncertain or refused; show total cost from `usage.cost`.
