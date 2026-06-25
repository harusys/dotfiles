#!/bin/bash
# Claude Code statusline: dir + git branch/status + context bar + session cost.
# Note: Enterprise monthly usage limits are NOT exposed to the statusline
# (rate_limits JSON is Pro/Max only; no CLI/file/API). Use /usage for real figures.
set -euo pipefail

input=$(cat)
jqr() { printf '%s' "$input" | jq -r "$1" 2>/dev/null; }

GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
RESET='\033[0m'

# 1) Directory (basename)
DIR=$(jqr '.workspace.current_dir // .cwd // ""')
DIR="${DIR%/}"            # strip trailing slash if any
dir_disp="${DIR##*/}"

# 2) Git branch + status (docs "Git status with colors" example)
git_seg=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    GIT_STATUS=""
    [ "$STAGED" -gt 0 ] && GIT_STATUS="${GREEN}+${STAGED}${RESET}"
    [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${YELLOW}~${MODIFIED}${RESET}"
    git_seg=" | 🌿 ${BRANCH} ${GIT_STATUS}"
fi

# 3) Context usage bar (color-coded, NO label)
pct=$(jqr '(.context_window.used_percentage // 0) | floor')
[ -z "$pct" ] && pct=0
[ "$pct" -gt 100 ] && pct=100
[ "$pct" -lt 0 ] && pct=0
width=10; filled=$(( pct * width / 100 )); empty=$(( width - filled )); bar=""
for ((i=0; i<filled; i++)); do bar="${bar}█"; done
for ((i=0; i<empty;  i++)); do bar="${bar}░"; done
if   [ "$pct" -lt 50 ]; then ccol="$GREEN"
elif [ "$pct" -lt 80 ]; then ccol="$YELLOW"
else                          ccol="$RED"
fi
ctx="  ${ccol}⛁ [${bar}] ${pct}%${RESET}"

# 4) Session cost ($) — JSON cost.total_cost_usd
cost=$(jqr '.cost.total_cost_usd // 0')
cost_disp=$(printf '$%.2f' "$cost" 2>/dev/null || echo '$0.00')

# Output (single line; %b interprets \033 escape sequences)
printf '%b' "${dir_disp}${git_seg}${ctx}  💰 ${cost_disp}"
