---
description: Configure Claude Code status line showing model and working directory
---

# Status Line Setup

Install the devtools status line that displays the current model and working directory.

---

## Execute

### 1. Locate Plugin Assets

Find the statusline script:

```text
{{CLAUDE_PLUGIN_ROOT}}/assets/statusline.sh
```

If not found at plugin path, use:

```text
~/.claude/plugins/devtools/assets/statusline.sh
```

### 2. Install Script

Copy the statusline script to user config:

```bash
cp {{source_path}} ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

### 3. Update Settings

Read `~/.claude/settings.json`. If it doesn't exist, create it.

Add or update the `statusLine` key:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

Preserve any existing settings when updating.

### 4. Confirm

Output:

```text
Status line configured.

Display: [model] [working directory]
Script:  ~/.claude/statusline.sh
Config:  ~/.claude/settings.json

Restart Claude Code to activate.
```

---

## Revert

To remove the status line:

1. Delete the `statusLine` key from `~/.claude/settings.json`
2. Optionally delete `~/.claude/statusline.sh`
