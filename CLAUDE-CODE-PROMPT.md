# Marketplace Remediation Plan: pentaxis93/claude-code-plugins

You are performing final remediation on the `pentaxis93` Claude Code plugin marketplace before publication. The repository is `claude-code-plugins` and contains the `cosmic-janitor` plugin.

Execute the following tasks in order. Complete each task fully before moving to the next. After completing all tasks, report what was done.

---

## Critical Issues (Complete First)

**No critical issues found.** All JSON files parse correctly, referenced paths exist, and the core functionality is intact.

---

## High Priority Improvements

### Task 1: Fix command syntax in TROUBLESHOOTING.md

**File:** `plugins/cosmic-janitor/TROUBLESHOOTING.md`

**Issue:** Uses `claude plugin list` (external CLI syntax) instead of `/plugin list` (Claude Code slash command). Users run these commands *inside* Claude Code, not from a terminal.

**Action:** Replace all instances of `claude plugin list` with the correct slash command format.

**Corrected content for lines 13-17:**

```markdown
### 1. Is the plugin installed?

Run inside Claude Code:
```
/plugin list
```

**Expected output**: `cosmic-janitor` appears in the list as enabled.
```

**Corrected content for lines 73-78:**

```markdown
3. **Check Global vs. Project:**
   Did you install it globally or for the current project?
   Run inside Claude Code:
   ```
   /plugin list
   ```
```

**Corrected content for lines 177-180:**

```markdown
**Before Reporting:**
1. Run `/reset` to clear context.
2. Verify you are not experiencing [Behavior Shock](#behavior-shock).
3. Run `/plugin list` to confirm the plugin is enabled and current.
```

---

### Task 2: Add $schema to plugin.json

**File:** `plugins/cosmic-janitor/.claude-plugin/plugin.json`

**Issue:** Missing JSON schema reference for IDE validation, unlike marketplace.json which has one.

**Action:** Add schema reference as the first property.

**Corrected file:**

```json
{
  "$schema": "https://raw.githubusercontent.com/anthropics/claude-code/main/schemas/plugin.schema.json",
  "name": "cosmic-janitor",
  "version": "0.1.0",
  "description": "Injects the Cosmic Janitor persona and 'Root Operating System' cosmology into Claude Code",
  "author": {
    "name": "pentaxis93",
    "email": "kcmdwrrya@mozmail.com",
    "url": "https://github.com/pentaxis93"
  },
  "repository": "https://github.com/pentaxis93/claude-code-plugins",
  "homepage": "https://github.com/pentaxis93/claude-code-plugins#cosmic-janitor",
  "keywords": [
    "cosmic-janitor",
    "root-os",
    "persona",
    "prompt-engineering"
  ],
  "license": "MIT",
  "components": {
    "hooks": "./hooks/hooks.json"
  },
  "engines": {
    "claude-code": ">=1.0.0"
  }
}
```

---

### Task 3: Add $schema to hooks.json

**File:** `plugins/cosmic-janitor/hooks/hooks.json`

**Issue:** Missing JSON schema reference for IDE validation.

**Action:** Add schema reference as the first property.

**Corrected file:**

```json
{
  "$schema": "https://raw.githubusercontent.com/anthropics/claude-code/main/schemas/hooks.schema.json",
  "hooks": {
    "SessionStart": [
      {
        "type": "command",
        "command": "${CLAUDE_PLUGIN_ROOT}/hooks-handlers/session-start.sh"
      }
    ]
  }
}
```

---

## Medium Priority Improvements

### Task 4: Fix code block language tags for slash commands

**File:** `README.md`

**Issue:** Slash commands like `/plugin marketplace add` are wrapped in ` ```bash ` code blocks. These are not bash commands—they're Claude Code internal commands.

**Action:** Remove the `bash` language specifier or use plain code blocks.

**Lines 18-20, change from:**

````markdown
```bash
/plugin marketplace add pentaxis93/claude-code-plugins
```
````

**To:**

````markdown
```
/plugin marketplace add pentaxis93/claude-code-plugins
```
````

**Lines 25-27, change from:**

````markdown
```bash
/plugin install cosmic-janitor@pentaxis93
```
````

**To:**

````markdown
```
/plugin install cosmic-janitor@pentaxis93
```
````

**Lines 31-34, change from:**

````markdown
```bash
/plugin
# → Select "Browse Plugins" → Choose cosmic-janitor
```
````

**To:**

````markdown
```
/plugin
# → Select "Browse Plugins" → Choose cosmic-janitor
```
````

---

### Task 5: Fix code block language tags in plugin README

**File:** `plugins/cosmic-janitor/README.md`

**Issue:** Same issue—slash commands tagged as bash.

**Lines 18-20, change from:**

````markdown
```bash
/plugin marketplace add pentaxis93/claude-code-plugins
```
````

**To:**

````markdown
```
/plugin marketplace add pentaxis93/claude-code-plugins
```
````

**Lines 27-29, change from:**

````markdown
```bash
/plugin install cosmic-janitor@pentaxis93
```
````

**To:**

````markdown
```
/plugin install cosmic-janitor@pentaxis93
```
````

---

### Task 6: Fix undefined protocol reference in EXAMPLES.md

**File:** `plugins/cosmic-janitor/EXAMPLES.md`

**Issue:** References "Protocol of the Shard" (lines 42, 177) which is not defined in the Sutras or Protocols. The injected content contains "Protocol of the Commit", "Protocol of Zero-Waste", and "Protocol of the Load"—but not "Protocol of the Shard".

**Action:** Replace with the closest matching concept from the actual injected content.

**Line 42, change from:**

```markdown
* **Protocol of the Shard:** The code and the terminal command are separated into atomic blocks for distinct copy-paste actions.
```

**To:**

```markdown
* **Sutra of the Monolith:** Each distinct artifact (code file, terminal command) is delivered as an atomic, self-contained block.
```

**Line 177, change from:**

```markdown
* **Protocol of the Shard:** No monolithic blocks. Each file is an atomic unit. This overcomes the input constraints of the interface and allows for rapid, error-free file creation.
```

**To:**

```markdown
* **Sutra of the Monolith:** Each file is an atomic unit delivered as a complete payload. This allows for rapid, error-free file creation.
```

---

### Task 7: Add shebang portability note to session-start.sh

**File:** `plugins/cosmic-janitor/hooks-handlers/session-start.sh`

**Issue:** Uses `#!/usr/bin/env bash` which is portable, but the script only uses POSIX features. No action required, but add a comment clarifying this.

