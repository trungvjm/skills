---
name: andrej-karpathy
description: "Behavioral guidelines to reduce common LLM coding mistakes. Use when writing, reviewing, or refactoring code to avoid overcomplication, make surgical changes, surface assumptions, and define verifiable success criteria. Alias gọi nhanh: /andrej-karpathy, /karpathy"
---

# Karpathy Guidelines

Behavioral guidelines to reduce common LLM coding mistakes, derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## When to Use This Skill

- Use when writing, reviewing, or refactoring code with an LLM.
- Use when a change needs to stay surgical and avoid speculative abstractions.
- Use when assumptions, tradeoffs, and verification criteria should be made explicit.
- Use when code has become overcomplicated and needs to be simplified.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be done in 20, rewrite it.
- Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Focus on the task at hand. Avoid drive-by changes.**

- Do not refactor unrelated code.
- Do not fix formatting or style issues in untouched lines unless requested.
- Keep edits localized and minimal to reduce merge conflicts and regression risks.

## 4. Goal-Driven Execution

**Define clear, verifiable success criteria before writing code.**

- Establish how to test the change before writing it.
- If fixing a bug, write a test that reproduces it first (if feasible), then fix it.
- Verify changes systematically using automated tests or specific validation steps.
