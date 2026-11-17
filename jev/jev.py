#!/usr/bin/env python3
"""Call Jev (OpenRouter Decisions API). Usage: python jev.py request.json [path/to/.env]
Request JSON: {"state": ..., "questions": {...}}  (model defaults to typesafe/jev-1.14).
Reads OPENROUTER_API_KEY from the .env (default: ./.env). Never prints the key."""
import json, os, sys, urllib.request, urllib.error

URL = "https://openrouter.ai/api/alpha/decisions"
MODEL = "typesafe/jev-1.14"


def load_key(env_path):
    key = os.environ.get("OPENROUTER_API_KEY")
    if os.path.exists(env_path):
        for line in open(env_path, encoding="utf-8"):
            line = line.strip()
            if line.startswith("OPENROUTER_API_KEY="):
                key = line.split("=", 1)[1].strip().strip('"').strip("'")
    if not key:
        sys.exit("OPENROUTER_API_KEY not found")
    return key


def main():
    req = json.load(open(sys.argv[1], encoding="utf-8"))
    req.setdefault("model", MODEL)
    key = load_key(sys.argv[2] if len(sys.argv) > 2 else ".env")
    r = urllib.request.Request(
        URL, data=json.dumps(req).encode("utf-8"), method="POST",
        headers={"Authorization": "Bearer " + key, "Content-Type": "application/json"})
    try:
        with urllib.request.urlopen(r, timeout=60) as resp:
            out = json.load(resp)
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", "replace")[:500].replace(key, "***")
        sys.exit(f"HTTP {e.code}: {body}")
    print(json.dumps({k: out.get(k) for k in ("model", "answers", "usage")},
                     ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
