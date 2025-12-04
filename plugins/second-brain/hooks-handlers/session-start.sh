#!/usr/bin/env bash
# plugins/second-brain/hooks-handlers/session-start.sh

# 1. Resolve Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
ASSETS_DIR="$PLUGIN_ROOT/assets"
VAULT_OPS_FILE="$ASSETS_DIR/vault-ops.md"

# 2. Safety Check
if [[ ! -f "$VAULT_OPS_FILE" ]]; then
  echo "{\"error\": \"Vault ops file not found at $VAULT_OPS_FILE\"}"
  exit 1
fi

# 3. Read Content
CONTENT=$(cat "$VAULT_OPS_FILE")

# 4. Construct JSON Payload
if command -v jq &>/dev/null; then
  jq -n --arg context "$CONTENT" \
    '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":$context}}'
else
  # Pure bash fallback
  escaped="${CONTENT//\\/\\\\}"
  escaped="${escaped//\"/\\\"}"
  escaped="${escaped//$'\n'/\\n}"
  escaped="${escaped//$'\t'/\\t}"
  escaped="${escaped//$'\r'/\\r}"
  printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$escaped"
fi

exit 0
