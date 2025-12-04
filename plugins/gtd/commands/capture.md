---
description: Capture to daily inbox
---

# Capture

Config: `.claude/brain-config.json` → `brainFolder`

## Execute

1. **File:** `{{brainFolder}}/00-Inbox/captures/{{YYYY-MM-DD}}.md`

2. **If missing, create:**

   ```markdown
   ---
   title: "Daily Inbox - {{YYYY-MM-DD}}"
   type: inbox
   ---

   # {{YYYY-MM-DD}}
   ```

3. **Append:**

   ```markdown
   ### {{HH:mm}}

   {{input}}

   ---
   ```

4. **Confirm:** `Captured at {{HH:mm}}`
