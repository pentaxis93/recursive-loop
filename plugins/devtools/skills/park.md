---
description: Park open decisions with full context for seamless resumption
---

# Park

Preserve context around blocked work for later resumption.

---

## When to Park

- Design decision needs more input
- Work blocked pending external context (voice notes, research, user decision)
- Question too complex to resolve now but context is fresh
- Conversation pivoting but current thread has value

**Not for:** completed work (archive), abandoned work (delete), quick captures (capture)

---

## Config

Read brain folder from `.claude/brain-config.json` → `brainFolder`.

**State card:** `{{brainFolder}}/02-areas/GTD-Dashboard.md`

---

## Trigger

`/devtools:park` or "park this", "hold this for later", "save context"

---

## Idempotent Infrastructure

**Pattern:** Skills that create special sections MUST ensure infrastructure exists before use.

### Parking Lot Section

Before parking, check if `## Parking Lot` section exists in GTD-Dashboard.

**If missing, create it:**

```markdown
## Parking Lot

Parked items awaiting external input. Query:

\`\`\`tasks
not done
tags include #parked
\`\`\`
```

**Insert location:** After `## Tomorrow's Plan` section, before `## Yesterday's Results`

**If exists:** Use as-is. No modification needed.

This pattern applies to ALL skills that need special dashboard sections.

---

## Gather

Before creating capture, collect:

1. **Topic:** What's being parked (1-line summary)
2. **Context:** What led here, why this matters
3. **Changes made:** Any modifications already done (files, commands, state changes)
4. **Arguments:** Pro/con or tradeoffs if decision-related
5. **Open questions:** What needs answering before resumption
6. **Awaiting:** What specific input unblocks this
7. **Restoration path:** Commands or steps to resume (if applicable)

---

## Output

**File:** `{{brainFolder}}/00-inbox/capture-{{YYYY-MM-DD-HHmmss}}.md`

**Template:**

```markdown
---
created: {{ISO-8601}}
type: capture
status: in-progress
tags:
  - parked
  - {{domain-tag}}
  - pending-context
---

# {{Topic}}

- [ ] Unpark: {{Topic}} #parked

## Context

{{What led here, why this matters}}

## Changes Made

{{List of modifications, or "None" if just discussion}}

## Arguments

### For
{{Bullet points}}

### Against
{{Bullet points}}

## Open Questions

{{Numbered list of what needs answering}}

## Awaiting

{{Specific input that unblocks: voice notes, research, user decision, etc.}}

## Restoration Path

{{Commands, file paths, or steps to resume work}}

## Status

**Parked:** {{timestamp}}
**Unblocks when:** {{condition}}
```

Note: The task `- [ ] Unpark: {{Topic}} #parked` makes the item visible in the Parking Lot query.

---

## After Parking

1. Ensure Parking Lot section exists on GTD-Dashboard (idempotent)
2. Create capture file with parked template
3. Update TodoWrite with in_progress item referencing parked topic
4. Confirm to user: "Parked at [path]. Visible in Parking Lot. Awaiting [input]."
5. Ready to context-switch

---

## Resumption

When unblocking input arrives:

1. Read parked capture from Parking Lot query or direct reference
2. Restore context from document
3. Continue from open questions
4. Mark task complete and delete capture when resolved (value moves to destination)