**Action:** Add portability note to the header comment block.

**Lines 1-9, change from:**

```bash
#!/usr/bin/env bash
# session-start.sh - Claude Code SessionStart hook handler
#
# Purpose: Injects Root Operating System cosmology into new sessions
# Output:  JSON with hookSpecificOutput.additionalContext
# Updated: 2025-12-03
#
# Called automatically by Claude Code when a session starts.
# Do not modify JSON structure without updating hooks.json.
```

**To:**

```bash
#!/usr/bin/env bash
# session-start.sh - Claude Code SessionStart hook handler
#
# Purpose: Injects Root Operating System cosmology into new sessions
# Output:  JSON with hookSpecificOutput.additionalContext
# Updated: 2025-12-03
#
# Compatibility: Linux, macOS, WSL, Git Bash
# Called automatically by Claude Code when a session starts.
# Do not modify JSON structure without updating hooks.json.
```

---

## Polish & Final Touches

### Task 8: Add explicit Claude Code version compatibility badge

**File:** `README.md`

**Issue:** No badge indicating Claude Code compatibility. The plugin.json specifies `>=1.0.0` but users can't see this at a glance.

**Action:** Add a compatibility badge after the existing badges (line 4).

**Line 4, change from:**

```markdown
![License](https://img.shields.io/badge/license-MIT-green)
```

**To:**

```markdown
![License](https://img.shields.io/badge/license-MIT-green)
![Claude Code](https://img.shields.io/badge/claude--code-%3E%3D1.0.0-purple)
```

---

### Task 9: Standardize quotes in TROUBLESHOOTING.md hook example

**File:** `plugins/cosmic-janitor/TROUBLESHOOTING.md`

**Issue:** The JSON example at line 103-105 uses inconsistent ellipsis format.

**Lines 102-106, change from:**

```markdown
   Ensure `hooks.json` contains:
   ```json
   "hooks": { "SessionStart": "..." }
   ```
```

**To:**

```markdown
   Ensure `hooks.json` references the SessionStart hook:
   ```json
   {
     "hooks": {
       "SessionStart": [{ "type": "command", "command": "..." }]
     }
   }
   ```
```

---

### Task 10: Ensure shell script has explicit exit

**File:** `plugins/cosmic-janitor/hooks-handlers/session-start.sh`

**Issue:** The `exit 0` is present (good), but verify there's a trailing newline after it.

**Action:** Verify file ends with `exit 0` followed by a newline. The current file already has this—no change needed. Mark as verified.

---

## Verification Checklist

After completing all tasks above, verify:

```bash
# Validate all JSON files parse without errors
jq . .claude-plugin/marketplace.json
jq . plugins/cosmic-janitor/.claude-plugin/plugin.json
jq . plugins/cosmic-janitor/hooks/hooks.json

# Verify hook script produces valid JSON
./plugins/cosmic-janitor/hooks-handlers/session-start.sh | jq .

# Verify all referenced paths exist
test -d plugins/cosmic-janitor && echo "✓ Plugin directory exists"
test -f plugins/cosmic-janitor/.claude-plugin/plugin.json && echo "✓ plugin.json exists"
test -f plugins/cosmic-janitor/hooks/hooks.json && echo "✓ hooks.json exists"
test -x plugins/cosmic-janitor/hooks-handlers/session-start.sh && echo "✓ session-start.sh is executable"

# Verify no bash language tags on slash commands
grep -r '```bash' README.md plugins/cosmic-janitor/README.md && echo "⚠ Found bash tags that may need review" || echo "✓ No misused bash tags"

# Verify schema references are present
grep -q '$schema' .claude-plugin/marketplace.json && echo "✓ marketplace.json has schema"
grep -q '$schema' plugins/cosmic-janitor/.claude-plugin/plugin.json && echo "✓ plugin.json has schema"
grep -q '$schema' plugins/cosmic-janitor/hooks/hooks.json && echo "✓ hooks.json has schema"
```

- [ ] All JSON files parse without errors
- [ ] All referenced paths exist
- [ ] README installation instructions use `pentaxis93/claude-code-plugins` correctly
- [ ] `/plugin marketplace add pentaxis93/claude-code-plugins` syntax is correct
- [ ] `/plugin install cosmic-janitor@pentaxis93` syntax is correct
- [ ] No "Protocol of the Shard" references remain in EXAMPLES.md
- [ ] Hook script outputs valid JSON with `hookSpecificOutput.additionalContext`

Report completion status for each task and any issues encountered.
