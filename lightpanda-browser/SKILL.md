---
name: lightpanda-browser
description: Headless browser automation using agent-browser with Lightpanda as the preferred engine. Use when the task involves fetching pages, scraping, browser automation, web interaction, or any headless browser task. Lightpanda is 11x faster and 9x less memory than Chrome. Falls back to Chrome automatically when Lightpanda limitations apply. Handles install detection and setup for both agent-browser and Lightpanda. Triggers on "fetch this page", "scrape", "browse", "open URL", "click", "fill form", "screenshot", "extract data", "browser automation", or any web interaction task.
allowed-tools: Bash(agent-browser *), Bash(npx agent-browser *), Bash(lightpanda *), Bash(which *), Bash(curl *), Bash(brew *), Bash(npm *), Bash(docker *)
---

# Lightpanda Browser Skill

Headless browser automation powered by [agent-browser](https://github.com/vercel-labs/agent-browser) with [Lightpanda](https://lightpanda.io) as the preferred engine. Lightpanda is a headless browser built from scratch in Zig — 11x faster execution and 9x less memory than Chrome.

## Step 0: Install Check (Run Before Any Browser Task)

Always verify both tools are present before starting work.

```bash
# Check agent-browser
which agent-browser 2>/dev/null && echo "AB:OK" || echo "AB:MISSING"

# Check Lightpanda
which lightpanda 2>/dev/null && echo "LP:OK" || echo "LP:MISSING"
```

### Install agent-browser (if missing)

```bash
# Option 1: npm (recommended)
npm install -g agent-browser

# Option 2: Homebrew
brew install agent-browser

# After installing, download the Chrome engine (needed for Chrome fallback)
agent-browser install
```

### Install Lightpanda (if missing)

Detect platform and install:

```bash
ARCH=$(uname -m)
OS=$(uname -s)

if [[ "$OS" == "Darwin" ]]; then
  # macOS (Apple Silicon / aarch64)
  curl -L -o /usr/local/bin/lightpanda \
    https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos
  chmod a+x /usr/local/bin/lightpanda

elif [[ "$OS" == "Linux" ]]; then
  # Linux x86_64 (also works in WSL2)
  curl -L -o /usr/local/bin/lightpanda \
    https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux
  chmod a+x /usr/local/bin/lightpanda

else
  # Unsupported platform — use Docker
  echo "Binary not available for this platform. Use Docker:"
  echo "docker run -d --name lightpanda -p 9222:9222 lightpanda/browser:nightly"
fi

# Verify
lightpanda version
```

## Step 1: Engine Selection

Pick the engine before every task. Default to Lightpanda. Fall back to Chrome only when required.

```
Does the task require any of:
  - Browser extensions          → Chrome
  - Persistent browser profiles → Chrome
  - State files / session restore → Chrome
  - Local file:// access        → Chrome
  - iOS Simulator               → Chrome
  - Auth vault (agent-browser auth login) → Chrome
  OTHERWISE → Lightpanda
```

```bash
# Set engine for the session (do this once, use for all commands)
export AGENT_BROWSER_ENGINE=lightpanda   # preferred
# or
export AGENT_BROWSER_ENGINE=chrome       # when required
```

## Core Workflow

Every browser task follows this pattern:

```bash
export AGENT_BROWSER_ENGINE=lightpanda

# 1. Navigate
agent-browser open https://example.com

# 2. Wait for load (always do this on JS-heavy sites)
agent-browser wait --load networkidle

# 3. Snapshot interactive elements (compact, low token cost)
agent-browser snapshot -i
# Output: @e1 [button] "Sign In", @e2 [input] "Email", @e3 [link] "Home"

# 4. Interact using refs
agent-browser fill @e2 "user@example.com"
agent-browser click @e1

# 5. Re-snapshot after navigation (refs are invalidated on page change)
agent-browser wait --load networkidle
agent-browser snapshot -i
```

## Read-Only Fetching (No agent-browser Needed)

For tasks that only need to read a page without interaction, use the Lightpanda CLI directly — faster and zero overhead:

```bash
# Semantic tree (most token-efficient — best for AI reasoning)
lightpanda fetch --dump semantic_tree_text https://example.com

# Markdown (good for reading content)
lightpanda fetch --dump markdown https://example.com

# Markdown stripped of JS/CSS noise (cleanest for articles)
lightpanda fetch --dump markdown --strip_mode full https://example.com

# HTML (full DOM — only when you need it)
lightpanda fetch --dump html https://example.com

# Wait for JS rendering before dump
lightpanda fetch --dump markdown --wait_until networkidle https://example.com

# With explicit wait time (ms)
lightpanda fetch --dump markdown --wait_ms 3000 https://example.com
```

## Lightpanda Limitations

Lightpanda is in Beta. These features are **not supported** — use Chrome for them:

| Feature | Status | Workaround |
|---|---|---|
| Browser extensions (`--extension`) | Not supported | Use Chrome |
| Persistent profiles (`--profile`) | Not supported | Use Chrome |
| State files / session restore | Not supported | Use Chrome |
| Local file access (`file://`) | Not supported | Use Chrome |
| iOS Simulator (`-p ios`) | Not supported | Use Chrome |
| Auth vault (`agent-browser auth login`) | Not supported | Use Chrome |
| Complex visual rendering / CSS screenshots | Partial | Use Chrome if quality matters |
| Sites with heavy fingerprint-based anti-bot | May fail | Use Chrome |

Lightpanda fully supports:
- Navigation, JS execution (V8), DOM interaction
- XHR, Fetch, Ajax, dynamic content
- Click, fill, keyboard, form submission
- Cookies, custom headers, proxy support
- Network interception, `robots.txt` obey mode
- CDP/WebSocket (compatible with Playwright, Puppeteer, chromedp)

## Chrome Fallback

When Lightpanda can't handle a task, switch cleanly:

```bash
# Close Lightpanda session
agent-browser close

# Retry with Chrome
export AGENT_BROWSER_ENGINE=chrome
agent-browser open https://example.com
agent-browser snapshot -i
```

Or detect at task start:

```bash
# Set engine based on task requirements
NEEDS_EXTENSIONS=false
NEEDS_PROFILE=false
NEEDS_STATE=false

if $NEEDS_EXTENSIONS || $NEEDS_PROFILE || $NEEDS_STATE; then
  export AGENT_BROWSER_ENGINE=chrome
else
  export AGENT_BROWSER_ENGINE=lightpanda
fi
```

## Context Efficiency

Avoid flooding context with large page dumps. Use targeted extraction:

```bash
# BAD: dumps entire accessibility tree (high token cost)
agent-browser snapshot

# GOOD: only interactive elements
agent-browser snapshot -i

# BETTER: scope to a specific section
agent-browser snapshot -i -s "#main-content"

# Cap output size (prevents runaway large pages)
export AGENT_BROWSER_MAX_OUTPUT=15000
```

Output format token cost comparison:

| Method | Cost | Best for |
|---|---|---|
| `lightpanda fetch --dump semantic_tree_text` | Very low | AI reasoning, navigation |
| `lightpanda fetch --dump markdown --strip_mode full` | Low | Article content |
| `agent-browser snapshot -i` | Low | Finding interactive elements |
| `lightpanda fetch --dump markdown` | Medium | General content reading |
| `agent-browser snapshot` | High | Full accessibility tree |
| `lightpanda fetch --dump html` | High | DOM debugging |

## CDP Server Mode (Playwright / Puppeteer)

Start Lightpanda as a CDP server for use with Playwright, Puppeteer, or chromedp:

```bash
# Start server in background
lightpanda serve --host 127.0.0.1 --port 9222 &

# Connect via agent-browser
agent-browser --cdp 9222 open https://example.com
agent-browser --cdp 9222 snapshot -i

# Or connect Puppeteer directly
# const browser = await puppeteer.connect({ browserWSEndpoint: "ws://127.0.0.1:9222" });
```

When using `agent-browser --engine lightpanda`, the CDP server is managed automatically.

## Docker Mode

When binary install isn't possible:

```bash
docker run -d --name lightpanda -p 9222:9222 lightpanda/browser:nightly

# Connect agent-browser to it
export AGENT_BROWSER_ENGINE=lightpanda
agent-browser --cdp 9222 open https://example.com
```

## Common Patterns

### Scrape JS-rendered content

```bash
lightpanda fetch --dump markdown --wait_until networkidle \
  --strip_mode full https://example.com/article
```

### Form automation

```bash
export AGENT_BROWSER_ENGINE=lightpanda
agent-browser open https://example.com/contact
agent-browser wait --load networkidle
agent-browser snapshot -i
agent-browser fill @e1 "Jane Doe"
agent-browser fill @e2 "jane@example.com"
agent-browser fill @e3 "Hello!"
agent-browser click @e4
agent-browser wait --load networkidle
agent-browser snapshot -i  # verify success
```

### Extract links

```bash
export AGENT_BROWSER_ENGINE=lightpanda
agent-browser open https://example.com
agent-browser eval 'JSON.stringify(Array.from(document.querySelectorAll("a")).map(a=>a.href))'
```

### Screenshot (Chrome only for quality)

```bash
export AGENT_BROWSER_ENGINE=chrome  # Lightpanda visual rendering is partial
agent-browser open https://example.com
agent-browser wait --load networkidle
agent-browser screenshot --full
```

### Behind a proxy

```bash
lightpanda fetch --http_proxy http://proxy:8080 --dump markdown https://example.com
# or
agent-browser --engine lightpanda --proxy http://proxy:8080 open https://example.com
```

## Error Handling

If Lightpanda fails or produces unexpected output:

1. Check if the site uses unsupported features (see limitations table above)
2. Add `--wait_until networkidle` — JS-heavy sites need more time
3. Add `--wait_ms 5000` for slow-loading pages
4. Use `--log_level info --log_format pretty` to debug
5. Fall back to Chrome: `export AGENT_BROWSER_ENGINE=chrome`
6. Report the issue: https://github.com/lightpanda-io/browser/issues

Lightpanda is Beta software. Chrome is always the safety net.
