#!/usr/bin/env bash
set -euo pipefail

PY_SCRIPT=$(cat <<'PY'
import argparse
import json
import os
import re
import shutil
import subprocess
import sys

SYSTEMONE_URL = "https://opencode.ai/zen/v1/systemone"
MODELS_URL = "https://opencode.ai/zen/v1/models"
AUTH_JSON_PATH = os.path.expanduser("~/.local/share/opencode/auth.json")
DEFAULT_JEV_MODEL = "jev-1.13-free"
DEFAULT_ZEN_MODEL = "deepseek-v4.1-flash-free"

JEV_MODEL_ENTRY = {
    "id": "jev-1.13-free",
    "type": "systemone",
    "context": 64000,
    "long_context": 262000,
    "output": "typed-json",
    "modalities": ["text", "image/png", "image/jpeg"],
    "cost": {"input": 0, "output": 0},
    "description": "TypeSafe Jev 1.13 System-1 decision model (noul, choice, score) via /zen/v1/systemone",
}

_KNOWN_SECRETS = set()
_SESSION_PUBLIC_FALLBACK = False


def register_secret(val):
    if isinstance(val, str):
        s = val.strip()
        if len(s) >= 4 and s != "public":
            _KNOWN_SECRETS.add(s)


def scrub_secrets(text):
    if not text:
        return text
    out = text
    for secret in sorted(_KNOWN_SECRETS, key=len, reverse=True):
        out = out.replace(secret, "[REDACTED]")
    out = re.sub(r"(?i)(authorization\s*:\s*bearer\s+)(?!public\b)\S+", r"\1[REDACTED]", out)
    out = re.sub(r"\bsk-[A-Za-z0-9._\-]{8,}\b", "[REDACTED]", out)
    return out


def die(msg, code=1):
    sys.stderr.write(f"[jev-zen error] {scrub_secrets(str(msg))}\n")
    sys.exit(code)


def warn(msg):
    sys.stderr.write(f"[jev-zen warn] {scrub_secrets(str(msg))}\n")


def load_stored_key():
    """Return (key_or_none, status_hint) where status_hint in ('present', 'missing', 'error')."""
    if not os.path.exists(AUTH_JSON_PATH):
        return None, "missing"
    try:
        with open(AUTH_JSON_PATH, "r", encoding="utf-8") as fh:
            data = json.load(fh)
    except (OSError, json.JSONDecodeError):
        return None, "error"
    if not isinstance(data, dict):
        return None, "error"
    oc = data.get("opencode")
    if not isinstance(oc, dict):
        return None, "missing"
    key = oc.get("key")
    if isinstance(key, str) and key.strip():
        s = key.strip()
        register_secret(s)
        return s, "present"
    return None, "missing"


def resolve_systemone_auth():
    """Return (token, source) following: OPENCODE_API_KEY -> auth.json -> 'public'."""
    env_key = os.environ.get("OPENCODE_API_KEY", "").strip()
    if env_key:
        register_secret(env_key)
    stored_key, _ = load_stored_key()
    if env_key:
        return env_key, "env"
    if stored_key and not _SESSION_PUBLIC_FALLBACK:
        return stored_key, "stored"
    return "public", "public"


def curl_json_get(url, max_time=20):
    proc = subprocess.run(
        ["curl", "-sS", "--max-time", str(max_time), "-w", "\n%{http_code}", url],
        input=b"",
        capture_output=True,
    )
    if proc.returncode != 0:
        err = proc.stderr.decode("utf-8", "replace").strip()
        return None, 0, f"curl exit {proc.returncode}: {err}"
    raw = proc.stdout.decode("utf-8", "replace")
    body, _, code_str = raw.rpartition("\n")
    try:
        status = int(code_str.strip())
    except ValueError:
        return None, 0, raw[:500]
    if status != 200:
        return None, status, body[:500]
    try:
        return json.loads(body), 200, ""
    except json.JSONDecodeError as exc:
        return None, status, f"Invalid JSON response: {exc}"


def curl_systemone_once(payload_bytes, token, long_context=False, max_time=60):
    cmd = [
        "curl",
        "-sS",
        "--max-time",
        str(max_time),
        "-w",
        "\n%{http_code}",
        "-X",
        "POST",
        SYSTEMONE_URL,
        "-H",
        "Content-Type: application/json",
        "-H",
        f"Authorization: Bearer {token}",
    ]
    if long_context:
        cmd.extend(["-H", "TypeSafe-Danger-Zone-Long-Context: true"])
    cmd.extend(["--data-binary", "@-"])
    proc = subprocess.run(cmd, input=payload_bytes, capture_output=True)
    if proc.returncode != 0:
        err = proc.stderr.decode("utf-8", "replace").strip()
        return None, 0, f"curl exit {proc.returncode}: {err}"
    raw = proc.stdout.decode("utf-8", "replace")
    body, _, code_str = raw.rpartition("\n")
    try:
        status = int(code_str.strip())
    except ValueError:
        return None, 0, raw[:500]
    return body, status, ""


def is_expired_key_response(status, body):
    if status != 401 or not body:
        return False
    return ("api_key_expired" in body) or ("This API key has expired" in body)


def call_systemone(req_obj, long_context=False):
    global _SESSION_PUBLIC_FALLBACK
    model = req_obj.get("model", DEFAULT_JEV_MODEL)
    payload_bytes = json.dumps(req_obj, ensure_ascii=False).encode("utf-8")
    token, source = resolve_systemone_auth()
    body, status, curl_err = curl_systemone_once(payload_bytes, token, long_context=long_context)
    if curl_err:
        die(curl_err)
    if source == "stored" and is_expired_key_response(status, body) and model == "jev-1.13-free":
        warn("Stored OpenCode API key expired; using OpenCode Zen public free tier for jev-1.13-free.")
        _SESSION_PUBLIC_FALLBACK = True
        body, status, curl_err = curl_systemone_once(payload_bytes, "public", long_context=long_context)
        if curl_err:
            die(curl_err)
    if status != 200:
        die(f"HTTP {status}: {(body or '')[:500]}")
    try:
        return json.loads(body)
    except json.JSONDecodeError as exc:
        die(f"Invalid JSON from /zen/v1/systemone: {exc}")


def enforce_jev_model_guard(model, allow_paid):
    if not isinstance(model, str) or not model.strip():
        die("Model ID must be a non-empty string.")
    if not allow_paid and not model.endswith("-free"):
        die(f"Model '{model}' is not a '-free' model. Pass --allow-paid to use paid models.")


def enforce_box_guard(model, qtype):
    if qtype == "box":
        if str(model).startswith("jev-1.13"):
            die(f"Primitive 'box' is not supported on {model}; 'box' requires Jev 1.14.")
        die("Primitive 'box' requires Jev 1.14 via 'run <request.json>'.")


def check_questions_dict_guards(model, questions):
    if not isinstance(questions, dict) or not questions:
        die("'questions' must be a non-empty JSON object.")
    for qk, qv in questions.items():
        if not isinstance(qv, dict):
            die(f"Question '{qk}' must be an object.")
        if qv.get("type") == "box" and str(model).startswith("jev-1.13"):
            die(f"Question '{qk}': primitive 'box' is not supported on {model}; 'box' requires Jev 1.14.")


def is_zero_number(v):
    return isinstance(v, (int, float)) and not isinstance(v, bool) and v == 0


def extract_model_prices(m):
    cost = m.get("cost")
    if not isinstance(cost, dict):
        return None, None
    text_cost = cost.get("text")
    if not isinstance(text_cost, dict):
        return None, None
    in_obj = text_cost.get("input")
    out_obj = text_cost.get("output")
    in_price = in_obj.get("price") if isinstance(in_obj, dict) else in_obj
    out_price = out_obj.get("price") if isinstance(out_obj, dict) else out_obj
    return in_price, out_price


def fetch_free_zen_models():
    data, status, err = curl_json_get(MODELS_URL, max_time=20)
    if data is None:
        if status:
            die(f"Failed to fetch {MODELS_URL} (HTTP {status}): {err}")
        die(f"Failed to fetch {MODELS_URL}: {err}")
    raw_list = data.get("data") if isinstance(data, dict) else data
    if not isinstance(raw_list, list):
        die(f"Unexpected response structure from {MODELS_URL}.")
    free_models = []
    for m in raw_list:
        if not isinstance(m, dict):
            continue
        mid = str(m.get("id", "")).strip()
        if not mid or mid == "jev-1.13-free":
            continue
        in_p, out_p = extract_model_prices(m)
        if (is_zero_number(in_p) and is_zero_number(out_p)) or ("free" in mid.lower()):
            limit = m.get("limit") if isinstance(m.get("limit"), dict) else {}
            mods = m.get("modalities")
            if isinstance(mods, dict):
                in_mods = mods.get("input") if isinstance(mods.get("input"), list) else []
            elif isinstance(mods, list):
                in_mods = mods
            else:
                in_mods = []
            free_models.append(
                {
                    "id": mid,
                    "type": m.get("type", "chat"),
                    "context": limit.get("context"),
                    "output": limit.get("output", "text"),
                    "modalities": in_mods,
                    "cost": {
                        "input": 0 if is_zero_number(in_p) else in_p,
                        "output": 0 if is_zero_number(out_p) else out_p,
                    },
                    "description": m.get("description", ""),
                }
            )
    return free_models


def parse_options_list(opt_list):
    out = {}
    for raw in opt_list or []:
        if "=" not in raw:
            die(f"Invalid -o/--option '{raw}': expected format 'name=description'.")
        name, desc = raw.split("=", 1)
        name = name.strip()
        desc = desc.strip()
        if not name or not desc:
            die(f"Invalid -o/--option '{raw}': both option name and description must be non-empty.")
        if name in out:
            die(f"Duplicate -o/--option key '{name}'.")
        out[name] = desc
    return out


def build_single_question(qtype, instructions, options_list, levels_list, model):
    enforce_box_guard(model, qtype)
    if qtype not in ("noul", "choice", "score"):
        die(f"Invalid --type '{qtype}'. Expected one of: noul, choice, score.")
    opts = parse_options_list(options_list)
    levels = [lv.strip() for lv in (levels_list or []) if lv.strip()]
    if levels_list and len(levels) != len(levels_list):
        die("Empty string passed to -l/--level is not allowed.")

    q = {"type": qtype}
    if instructions is not None and instructions.strip():
        q["instructions"] = instructions.strip()

    if qtype == "noul":
        if levels:
            die("-l/--level cannot be used with --type noul.")
        if opts:
            bad = [k for k in opts if k not in ("true", "false")]
            if bad:
                die(f"For --type noul, -o/--option keys must be 'true' or 'false' (got {', '.join(bad)}).")
            q["criteria"] = opts
        if "instructions" not in q and "criteria" not in q:
            die("For --type noul, provide -q/--question and/or -o true=... -o false=...")
    elif qtype == "choice":
        if levels:
            die("-l/--level cannot be used with --type choice (use -o name=desc).")
        if len(opts) < 2:
            die("--type choice requires at least 2 -o/--option name=desc entries.")
        q["criteria"] = opts
    elif qtype == "score":
        if opts:
            die("-o/--option cannot be used with --type score (use -l/--level).")
        if not (2 <= len(levels) <= 10):
            die(f"--type score requires 2 to 10 -l/--level entries (got {len(levels)}).")
        q["criteria"] = levels

    return q


def _score_key_order(k):
    try:
        return (0, int(k))
    except (ValueError, TypeError):
        return (1, str(k))


def extract_top_level(legend, probs):
    if isinstance(probs, dict) and probs:
        numeric_items = [
            (k, v)
            for k, v in probs.items()
            if isinstance(v, (int, float)) and not isinstance(v, bool)
        ]
        if not numeric_items:
            return None
        best_k, _ = max(numeric_items, key=lambda kv: (kv[1], _score_key_order(kv[0])))
        if isinstance(legend, dict):
            if str(best_k) in legend:
                return legend[str(best_k)]
            return legend.get(best_k)
        if isinstance(legend, list):
            try:
                idx = int(best_k)
                if 0 <= idx < len(legend):
                    return legend[idx]
            except (ValueError, TypeError):
                return None
    elif isinstance(probs, list) and probs:
        numeric_items = [
            (i, v)
            for i, v in enumerate(probs)
            if isinstance(v, (int, float)) and not isinstance(v, bool)
        ]
        if not numeric_items:
            return None
        best_i, _ = max(numeric_items, key=lambda iv: (iv[1], iv[0]))
        if isinstance(legend, list) and 0 <= best_i < len(legend):
            return legend[best_i]
        if isinstance(legend, dict):
            return legend.get(str(best_i), legend.get(best_i))
    return None


def annotate_answer(ans, noul_yes=0.7, noul_no=0.3):
    if not isinstance(ans, dict):
        return ans
    atype = ans.get("type")
    if atype == "refusal":
        return dict(ans)
    out = dict(ans)
    if atype == "noul":
        p = ans.get("noul")
        if isinstance(p, (int, float)) and not isinstance(p, bool):
            if p > noul_yes:
                out["verdict"] = "yes"
            elif p < noul_no:
                out["verdict"] = "no"
            else:
                out["verdict"] = "uncertain"
    elif atype == "score":
        out["top_level"] = extract_top_level(ans.get("legend"), ans.get("probabilities"))
    return out


def validate_noul_thresholds(noul_yes, noul_no):
    if not (0.0 <= noul_no <= noul_yes <= 1.0):
        die(f"Invalid thresholds: require 0.0 <= --noul-no ({noul_no}) <= --noul-yes ({noul_yes}) <= 1.0.")


# --- Subcommands ---


def cmd_doctor(_args):
    env_key = os.environ.get("OPENCODE_API_KEY", "").strip()
    if env_key:
        register_secret(env_key)
    stored_key, stored_hint = load_stored_key()

    curl_ok = shutil.which("curl") is not None
    opencode_ok = False
    opencode_ver = None
    if shutil.which("opencode") is not None:
        try:
            proc = subprocess.run(["opencode", "--version"], capture_output=True, text=True, timeout=10)
            if proc.returncode == 0:
                opencode_ok = True
                opencode_ver = scrub_secrets(proc.stdout.strip()) or None
        except (OSError, subprocess.SubprocessError):
            opencode_ok = False

    probe_req = {
        "model": DEFAULT_JEV_MODEL,
        "state": "healthcheck",
        "questions": {
            "ok": {
                "type": "noul",
                "instructions": "Does the state equal healthcheck?",
            }
        },
    }
    payload_bytes = json.dumps(probe_req).encode("utf-8")

    stored_key_status = stored_hint  # 'missing' or 'error' if not 'present'
    jev_ok = False
    billing_source = None
    cost = None
    probe_body = None

    if curl_ok:
        if stored_hint == "present" and stored_key:
            s_body, s_status, s_err = curl_systemone_once(payload_bytes, stored_key, max_time=20)
            if s_err:
                stored_key_status = "error"
            elif s_status == 200:
                stored_key_status = "valid"
                if not env_key:
                    probe_body = s_body
            elif is_expired_key_response(s_status, s_body):
                stored_key_status = "expired"
                if not env_key:
                    warn("Stored OpenCode API key expired; using OpenCode Zen public free tier for jev-1.13-free.")
            else:
                stored_key_status = "error"

        if probe_body is None:
            if env_key:
                p_body, p_status, p_err = curl_systemone_once(payload_bytes, env_key, max_time=20)
                if not p_err and p_status == 200:
                    probe_body = p_body
            elif stored_key_status in ("missing", "expired"):
                p_body, p_status, p_err = curl_systemone_once(payload_bytes, "public", max_time=20)
                if not p_err and p_status == 200:
                    probe_body = p_body

        if probe_body is not None:
            try:
                parsed = json.loads(probe_body)
                answers = parsed.get("answers")
                if isinstance(answers, dict) and "ok" in answers:
                    jev_ok = True
                usage = parsed.get("usage") if isinstance(parsed.get("usage"), dict) else {}
                cost = usage.get("cost")
                oc_usage = usage.get("opencode") if isinstance(usage.get("opencode"), dict) else {}
                billing_source = oc_usage.get("billing_source")
            except json.JSONDecodeError:
                jev_ok = False
    else:
        if stored_hint == "present":
            stored_key_status = "error"

    report = {
        "curl_available": curl_ok,
        "opencode_available": opencode_ok,
        "opencode_version": opencode_ver,
        "opencode_api_key_env_present": bool(env_key),
        "auth_json_key_present": bool(stored_key),
        "stored_key_status": stored_key_status,
        "jev_systemone_ok": jev_ok,
        "billing_source": billing_source,
        "cost": cost,
    }
    print(json.dumps(report, ensure_ascii=False, indent=2))
    sys.exit(0 if jev_ok else 1)


def _fmt_ctx(m):
    ctx = m.get("context")
    lctx = m.get("long_context")
    if isinstance(ctx, int) and isinstance(lctx, int):
        return f"{ctx} ({lctx})"
    return str(ctx) if ctx is not None else "-"


def cmd_models(args):
    models = [dict(JEV_MODEL_ENTRY)] + fetch_free_zen_models()
    if args.json:
        print(json.dumps(models, ensure_ascii=False, indent=2))
        return
    rows = []
    for m in models:
        rows.append(
            (
                str(m.get("id", "")),
                str(m.get("type", "")),
                _fmt_ctx(m),
                str(m.get("output", "")),
                str(m.get("description", "")),
            )
        )
    headers = ("ID", "TYPE", "CONTEXT", "OUTPUT", "DESCRIPTION")
    w0 = max(len(headers[0]), *(len(r[0]) for r in rows))
    w1 = max(len(headers[1]), *(len(r[1]) for r in rows))
    w2 = max(len(headers[2]), *(len(r[2]) for r in rows))
    w3 = max(len(headers[3]), *(len(r[3]) for r in rows))
    print(f"{headers[0]:<{w0}}  {headers[1]:<{w1}}  {headers[2]:<{w2}}  {headers[3]:<{w3}}  {headers[4]}")
    print(f"{'-' * w0}  {'-' * w1}  {'-' * w2}  {'-' * w3}  {'-' * 24}")
    for r in rows:
        print(f"{r[0]:<{w0}}  {r[1]:<{w1}}  {r[2]:<{w2}}  {r[3]:<{w3}}  {r[4]}")


def cmd_run(args):
    if args.request == "-":
        raw = sys.stdin.read()
        if not raw.strip():
            die("Empty JSON input on stdin.")
    else:
        try:
            with open(args.request, "r", encoding="utf-8") as fh:
                raw = fh.read()
        except OSError as exc:
            die(f"Cannot read request file '{args.request}': {exc}")
    try:
        req = json.loads(raw)
    except json.JSONDecodeError as exc:
        die(f"Invalid request JSON: {exc}")
    if not isinstance(req, dict):
        die("Request JSON root must be an object.")
    if "state" not in req:
        die("Request JSON missing required key 'state'.")
    model = req.setdefault("model", DEFAULT_JEV_MODEL)
    enforce_jev_model_guard(model, args.allow_paid)
    check_questions_dict_guards(model, req.get("questions"))

    out = call_systemone(req, long_context=args.long_context)
    result = {
        "model": out.get("model"),
        "answers": out.get("answers"),
        "usage": out.get("usage"),
    }
    print(json.dumps(result, ensure_ascii=False, indent=2))


def cmd_ask(args):
    validate_noul_thresholds(args.noul_yes, args.noul_no)
    enforce_jev_model_guard(args.model, args.allow_paid)
    enforce_box_guard(args.model, args.type)

    questions = {}
    if args.questions is not None:
        try:
            q_obj = json.loads(args.questions)
        except json.JSONDecodeError as exc:
            die(f"Invalid --questions JSON: {exc}")
        if not isinstance(q_obj, dict):
            die("--questions must decode to a JSON object.")
        questions.update(q_obj)

    if args.questions_file is not None:
        try:
            with open(args.questions_file, "r", encoding="utf-8") as fh:
                qf_obj = json.load(fh)
        except (OSError, json.JSONDecodeError) as exc:
            die(f"Failed reading --questions-file '{args.questions_file}': {exc}")
        if not isinstance(qf_obj, dict):
            die("--questions-file must decode to a JSON object.")
        questions.update(qf_obj)

    has_cli_q = (
        args.question is not None
        or bool(args.option)
        or bool(args.level)
        or not questions
    )
    if has_cli_q:
        key = (args.key or "").strip()
        if not key:
            die("-k/--key must be non-empty.")
        questions[key] = build_single_question(
            args.type, args.question, args.option, args.level, args.model
        )

    check_questions_dict_guards(args.model, questions)

    state_sources = sum(
        x is not None for x in (args.state, args.state_file, args.state_json)
    )
    if state_sources > 1:
        die("Pass at most one of --state, --state-file, or --state-json.")

    if args.state is not None:
        state = args.state
    elif args.state_file is not None:
        if args.state_file == "-":
            state = sys.stdin.read()
        else:
            try:
                with open(args.state_file, "r", encoding="utf-8") as fh:
                    state = fh.read()
            except OSError as exc:
                die(f"Cannot read --state-file '{args.state_file}': {exc}")
    elif args.state_json is not None:
        try:
            state = json.loads(args.state_json)
        except json.JSONDecodeError as exc:
            die(f"Invalid --state-json: {exc}")
    elif not sys.stdin.isatty():
        piped = sys.stdin.read()
        if not piped.strip():
            die("Missing state: stdin was empty. Pass --state, --state-file, --state-json, or non-empty stdin.")
        state = piped.rstrip("\r\n")
    else:
        die("Missing state: pass --state, --state-file, --state-json, or pipe input via stdin.")

    req = {
        "model": args.model,
        "state": state,
        "questions": questions,
    }
    out = call_systemone(req, long_context=args.long_context)
    if args.raw:
        print(
            json.dumps(
                {
                    "model": out.get("model"),
                    "answers": out.get("answers"),
                    "usage": out.get("usage"),
                },
                ensure_ascii=False,
                indent=2,
            )
        )
        return

    raw_answers = out.get("answers") if isinstance(out.get("answers"), dict) else {}
    results = {
        k: annotate_answer(v, noul_yes=args.noul_yes, noul_no=args.noul_no)
        for k, v in raw_answers.items()
    }
    print(
        json.dumps(
            {
                "model": out.get("model"),
                "results": results,
                "usage": out.get("usage"),
            },
            ensure_ascii=False,
            indent=2,
        )
    )


def cmd_batch(args):
    validate_noul_thresholds(args.noul_yes, args.noul_no)
    enforce_jev_model_guard(args.model, args.allow_paid)
    enforce_box_guard(args.model, args.type)

    if args.chunk_size < 1 or args.chunk_size > 50:
        die(f"--chunk-size must be between 1 and 50 (got {args.chunk_size}).")

    if args.min_noul is not None:
        if args.type != "noul":
            die("--min-noul can only be used with --type noul.")
        if not (0.0 <= args.min_noul <= 1.0):
            die(f"--min-noul must be between 0.0 and 1.0 (got {args.min_noul}).")

    if not args.question or not args.question.strip():
        die("-q/--question is required for 'batch'.")

    template_q = build_single_question(
        args.type, args.question, args.option, args.level, args.model
    )

    if args.items_file is not None:
        if args.items_file == "-":
            raw_text = sys.stdin.read()
        else:
            try:
                with open(args.items_file, "r", encoding="utf-8") as fh:
                    raw_text = fh.read()
            except OSError as exc:
                die(f"Cannot read --items-file '{args.items_file}': {exc}")
    elif not sys.stdin.isatty():
        raw_text = sys.stdin.read()
    else:
        die("Missing items: pass --items-file <path> or pipe non-empty lines via stdin.")

    raw_lines = [ln.rstrip("\r\n") for ln in raw_text.splitlines() if ln.strip()]
    parsed_items = []
    for idx, line in enumerate(raw_lines):
        if args.jsonl:
            try:
                val = json.loads(line)
            except json.JSONDecodeError as exc:
                die(f"Invalid JSONL on non-empty item #{idx} (line: {line[:80]}): {exc}")
            item_text = val if isinstance(val, str) else json.dumps(val, ensure_ascii=False)
            parsed_items.append((idx, val, item_text))
        else:
            parsed_items.append((idx, line, line))

    total_items = len(parsed_items)
    if total_items == 0:
        print(
            json.dumps(
                {
                    "model": args.model,
                    "total_items": 0,
                    "returned_items": 0,
                    "items": [],
                    "usage": {"input_tokens": 0, "output_tokens": 0, "cost": 0},
                },
                ensure_ascii=False,
                indent=2,
            )
        )
        return

    q_text = args.question.strip()
    criteria = template_q.get("criteria")
    out_items = []
    total_in = 0
    total_out = 0
    total_cost = 0
    actual_model = args.model

    for start in range(0, total_items, args.chunk_size):
        chunk = parsed_items[start : start + args.chunk_size]
        chunk_questions = {}
        for idx, _orig, item_text in chunk:
            q_entry = {
                "type": args.type,
                "instructions": f"Item:\n{item_text}\n\nQuestion: {q_text}",
            }
            if criteria is not None:
                q_entry["criteria"] = criteria
            chunk_questions[f"item_{idx}"] = q_entry

        resp = call_systemone(
            {
                "model": args.model,
                "state": args.context,
                "questions": chunk_questions,
            },
            long_context=args.long_context,
        )
        if resp.get("model"):
            actual_model = resp["model"]
        usage = resp.get("usage") if isinstance(resp.get("usage"), dict) else {}
        total_in += usage.get("input_tokens", 0) or 0
        total_out += usage.get("output_tokens", 0) or 0
        c_val = usage.get("cost", 0) or 0
        total_cost += c_val

        answers = resp.get("answers") if isinstance(resp.get("answers"), dict) else {}
        for idx, orig_val, _item_text in chunk:
            ans = annotate_answer(
                answers.get(f"item_{idx}"),
                noul_yes=args.noul_yes,
                noul_no=args.noul_no,
            )
            if args.min_noul is not None:
                p = ans.get("noul") if isinstance(ans, dict) else None
                if not (isinstance(p, (int, float)) and not isinstance(p, bool) and p >= args.min_noul):
                    continue
            out_items.append({"index": idx, "item": orig_val, "answer": ans})

    if isinstance(total_cost, float) and total_cost == 0.0:
        total_cost = 0

    print(
        json.dumps(
            {
                "model": actual_model,
                "total_items": total_items,
                "returned_items": len(out_items),
                "items": out_items,
                "usage": {
                    "input_tokens": total_in,
                    "output_tokens": total_out,
                    "cost": total_cost,
                },
            },
            ensure_ascii=False,
            indent=2,
        )
    )


def verify_zen_free_model(model_id):
    if model_id.endswith("-free") or model_id == "big-pickle":
        return
    data, status, err = curl_json_get(MODELS_URL, max_time=20)
    if data is None:
        if status:
            die(f"Cannot verify free status for '{model_id}' (HTTP {status}): {err}")
        die(f"Cannot verify free status for '{model_id}': {err}")
    raw_list = data.get("data") if isinstance(data, dict) else data
    if isinstance(raw_list, list):
        for m in raw_list:
            if isinstance(m, dict) and m.get("id") == model_id:
                in_p, out_p = extract_model_prices(m)
                if is_zero_number(in_p) and is_zero_number(out_p):
                    return
                die(
                    f"Model '{model_id}' is a paid model on OpenCode Zen. "
                    "Use 'jev-zen.sh models' to pick a free model or pass --allow-paid."
                )
    die(
        f"Model '{model_id}' is not a recognized free model on OpenCode Zen. "
        "Use 'jev-zen.sh models' to list free models or pass --allow-paid."
    )


def cmd_zen(args):
    # Register any local secrets so they can never leak from subprocess output
    env_key = os.environ.get("OPENCODE_API_KEY", "").strip()
    if env_key:
        register_secret(env_key)
    load_stored_key()

    model_id = (args.model or "").strip()
    if model_id.startswith("opencode/"):
        model_id = model_id[len("opencode/") :]
    if not model_id:
        die("Model ID must be non-empty.")
    if model_id.startswith("jev-"):
        die(
            f"'{model_id}' is a SystemOne decision model, not a chat model. "
            "Use 'ask', 'run', or 'batch' instead of 'zen'."
        )

    if not args.allow_paid:
        verify_zen_free_model(model_id)

    prompt = " ".join(args.prompt).strip()
    if not prompt:
        die("Prompt must be non-empty.")

    if not sys.stdin.isatty():
        piped = sys.stdin.read()
        if piped.strip():
            prompt = f"{prompt}\n\n<stdin>\n{piped.rstrip(chr(13) + chr(10))}\n</stdin>"

    if shutil.which("opencode") is None:
        die("'opencode' CLI not found in PATH.")

    cmd = ["opencode", "run", "--standalone", "-m", f"opencode/{model_id}"]
    if args.format:
        cmd.extend(["--format", args.format])
    for fpath in args.file or []:
        cmd.extend(["-f", fpath])
    cmd.append(prompt)

    proc = subprocess.run(cmd, stdin=subprocess.DEVNULL, capture_output=True, text=True)
    out_s = scrub_secrets(proc.stdout or "")
    err_s = scrub_secrets(proc.stderr or "")
    combined = f"{out_s}\n{err_s}"

    if "api_key_expired" in combined or "This API key has expired" in combined:
        sys.stderr.write(
            "[jev-zen error] OpenCode Console API key in ~/.local/share/opencode/auth.json has expired. "
            "Renew it at https://opencode.ai/console/account#api-keys and run: opencode auth login\n"
        )
        sys.exit(1)

    if out_s:
        sys.stdout.write(out_s)
    if err_s:
        sys.stderr.write(err_s)
    if proc.returncode != 0:
        sys.exit(proc.returncode)


def build_parser():
    p = argparse.ArgumentParser(
        prog="jev-zen.sh",
        description="Zero-cost TypeSafe Jev 1.13 System-1 decisions and OpenCode Zen free-model runner.",
    )
    sub = p.add_subparsers(dest="subcommand", required=True)

    # 1. doctor
    p_doc = sub.add_parser(
        "doctor",
        help="Check curl, opencode CLI, API key status, and live jev-1.13-free health.",
    )
    p_doc.set_defaults(func=cmd_doctor)

    # 2. models
    p_mod = sub.add_parser(
        "models",
        help="List jev-1.13-free and current zero-cost models from OpenCode Zen.",
    )
    p_mod.add_argument("--json", action="store_true", help="Output JSON array instead of table.")
    p_mod.set_defaults(func=cmd_models)

    # 3. run
    p_run = sub.add_parser(
        "run",
        help="Execute raw SystemOne JSON request ({state, questions, [model]}) from file or '-'.",
    )
    p_run.add_argument("request", help="Path to request.json, or '-' for stdin.")
    p_run.add_argument(
        "--long-context",
        action="store_true",
        help="Send TypeSafe-Danger-Zone-Long-Context: true header (up to 262k tokens).",
    )
    p_run.add_argument("--allow-paid", action="store_true", help="Allow non-'-free' models.")
    p_run.set_defaults(func=cmd_run)

    # 4. ask
    p_ask = sub.add_parser(
        "ask",
        help="Ask one or more calibrated noul/choice/score questions on a state.",
    )
    p_ask.add_argument("-m", "--model", default=DEFAULT_JEV_MODEL, help="SystemOne model ID (default: jev-1.13-free).")
    p_ask.add_argument("--allow-paid", action="store_true", help="Allow non-'-free' models.")
    p_ask.add_argument(
        "--long-context",
        action="store_true",
        help="Enable long context up to 262k tokens.",
    )
    p_ask.add_argument("--raw", action="store_true", help="Return raw SystemOne answers without verdict/top_level.")
    p_ask.add_argument("--noul-yes", type=float, default=0.7, help="Threshold above which noul verdict is 'yes' (default: 0.7).")
    p_ask.add_argument("--noul-no", type=float, default=0.3, help="Threshold below which noul verdict is 'no' (default: 0.3).")
    p_ask.add_argument("--state", help="Inline text state.")
    p_ask.add_argument("--state-file", help="Path to UTF-8 file containing state (or '-' for stdin).")
    p_ask.add_argument("--state-json", help="JSON string for structured object/array state.")
    p_ask.add_argument("-q", "--question", help="Question instructions.")
    p_ask.add_argument("-k", "--key", default="result", help="Question key in output (default: result).")
    p_ask.add_argument(
        "-t",
        "--type",
        default="noul",
        metavar="noul|choice|score",
        help="Question primitive: noul, choice, or score (default: noul).",
    )
    p_ask.add_argument(
        "-o",
        "--option",
        action="append",
        default=[],
        metavar="NAME=DESC",
        help="Option entry (repeatable, split on first '='). Required (>=2) for choice; optional true=/false= for noul.",
    )
    p_ask.add_argument(
        "-l",
        "--level",
        action="append",
        default=[],
        metavar="DESC",
        help="Ordered scale level description (repeatable, 2..10 entries for score).",
    )
    p_ask.add_argument("--questions", help="Full questions JSON map string.")
    p_ask.add_argument("--questions-file", help="Path to JSON file containing questions map.")
    p_ask.set_defaults(func=cmd_ask)

    # 5. batch
    p_bat = sub.add_parser(
        "batch",
        help="Evaluate a list of lines or JSONL items in parallel SystemOne question chunks.",
    )
    p_bat.add_argument("--items-file", help="Path to items file (one item per non-empty line, or '-' for stdin).")
    p_bat.add_argument("--jsonl", action="store_true", help="Parse each non-empty line as JSON.")
    p_bat.add_argument("--context", default="Batch item evaluation.", help="Shared state context string.")
    p_bat.add_argument("-q", "--question", required=False, help="Question instructions applied to every item (required).")
    p_bat.add_argument(
        "-t",
        "--type",
        default="noul",
        metavar="noul|choice|score",
        help="Question primitive: noul, choice, or score (default: noul).",
    )
    p_bat.add_argument(
        "-o",
        "--option",
        action="append",
        default=[],
        metavar="NAME=DESC",
        help="Option entry (repeatable, split on first '=').",
    )
    p_bat.add_argument(
        "-l",
        "--level",
        action="append",
        default=[],
        metavar="DESC",
        help="Ordered scale level description (repeatable, 2..10 entries for score).",
    )
    p_bat.add_argument("--chunk-size", type=int, default=25, help="Items per SystemOne request (default: 25, max: 50).")
    p_bat.add_argument("--min-noul", type=float, help="Filter output to items with noul >= threshold.")
    p_bat.add_argument("--noul-yes", type=float, default=0.7, help="Threshold above which noul verdict is 'yes' (default: 0.7).")
    p_bat.add_argument("--noul-no", type=float, default=0.3, help="Threshold below which noul verdict is 'no' (default: 0.3).")
    p_bat.add_argument("--long-context", action="store_true", help="Enable long context up to 262k tokens.")
    p_bat.add_argument("-m", "--model", default=DEFAULT_JEV_MODEL, help="SystemOne model ID (default: jev-1.13-free).")
    p_bat.add_argument("--allow-paid", action="store_true", help="Allow non-'-free' models.")
    p_bat.set_defaults(func=cmd_batch)

    # 6. zen
    p_zen = sub.add_parser(
        "zen",
        help="Run a free chat/reasoning model on OpenCode Zen via 'opencode run --standalone'.",
    )
    p_zen.add_argument(
        "-m",
        "--model",
        default=DEFAULT_ZEN_MODEL,
        help=f"OpenCode Zen model ID (default: {DEFAULT_ZEN_MODEL}; optional 'opencode/' prefix stripped).",
    )
    p_zen.add_argument("-f", "--file", action="append", default=[], help="Attach file to prompt (repeatable).")
    p_zen.add_argument("--format", choices=["default", "json"], default="default", help="Output format (default or json).")
    p_zen.add_argument("--allow-paid", action="store_true", help="Bypass free-model guard.")
    p_zen.add_argument("prompt", nargs="+", help="Prompt text.")
    p_zen.set_defaults(func=cmd_zen, _zen_parser=p_zen)

    return p, p_zen


def main():
    parser, p_zen = build_parser()
    if len(sys.argv) >= 2 and sys.argv[1] == "zen":
        args = p_zen.parse_intermixed_args(sys.argv[2:])
        cmd_zen(args)
        return
    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
PY
)

exec python3 -c "$PY_SCRIPT" "$@"
