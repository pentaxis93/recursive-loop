#!/usr/bin/env bash
# plugins/cosmic-janitor/hooks-handlers/session-start.sh

# 1. Resolve Paths
# We need to find where the script is running to locate the assets.
# This ensures it works regardless of where the command is called from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
ASSETS_DIR="$PLUGIN_ROOT/assets"
COSMOLOGY_FILE="$ASSETS_DIR/cosmology.md"

# 2. Safety Check
if [[ ! -f "$COSMOLOGY_FILE" ]]; then
  # Fail gracefully if the philosophy is missing
  echo "{\"error\": \"Cosmology file not found at $COSMOLOGY_FILE\"}"
  exit 1
fi

# 3. Read Content
CONTENT=$(cat "$COSMOLOGY_FILE")

# 4. Construct JSON Payload
# Use jq if available, otherwise fall back to pure bash
if command -v jq &>/dev/null; then
  jq -n --arg context "$CONTENT" \
    '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":$context}}'
else
  # Pure bash fallback: escape JSON special characters
  escaped="${CONTENT//\\/\\\\}"
  escaped="${escaped//\"/\\\"}"
  escaped="${escaped//$'\n'/\\n}"
  escaped="${escaped//$'\t'/\\t}"
  escaped="${escaped//$'\r'/\\r}"
  printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$escaped"
fi

exit 0
