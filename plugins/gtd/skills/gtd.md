---
description: GTD execution engine - process inbox, plan day, close day
---

# GTD

Three operations: **PROCESS** → **PLAN** → **CLOSE**

---

## Invariants

1. Every project has exactly one next action
2. Inbox empties completely (delete processed items)
3. Tasks live in source files only (queries aggregate)
4. Plan is a prioritized menu, not a commitment

---

## Config

Read brain folder from `.claude/brain-config.json` → `brainFolder`.
If missing: "Run /setup first."

---

## PROCESS

**Trigger:** "process inbox", "clarify captures", "inbox zero"

### Scan

```text
{{brainFolder}}/00-inbox/
```

### Clarify (per item)

| Question | If YES | If NO |
|----------|--------|-------|
| Actionable? | → Q2 | → Reference / Trash |
| Multi-step? | → Create Project | → Single Task |
| <2 min? | → Do it now | → Route |

### Route

| Destination | Criteria |
|-------------|----------|
| Existing project | Related to active project |
| `01-projects/` | New multi-step outcome |
| `02-areas/` | Ongoing responsibility |
| `02-areas/relationships/` | About specific person |
| `03-resources/reference-notes/` | Reference only |
| Delete | No value |

### Priority Tags

| Signal | Format |
|--------|--------|
| Urgent / deadline <7d / top goal | `⏫` emoji |
| "someday" / "eventually" | `#someday` tag |
| Default | No tag |

### Cleanup

Delete processed capture blocks. Delete empty files.

### Project Review

Scan `01-projects/` for `status: active`:

- Has next action? If no → flag
- Stalled >7d? → flag
- Done? → Archive to `archives/completed/`

---

## PLAN

**Trigger:** "plan my day", "what should I work on", "daily plan"

### Pre-check

Inbox items ≥5? → Offer to process first.

### Gather

Scan for tasks (not #someday, not #waiting):

- `01-projects/` (status: active)
- `02-areas/`
- `02-areas/relationships/`

### Prioritize

| Factor | Points |
|--------|--------|
| Due today | +5 |
| Due this week | +2 |
| High priority (⏫) | +3 |
| Blocks other work | +2 |

### Output

Create `{{brainFolder}}/archives/daily-plans/{{YYYY-MM-DD}}.md`:

- Focus statement (top 3 priorities)
- Tasks plugin queries by context (@Computer, @Phone, @Home, @Errands, @Anywhere)
- Quick wins query (#time/5m, #time/15m)
- Waiting-on query (#waiting)

Update `{{brainFolder}}/02-areas/GTD-Dashboard.md` with today's focus.

---

## CLOSE

**Trigger:** "review my day", "daily closeout", "end of day"

### Pre-check

Inbox items ≥5? → Offer to process first.

### Review

1. Read today's plan
2. Ask: what got done?
3. Mark completions (tasks already sync via plugin)
4. Capture unplanned work

### Tomorrow Prep

Ask: "Focus for tomorrow?"

Create draft: `{{brainFolder}}/archives/daily-plans/{{tomorrow}}.md`

- User's stated focus
- Same query structure as PLAN
- Status: draft

Update `{{brainFolder}}/02-areas/GTD-Dashboard.md`.

---

## Invocation

- `gtd process` or "process my inbox"
- `gtd plan` or "plan my day"
- `gtd close` or "review my day"
