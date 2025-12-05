---
description: Capture stream-of-consciousness with domain classification and insight extraction
---

# Dump

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `_system/profile.md` exists. If not: prompt for /setup.

## Execute

### 1. Collect

Ask: "What's on your mind?"

Accept any format (voice transcript, rambling, mixed).

### 2. Classify Domain

| Domain | Criteria |
|--------|----------|
| Personal | Growth, relationships, wellness |
| Professional | Work, career, leadership |
| Project | Relates to specific project (check profile) |
| Mixed | Spans multiple areas |

### 3. Analyze

Extract:

- **Themes:** 3-5 primary topics
- **Questions:** Explicit and implicit
- **Decisions:** Choices being considered
- **Actions:** Tasks identified
- **Insights:** Key realizations

### 4. Output

**File:** `{{brainFolder}}/00-inbox/dumps/dump-{{YYYY-MM-DD}}-{{HHMM}}-{{slug}}.md`

(Project-specific: `{{brainFolder}}/01-projects/{{project}}/dumps/`)

```markdown
---
type: "dump"
domain: "{{domain}}"
date: "{{YYYY-MM-DD}}"
themes: ["{{theme1}}", "{{theme2}}"]
status: "captured"
---

# Dump: {{title}}

## Raw Thoughts
{{original input}}

## Themes
1. **{{Theme}}:** {{significance}}

## Questions Raised
- {{question}}

## Decisions Contemplated
- {{decision}}

## Action Items
- [ ] {{action}}

## Insights
- {{insight}}
```

### 5. Competitive Intel (if watchlist exists)

If `_system/watchlist.md` exists and input mentions tracked entities:

Create/update: `{{brainFolder}}/01-projects/{{project}}/competitive/{{company}}.md`

### 6. Lifecycle

Dumps → consolidate → delete. Insights persist in frameworks.
