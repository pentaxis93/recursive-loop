---
name: parking
description: Park and unpark projects with full context preservation
---

# Parking

Park blocked projects and resume them safely.

---

## Model

**Parked** = Project note links to `[[MOC - Parking Lot]]`

**Parking context** = `03-resources/parking/{{project-slug}}.md`

**Session archive** = `archives/sessions/{{session-id}}.jsonl`

Single source of truth: the MOC link exists or it doesn't. No tags. No status frontmatter.

---

## Config

Read brain folder from `.claude/brain-config.json` → `brainFolder`.

| Artifact | Path |
|----------|------|
| Parking Lot MOC | `{{brainFolder}}/05-knowledge/MOC - Parking Lot.md` |
| Parking context | `{{brainFolder}}/03-resources/parking/{{project-slug}}.md` |
| Session archive | `{{brainFolder}}/archives/sessions/{{session-id}}.jsonl` |
| Project notes | `{{brainFolder}}/01-projects/` |

---

## Triggers

| Mode | Trigger |
|------|---------|
| Park | `/devtools:park`, "park this", "hold this for later", "save context" |
| Unpark | `/devtools:unpark`, "unpark", "resume parked work", "continue {{topic}}" |

---

## PARK MODE

### When to Park

- Work blocked pending external input (research, user decision, voice notes)
- Design decision needs more context
- Question too complex to resolve now but context is fresh
- Conversation pivoting but current thread has value

**Not for:** completed work (archive), abandoned work (delete), quick captures (capture)

---

## Phase 1: GATHER

Collect before creating any files:

| Field | Content |
|-------|---------|
| **Project** | Which project note is being parked |
| **Blocker** | What specific input/event unblocks this |
| **State** | What was already done, current progress |
| **Open questions** | Unresolved questions (numbered) |
| **Restoration path** | Commands, file paths, or steps to resume |

---

## Phase 2: VALIDATE

Self-test before proceeding. Read gathered content as if you have no session context.

Can you answer:

1. What is this about?
2. Why does it matter?
3. How do I continue?

If any answer is unclear → iterate with user before creating files.

---

## Phase 3: CREATE

### 3a. Create parking context

**Path:** `{{brainFolder}}/03-resources/parking/{{project-slug}}.md`

**Template:**

```markdown
---
created: {{ISO-8601}}
type: parking-context
project: "[[{{Project-Name}}]]"
tags:
  - parking-context
---

# Parking Context: {{Project Name}}

## Blocker

{{What specific input/event unblocks this}}

## State When Parked

{{What was already done, current progress}}

## Open Questions

{{Numbered list of unresolved questions}}

## Restoration Path

{{Commands, file paths, or steps to resume}}

## Session Reference

Archived: `archives/sessions/{{session-id}}.jsonl`
```

### 3b. Archive session transcript

**Source:** `~/.claude/projects/{{project-path-encoded}}/{{session-id}}.jsonl`

**Destination:** `{{brainFolder}}/archives/sessions/{{session-id}}.jsonl`

Copy the full JSONL for lossless context preservation.

### 3c. Link project to MOC

Add to the project note (typically near top or in a Links section):

```markdown
[[MOC - Parking Lot]]
```

This single link marks the project as parked.

---

## Phase 4: CONFIRM

Report to user:

- "Parked [[Project-Name]]"
- "Context saved at: {{parking-context-path}}"
- "Awaiting: {{blocker}}"
- "To resume: `/devtools:unpark`"

---

## UNPARK MODE

### Phase 1: LOCATE

Find the parked project. Search in order:

1. **MOC backlinks** — Projects linking to `[[MOC - Parking Lot]]`
2. **Parking context** — Files in `{{brainFolder}}/03-resources/parking/`
3. **User specification** — If user names the project directly

If not found: "Cannot locate parked context for '{{topic}}'. Please specify the project."

---

## Phase 2: VALIDATE (CRITICAL - BLOCKING)

**This is a hard gate. No implementation until ALL checks pass.**

Read the parking context file and verify:

| Check | Question | Status |
|-------|----------|--------|
| Topic | Do I know what this is about? | ✓/✗ |
| Purpose | Do I know why this matters? | ✓/✗ |
| State | Do I know what was already done? | ✓/✗ |
| Blocker | Do I know what was blocking? | ✓/✗ |
| Path | Do I know how to resume? | ✓/✗ |

### Output validation table

```markdown
## Context Validation: {{Project}}

| Check | Status | Notes |
|-------|--------|-------|
| Topic | ✓/✗ | {{understanding or "MISSING"}} |
| Purpose | ✓/✗ | {{understanding or "MISSING"}} |
| State | ✓/✗ | {{understanding or "MISSING"}} |
| Blocker | ✓/✗ | {{understanding or "MISSING"}} |
| Path | ✓/✗ | {{understanding or "MISSING"}} |

**Gaps:** {{count}}
```

### On gaps detected

If ANY check fails:

1. **DO NOT PROCEED** to implementation
2. Use AskUserQuestion to gather missing context
3. Optionally read `archives/sessions/{{session-id}}.jsonl` for details
4. Re-validate until all checks pass

**This is non-negotiable.** Proceeding with incomplete context risks wrong work.

### On all checks pass

Report: "Context validation complete. All checks passed. Ready to proceed."

---

## Phase 3: RESTORE

1. **Summarize** — Present brief context summary to user
2. **Confirm** — "Ready to continue work on {{project}}. Proceed?"
3. **Begin** — Execute restoration path

---

## Phase 4: CLEANUP

After work completes:

1. **Remove MOC link** — Delete `[[MOC - Parking Lot]]` from project note
2. **Delete parking context** — Remove `03-resources/parking/{{project-slug}}.md`
3. **Delete session archive** — Remove `archives/sessions/{{session-id}}.jsonl`

Value has moved to destination. Parking artifacts are scaffolding.

---

## Guidelines

**Safety first:** The validation gate exists because proceeding blind is dangerous. Honor it absolutely.

**Be explicit:** Show the validation table. Transparency builds trust.

**Iterate patiently:** If context is missing, gather it. Don't rush.

**Clean up after:** Delete parking artifacts once resolved. Don't accumulate cruft.

**Link is truth:** The MOC link is the only indicator of parked state. Keep it simple.
