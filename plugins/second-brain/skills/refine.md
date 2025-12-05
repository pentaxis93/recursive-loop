---
description: Process raw captures into atomic permanent notes with proper linking
---

# Refine

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `_system/profile.md` exists. If not: prompt for /setup.

## Execute

### 1. Gather Sources

Scan for unprocessed content:

| Location | Type |
|----------|------|
| `00-inbox/dumps/` | Raw dumps |
| `00-inbox/` | Fleeting notes |
| `01-projects/*/dumps/` | Project dumps |

Identify items with `status: "captured"` or `#status/fleeting`.

Ask: "Process all, or specific file?"

### 2. Read & Extract

For each source:

1. **Read fully** - Understand complete context
2. **Separate content types:**
   - Action items → Route to GTD (project/area notes)
   - Atomic ideas → Extract to permanent notes
   - Reference info → Create/update reference notes

**Atomic Idea Test:**

- Can stand alone in different context? → Permanent note
- Only useful with source? → Keep in reference

### 3. Check Duplicates

Before creating each permanent note:

```text
Grep for keywords from the concept
If similar exists:
  - Read existing note
  - Enhance with new insights (Edit)
  - Link if perspectives differ
If not exists:
  - Create new permanent note
```

### 4. Create Permanent Notes

**Location:** `{{brainFolder}}/permanent-notes/` or `05-knowledge/`

**Filename:** Descriptive title (`Context-Switching-Reduces-Focus.md`)

```markdown
---
title: "{{Title}}"
created: "{{YYYY-MM-DD}}"
type: "permanent-note"
status: "active"
tags:
  - permanent-note
  - {{topic}}
---

# {{Title}}

{{Core idea in own words, 100-300 words}}

{{Concrete example or application}}

---

## Links

### Related Concepts
- [[Note 1]] - {{relationship}}
- [[Note 2]] - {{relationship}}

### Broader Context
- [[MOC - {{Topic}}]]

## References
- [[{{Source if applicable}}]]
```

### 5. Link Discovery

For each permanent note created:

1. **Search related:**
   - Grep keywords from title and content
   - Check relevant MOCs
   - Review recent permanent notes

2. **Add minimum 3 links:**
   - 1-2 related concept links (with explanations)
   - 1 MOC link (broader context)
   - 1 source link (if applicable)

3. **Bidirectional linking:**
   - For strong relationships, add backlink in related note

### 6. Create Reference Notes (if needed)

When source has valuable context (article, meeting, book):

**Location:** `{{brainFolder}}/03-resources/reference-notes/`

```markdown
---
title: "Reference: {{Source Title}}"
created: "{{YYYY-MM-DD}}"
type: "reference-note"
source: "{{URL or citation}}"
tags:
  - reference-note
---

# Reference: {{Source Title}}

**Type:** {{Book|Article|Meeting|Video}}
**Source:** {{URL or citation}}

## Summary
{{2-4 sentences in own words}}

## Key Ideas
1. {{Main point}}
2. {{Main point}}

## Permanent Notes Extracted
- [[Note 1]]
- [[Note 2]]
```

### 7. Archive/Delete Sources

After successful extraction:

| Source Type | Action |
|-------------|--------|
| Fleeting notes | Delete |
| Dumps | Delete |
| Meeting notes | Archive to `archives/` |
| Rich sources | Convert to reference note |

**Rationale:** GTD canon - processed items leave the system. Git preserves history.

### 8. Update MOCs

If permanent notes belong to existing topic:

1. Read relevant MOC
2. Add new notes to appropriate section
3. Update note count if tracked

If 3+ notes on new topic without MOC:

- Suggest creating MOC

### 9. Report

Summary:

- Sources processed: {{count}}
- Permanent notes created: {{count}}
- Reference notes created: {{count}}
- Links added: {{count}}
- Sources archived/deleted: {{count}}

## Quality Checklist

Before marking complete:

- [ ] Each permanent note has 3+ links
- [ ] All links have relationship explanations
- [ ] Notes written in own words (no copy-paste)
- [ ] Notes are atomic (one idea each)
- [ ] Notes are 100-300 words
- [ ] Frontmatter complete
- [ ] Sources archived or deleted

## Processing Different Types

### Fleeting Notes

Quick captures → Expand into full permanent note or delete if stale.

### Dumps

Stream of consciousness → Extract multiple atomic ideas, route actions to GTD.

### Meeting Notes

Discussion summary → Extract reusable insights, convert to reference note.

### Imported Highlights

Quotes from sources → Synthesize into permanent notes (don't create 1:1).
