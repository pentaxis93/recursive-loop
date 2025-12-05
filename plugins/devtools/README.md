# devtools

Developer tools for Claude Code customization.

## Installation

```
/plugin marketplace add pentaxis93/recursive-loop
/plugin install devtools@pentaxis93
```

## Tools

### Status Line

A minimal status line that shows:
- **Model** - Current Claude model (opus, sonnet, haiku)
- **Working Directory** - Full path to current directory

Output example:
```
opus /home/user/projects/my-app
```

#### Setup

Invoke the skill:
- "setup statusline"
- "configure status line"
- "devtools statusline"

The skill will:
1. Copy the status line script to `~/.claude/statusline.sh`
2. Configure `~/.claude/settings.json`
3. Restart Claude Code to activate

#### Revert

To disable the custom status line:
1. Remove `statusLine` from `~/.claude/settings.json`
2. Delete `~/.claude/statusline.sh` (optional)

## Dependencies

- `jq` (JSON processor) - required for the status line script
