#!/bin/bash
cd /Users/trungtranngoc/.gemini/config/skills

# Add all changes except the non-skill symlinks
git add --all -- ':!agents' ':!ars' ':!codex' ':!references' ':!scripts'

# Commit and push if there are changes
if ! git diff --cached --quiet; then
    git commit -m "chore(auto): update skills $(date +'%Y-%m-%d %H:%M')"
    git push origin main
fi
