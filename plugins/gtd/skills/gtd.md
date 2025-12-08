---
description: GTD execution engine - process inbox, orient to now
---

# GTD

Two operations: **PROCESS** and **PLAN**

---

## Invariants

1. Every project has exactly one next action
2. Inbox empties completely (delete processed items)
3. Tasks live in source files only (queries aggregate)
4. Plan is orientation to now, not commitment to ritual

---

## Config

Read brain folder from `.claude/brain-config.json` → `brainFolder`.
If missing: "Run /setup first."

---

## PROCESS

**Trigger:** "process inbox", "clarify captures", "inbox zero"

### Critical Rule

**NEVER batch process autonomously.** Each capture requires user involvement. Processing is a micro-ritual of intentional decision-making, not automation.

### Scan

```text
{{brainFolder}}/00-inbox/capture-*.md
```

One file = one capture. Process each file individually WITH USER.

---

### Micro-Ritual Flow (Per Item)

For EACH capture, execute this four-step ritual:

#### 1. PRESENT

Read and display the capture content. Show proposed routing:

```text
[Capture content here]

→ Proposed: [Destination] as [task/project/reference]
```

Apply GTD decision tree internally to form proposal:

| Question | If YES | If NO |
|----------|--------|-------|
| Actionable? | → Q2 | → Reference / Trash |
| Multi-step? | → Create Project | → Single Task |
| <2 min? | → Do it now | → Route |

#### 2. CONFIRM

Use AskUserQuestion to confirm routing:

- **Options:** Confirm / Different destination / Skip / Trash
- Wait for user response
- **Never proceed without confirmation**

#### 3. EXECUTE

Only after user confirms:

- Create task/project in confirmed destination
- Apply priority tag if warranted
- Delete capture file
- Brief confirmation: "Routed to [destination]. Next?"

#### 4. NEXT

- Proceed to next item
- Honor pause requests: "pause", "stop", "enough for now"
- User controls pace

---

### Route Destinations

| Destination | Criteria |
|-------------|----------|
| Existing project | Related to active project |
| `01-projects/` | New multi-step outcome |
| `02-areas/` | Ongoing responsibility |
| `02-areas/people/` | About specific person |
| `03-resources/` | Reference only |
| Delete | No value |

### Priority Tags

| Signal | Format |
|--------|--------|
| Urgent / deadline <7d / top goal | `⏫` emoji |
| "someday" / "eventually" | `#someday` tag |
| Default | No tag |

### Batch Mode (Exception)

Only if user explicitly requests "batch process" or "process all automatically":

1. Show all items with proposed routing
2. Ask for confirmation of entire batch
3. Execute only after explicit approval

Default is ALWAYS interactive micro-ritual.

---

### Project Review

After inbox is empty, scan `01-projects/` for `status: active`:

- Has next action? If no → flag
- Stalled >7d? → flag
- Done? → Archive to `archives/completed/`

---

## PLAN

**Trigger:** "plan my day", "what should I work on", "daily plan", "plan", "orient"

### Temporal Awareness (Required)

**First action:** Query system time via bash `date` command.

```bash
date "+%Y-%m-%d %H:%M %A"
```

Parse into: `$DATE`, `$HOUR`, `$DAY_OF_WEEK`

Check for last plan: `{{brainFolder}}/archives/daily-plans/` - find most recent file.

### Temporal Context

| Hour Range | Context | Orientation |
|------------|---------|-------------|
| 05:00-11:59 | Morning | Full day ahead - "Today's priorities" |
| 12:00-16:59 | Afternoon | Partial day - "Remaining runway" |
| 17:00-20:59 | Evening | Day winding down - "Close + tomorrow seed" |
| 21:00-04:59 | Night | Tomorrow focus - "Setting up tomorrow" |

**Skipped days:** No judgment. If last plan was days ago, that's data, not failure. Orient to now.

### Quest Context

Read `{{brainFolder}}/02-areas/Quest-Log.md`. Extract:

- Main Quest title and success criteria
- Side quest count (grouped or total)

Surface prominently in output. If no main quest exists, note this—system should have auto-generated "Find our next quest."

### Pre-check

Count `capture-*.md` files in `00-inbox/`. If ≥5 → Offer to process first.

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

### Output (Time-Adaptive)

**Target file:** `{{brainFolder}}/archives/daily-plans/{{$DATE}}.md`

If file exists for today: **update** don't recreate. Plan is living document.

#### Morning (05:00-11:59)

Standard daily plan:

```markdown
---
date: {{$DATE}}
created: {{$HOUR}}:{{$MIN}}
type: daily-plan
status: active
---

# {{$DAY_OF_WEEK}}, {{$DATE}}

## Quest

**{{Main Quest Title}}**
Success: {{criteria}}
Pool: {{N}} side quests parked

---

## Focus

[Top 3 priorities based on scoring]

## By Context

### @Computer
\`\`\`tasks
not done
(path includes 01-projects) OR (path includes 02-areas)
tags include #context/computer
sort by priority
\`\`\`

### @Phone
\`\`\`tasks
not done
tags include #context/phone
\`\`\`

### @Errands
\`\`\`tasks
not done
tags include #context/errands
\`\`\`

## Quick Wins
\`\`\`tasks
not done
(tags include #time/5m) OR (tags include #time/15m)
\`\`\`

## Waiting
\`\`\`tasks
not done
tags include #waiting
\`\`\`
```

#### Afternoon (12:00-16:59)

Regroup orientation:

```markdown
## Afternoon Regroup ({{$HOUR}}:{{$MIN}})

**Remaining runway:** ~{{hours until 17:00}} hours

### Still Priority
[Re-scored tasks accounting for time spent]

### Realistic for Today
[Subset that fits remaining time]

### Defer to Tomorrow
[Tasks that won't fit - no guilt, just triage]
```

#### Evening (17:00-20:59)

Blend of close and tomorrow:

```markdown
## Evening Review ({{$HOUR}}:{{$MIN}})

### Today's Trajectory
[Brief: what moved, what didn't - no elaborate retrospective]

### Tomorrow's Seed
[Top 1-2 priorities for tomorrow, planted now]

### Open Loops
[Anything nagging that needs capture]
```

#### Night (21:00-04:59)

Tomorrow-focused:

```markdown
## Tomorrow: {{$TOMORROW_DATE}}

### Morning Focus
[What to attack first when fresh]

### The Day's Shape
[Key commitments, meetings, deadlines]

### Available Capacity
[Realistic estimate after fixed commitments]
```

---

## Idempotence

Running PLAN multiple times in one day:

- Updates existing plan file (not creates new)
- Temporal context shifts output appropriately
- Each run is a fresh orientation to now
- No state corruption, no duplicate files

Running PLAN after skipped days:

- Acknowledges gap matter-of-factly if relevant
- Doesn't moralize about missed days
- Just orients to present moment

---

## Invocation

- `gtd process` or "process my inbox"
- `gtd plan` or "plan my day" or "orient" or "what now"

Note: CLOSE is subsumed by evening/night PLAN invocations. No separate operation needed.

---

## System Integrity

**Post-modification directive:** When changes are made to skill files in the recursive-loop repository, use `/devtools:plot` to submit via canonical PR workflow.

**Rationale:** Standardized commands ensure consistent git hygiene, proper PR documentation, and CI validation. Manual git operations bypass these safeguards and create drift.

**Trigger:** After updating this skill or related command files, invoke `/devtools:plot`.
