#!/usr/bin/env bash
# plugins/construct/hooks-handlers/system-pulse.sh
#
# System Self-Remembering Pulse
# Light awareness check at session start (~2 seconds)
# Requires: second-brain plugin with setupComplete: true

set -euo pipefail

# 1. Check for brain-config.json
CONFIG_FILE="$HOME/.claude/brain-config.json"

if [[ ! -f "$CONFIG_FILE" ]]; then
  # No second-brain configured, exit silently
  exit 0
fi

# 2. Parse config (requires jq)
if ! command -v jq &>/dev/null; then
  exit 0
fi

SETUP_COMPLETE=$(jq -r '.setupComplete // false' "$CONFIG_FILE" 2>/dev/null || echo "false")
BRAIN_FOLDER=$(jq -r '.brainFolder // ""' "$CONFIG_FILE" 2>/dev/null || echo "")

# 3. Guard: Only run if setup is complete
if [[ "$SETUP_COMPLETE" != "true" ]] || [[ -z "$BRAIN_FOLDER" ]]; then
  exit 0
fi

# 4. Resolve vault path
if [[ "$BRAIN_FOLDER" == /* ]]; then
  VAULT_PATH="$BRAIN_FOLDER"
else
  # Relative path - find .obsidian directory
  OBSIDIAN_DIRS=$(find "$HOME" -maxdepth 4 -type d -name ".obsidian" 2>/dev/null | head -5)
  VAULT_PATH=""
  for dir in $OBSIDIAN_DIRS; do
    parent=$(dirname "$dir")
    if [[ -d "$parent/$BRAIN_FOLDER" ]]; then
      VAULT_PATH="$parent/$BRAIN_FOLDER"
      break
    fi
  done

  if [[ -z "$VAULT_PATH" ]]; then
    exit 0
  fi
fi

# 5. Count artifacts
FRAMEWORKS_DIR="$VAULT_PATH/05-knowledge/consolidated"
PATTERNS_DIR="$VAULT_PATH/05-knowledge/patterns"
HEALTH_DIR="$VAULT_PATH/archives/intelligence/system-health"
PERMANENT_DIR="$VAULT_PATH/permanent-notes"

FRAMEWORK_COUNT=0
PATTERN_COUNT=0
PERMANENT_COUNT=0

if [[ -d "$FRAMEWORKS_DIR" ]]; then
  FRAMEWORK_COUNT=$(find "$FRAMEWORKS_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
fi

if [[ -d "$PATTERNS_DIR" ]]; then
  PATTERN_COUNT=$(find "$PATTERNS_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
fi

if [[ -d "$PERMANENT_DIR" ]]; then
  PERMANENT_COUNT=$(find "$PERMANENT_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
fi

# 6. Check last observation date (portable for macOS and Linux)
LAST_OBSERVATION="never"
WEEKS_AGO="--"

if [[ -d "$HEALTH_DIR" ]]; then
  LATEST_OBS=$(find "$HEALTH_DIR" -name "observe-system-*.md" 2>/dev/null | sort -r | head -1)
  if [[ -n "$LATEST_OBS" ]]; then
    # Extract date from filename
    OBS_DATE=$(basename "$LATEST_OBS" | sed 's/observe-system-\(.*\)\.md/\1/')
    LAST_OBSERVATION="$OBS_DATE"

    # Calculate weeks ago (portable)
    NOW_EPOCH=$(date +%s)
    if [[ "$(uname)" == "Darwin" ]]; then
      # macOS
      OBS_EPOCH=$(date -j -f "%Y-%m-%d" "$OBS_DATE" +%s 2>/dev/null || echo "0")
    else
      # Linux
      OBS_EPOCH=$(date -d "$OBS_DATE" +%s 2>/dev/null || echo "0")
    fi

    if [[ "$OBS_EPOCH" -gt 0 ]]; then
      DAYS_AGO=$(( (NOW_EPOCH - OBS_EPOCH) / 86400 ))
      WEEKS_AGO=$(( DAYS_AGO / 7 ))
    fi
  fi
fi

# 7. Determine health status
HEALTH_STATUS="Healthy"
ATTENTION_REASON=""

if [[ "$WEEKS_AGO" == "--" ]] || [[ "$WEEKS_AGO" -gt 4 ]]; then
  HEALTH_STATUS="Attention Needed"
  if [[ "$WEEKS_AGO" == "--" ]]; then
    ATTENTION_REASON="No system observation on record"
  else
    ATTENTION_REASON="Last observation was ${WEEKS_AGO} weeks ago"
  fi
fi

# 8. Build output
PULSE_OUTPUT="System Pulse: ${HEALTH_STATUS}
Artifacts: ${FRAMEWORK_COUNT} frameworks, ${PATTERN_COUNT} patterns, ${PERMANENT_COUNT} permanent notes
Last observed: ${LAST_OBSERVATION} (${WEEKS_AGO} weeks ago)"

if [[ -n "$ATTENTION_REASON" ]]; then
  PULSE_OUTPUT="${PULSE_OUTPUT}

${ATTENTION_REASON}
[Run \`observe system\` for full analysis]"
fi

# 9. Output JSON for hook system
jq -n --arg context "$PULSE_OUTPUT" \
  '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":$context}}'

exit 0
