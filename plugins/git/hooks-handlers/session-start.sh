#!/usr/bin/env bash
# plugins/git/hooks-handlers/session-start.sh
#
# Injects git status and branch lifecycle methodology at session start.

set -euo pipefail

# 1. Resolve Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
METHODOLOGY_FILE="$PLUGIN_ROOT/assets/branch-lifecycle.md"

# 2. Check if in a git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  # Not a git repo - output methodology only
  if [[ -f "$METHODOLOGY_FILE" ]]; then
    CONTENT=$(cat "$METHODOLOGY_FILE")
  else
    CONTENT="Git methodology file not found."
  fi

  if command -v jq &>/dev/null; then
    jq -n --arg context "$CONTENT" \
      '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":$context}}'
  else
    escaped="${CONTENT//\\/\\\\}"
    escaped="${escaped//\"/\\\"}"
    escaped="${escaped//$'\n'/\\n}"
    escaped="${escaped//$'\t'/\\t}"
    escaped="${escaped//$'\r'/\\r}"
    printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$escaped"
  fi
  exit 0
fi

# 3. Gather Git Status
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")

# Ahead/behind tracking
UPSTREAM=$(git rev-parse --abbrev-ref "@{upstream}" 2>/dev/null || echo "")
if [[ -n "$UPSTREAM" ]]; then
  AHEAD=$(git rev-list --count "@{upstream}..HEAD" 2>/dev/null || echo "0")
  BEHIND=$(git rev-list --count "HEAD..@{upstream}" 2>/dev/null || echo "0")
  TRACKING_INFO="ahead $AHEAD, behind $BEHIND"
else
  TRACKING_INFO="no upstream"
fi

# Working tree status
MODIFIED=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
STAGED=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

# Stale branches (merged into default branch but not deleted)
# Note: grep -v returns 1 if no matches, so we use { ... || true; } to avoid set -e exit
STALE_BRANCHES=$({ git branch --merged "$DEFAULT_BRANCH" 2>/dev/null | grep -v "^\*" | grep -v "$DEFAULT_BRANCH" || true; } | wc -l | tr -d ' ')

# 4. Build Status Block
STATUS_BLOCK="═══════════════════════════════════════════
GIT STATUS
═══════════════════════════════════════════
Branch: $CURRENT_BRANCH ($TRACKING_INFO)
Working tree: $MODIFIED modified, $STAGED staged, $UNTRACKED untracked
Stale branches: $STALE_BRANCHES (merged but not deleted)
═══════════════════════════════════════════"

# 5. Add warning if on default branch
if [[ "$CURRENT_BRANCH" == "$DEFAULT_BRANCH" || "$CURRENT_BRANCH" == "main" || "$CURRENT_BRANCH" == "master" ]]; then
  STATUS_BLOCK="$STATUS_BLOCK

⚠️  WARNING: On $CURRENT_BRANCH branch. Create a feature branch before making code changes."
fi

# 6. Add warning if dirty working tree
if [[ "$MODIFIED" -gt 0 || "$STAGED" -gt 0 || "$UNTRACKED" -gt 0 ]]; then
  STATUS_BLOCK="$STATUS_BLOCK

⚠️  UNCOMMITTED CHANGES: Commit or stash before starting new work."
fi

# 7. Read methodology
if [[ -f "$METHODOLOGY_FILE" ]]; then
  METHODOLOGY=$(cat "$METHODOLOGY_FILE")
else
  METHODOLOGY="Git methodology file not found at $METHODOLOGY_FILE"
fi

# 8. Combine status + methodology
FULL_CONTENT="$STATUS_BLOCK

$METHODOLOGY"

# 9. Output JSON
if command -v jq &>/dev/null; then
  jq -n --arg context "$FULL_CONTENT" \
    '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":$context}}'
else
  escaped="${FULL_CONTENT//\\/\\\\}"
  escaped="${escaped//\"/\\\"}"
  escaped="${escaped//$'\n'/\\n}"
  escaped="${escaped//$'\t'/\\t}"
  escaped="${escaped//$'\r'/\\r}"
  printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$escaped"
fi

exit 0
