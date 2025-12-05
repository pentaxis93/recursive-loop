---
description: Capture to daily inbox
---

# Capture

Config: `.claude/brain-config.json` → `brainFolder`

## Execute

1. **File:** `{{brainFolder}}/00-inbox/capture-{{YYYY-MM-DD}}-{{HHmmss}}.md`

2. **Create:**

   ```markdown
   ---
   type: capture
   created: "{{YYYY-MM-DD}} {{HH:mm}}"
   ---

   {{input}}
   ```

3. **Confirm:** `Captured at {{HH:mm}}`
