---
description: Clarify and route inbox items (GTD PROCESS)
---

Execute the GTD PROCESS workflow. A micro-ritual, not automation.

**Trigger:** "process inbox", "process gtd"

---

## Phase 1: SCAN

Before processing any item, read all inbox contents and **physically sort into staging folders**.

**Source Locations:**

- `{{brainFolder}}/00-inbox/*.md`
- `{{brainFolder}}/00-inbox/voice-transcripts/*.md`
- `{{brainFolder}}/00-inbox/dumps/*.md`

**Staging Structure:**

```text
00-inbox/
├── _staged/
│   ├── quick-wins/      # Simple, obvious routing
│   ├── voice/           # Voice transcripts (always process LAST)
│   ├── rich/            # Need clarification or prism
│   └── duplicates/      # Detected duplicates (review before delete)
```

**Operations:**

1. **Create staging folders** if they don't exist
2. **Read each item** and classify:
   - Voice transcripts → `_staged/voice/` (process last due to volume)
   - Simple/obvious items → `_staged/quick-wins/`
   - Complex/multi-faceted → `_staged/rich/`
   - Verbatim duplicates → `_staged/duplicates/`
3. **Move files** to staging folders as you classify (enables interrupt/resume)
4. **Extract embedded instructions** - Surface meta-directives if non-trivial

**Output:** Present summary to user:

- Total items per category
- Duplicates detected
- Embedded instructions found
- Processing order: quick-wins → rich → voice

**Why physical sorting:** Enables interruption at any point. Resume by checking what remains in `_staged/` folders. Process is idempotent.

**User confirms** before proceeding to Phase 2.

---

## Phase 2: PROCESS (per-item)

**Processing order:** `_staged/quick-wins/` → `_staged/rich/` → `_staged/voice/`

For each item in queue, complete all steps before moving to next:

### Step 1: INVOKE + CLARIFY (single interaction)

**User must touch every item.** Use `AskUserQuestion` to bundle context + clarification in one interaction.

**Context first:** Present the capture content:

- Short items (<300 chars): Show full text
- Long items: Show brief excerpt or summary

**Then ask** using AskUserQuestion with appropriate options:

```text
Question: "How should we route this?"
Options based on content:
- Task → [likely area/project]
- Someday/maybe
- Reference note
- Trash
- (Other - user specifies)
```

For ambiguous items, ask clarifying questions first:

- "Is this actionable?"
- "Which project/area does this belong to?"

**Principle:** Minimize friction. One AskUserQuestion call bundles context + decision. User sees content, provides input, done.

### Step 2: PROPOSE

After user input, confirm the specific routing:

- Destination file path
- Task text (if applicable)
- Any tags/dates

Brief proposal. User approves or corrects.

### Step 3: EXECUTE + BANISH

- Create/update destination artifact
- **Delete original capture** (git preserves history; value lives in destination)
- Brief acknowledgment: "Banished → [destination]"

---

## Phase 3: CLOSE

After all items processed:

- **Project review** - Any new projects missing next actions?
- **Cleanup staging** - Remove empty `_staged/` subfolders
- **Verification** - Inbox root and staging folders empty?
- **Summary** - Items processed, destinations, any deferred

**Partial completion:** If session ends mid-process, staged folders preserve state. Next invocation resumes from remaining staged items.

---

## Mode

### Default: Interactive micro-ritual

- One item at a time
- User controls pace (can pause anytime)
- Present → Propose → Confirm → Execute

### Batch mode

Only if user explicitly says "batch" or "process all automatically"

---

## Critical Rules

1. **Never make autonomous routing decisions** - User involved in clarify/decide
2. **Per-item completion** - Steps 1-5 complete before next item
3. **Delete after processing** - Original capture removed; value migrated
4. **Honor embedded instructions** - Meta-directives in captures take precedence
5. **User is a note** - Invoke at exigent moment; they provide needed context

---

## Philosophy

**Processing is a micro-ritual. Not automation.**

Each capture is a commitment. We invoke attention, clarify its nature, route it to proper destination, then banish it. Like sending souls to their proper destination.

**Strong Idempotence:** Time dimension irrelevant. Instructions in any capture (first or last) honored. Duplicates detected and skipped.
