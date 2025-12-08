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

**Assumption:** User is present and engaged when this operation is invoked. No presence confirmation needed. User owns the responsibility to be present—trust this.

### Phase 1: SCAN (once)

```text
{{brainFolder}}/00-inbox/
```

Build item queue.

### Phase 2: TRIAGE (once)

Sort items by complexity—quick wins first:

| Priority | Type | Rationale |
|----------|------|-----------|
| 1 | Trash | Instant decisions, shrinks pile |
| 2 | Reference-only | File and forget, no action needed |
| 3 | <2 min actions | Do now, done forever |
| 4 | Single tasks | Route to destination |
| 5 | Projects | Require most thought, full attention |

Process in this order. Momentum builds as pile shrinks. Decision fatigue hits after simple stuff clears. Complex items get undivided attention.

### Interaction Depth

Every item gets conscious engagement. Processing is a micro-ritual: invoke attention, banish when done. Never automatic.

| Tier | Interaction | Method |
|------|-------------|--------|
| Trash | Confirm | "Delete? [Y/N]" |
| Reference | Quick route | "File to: [options]" |
| <2 min | Do + confirm | "Done? [Y/N]" |
| Single task | Widget | Destination + priority + date |
| Projects | Conversation | Define outcome, next action, context |

Depth scales with complexity. Simple items need only a moment of intention. Complex items deserve dialogue.

### Tool Usage

**ALL user interactions during PROCESS use AskUserQuestion:**
- Per-item routing decisions
- Clarification questions
- Meta-decisions (batch handling, queue prioritization, processing mode)

Never present options as free-form text. The widget is the ritual interface. Consistency is structural.

### Phase 3: PER-ITEM LOOP

For each item, complete A→B→C→D before next item:

#### A. CLARIFY

| Question | YES | NO |
|----------|-----|-----|
| Actionable? | → Next question | Reference or Trash |
| Multi-step? | Create Project | Single Task |
| <2 min? | Do now, mark done | → Organize |

#### B. ORGANIZE

| Destination | Criteria |
|-------------|----------|
| Existing project | Related to active project |
| `01-projects/` | New multi-step outcome |
| `02-areas/` | Ongoing responsibility |
| `02-areas/people/` | About specific person |
| `03-resources/reference-notes/` | Reference only |

#### C. TAG

| Signal | Format |
|--------|--------|
| Urgent / deadline <7d / top goal | `⏫` |
| Someday / eventually | `#someday` |

#### D. CLEANUP

Delete the processed capture. Item is now gone from inbox.

*→ Next item*

### Phase 4: PROJECT REVIEW (once, after all items processed)

Scan `01-projects/` for `status: active`:

- Missing next action? → Flag
- Stalled >7d? → Flag
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
- `02-areas/people/`

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
