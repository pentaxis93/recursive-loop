# Vault Operations - Canonical Rules

## Methodology: PARA + Zettelkasten

**PARA** for organization (folders). **Zettelkasten** for notes (atomic, connected).

### Folder Structure

```text
00-inbox/           # Unprocessed captures
01-projects/        # Active projects (has deadline/end state)
02-areas/           # Ongoing responsibilities
03-resources/       # Reference materials
05-knowledge/       # Consolidated frameworks, patterns
archives/           # Completed/inactive
```

### PARA Decision

| Question | Destination |
|----------|-------------|
| Has deadline or end state? | `01-projects/` |
| Continuous responsibility? | `02-areas/` |
| Just reference material? | `03-resources/` |
| Done/inactive? | `archives/` |
| Not sure yet? | `00-inbox/` |

---

## Atomic Note Principles

1. **One idea per note** - If it has two ideas, split it
2. **Own words** - Paraphrase, never copy-paste
3. **Standalone** - Useful without source context
4. **100-300 words** - Exceptions for complex frameworks

**Test:** "Can this idea stand alone in a different context?"

- YES → Permanent note
- NO → Keep in reference/project note

---

## Linking Rules (MANDATORY)

### Minimum 3 Links Per Permanent Note

```markdown
## Links

### Related Concepts
- [[Note 1]] - How they relate
- [[Note 2]] - How they relate

### Broader Context
- [[MOC - Topic]]
```

### Link Types

| Type | Purpose |
|------|---------|
| Related | Similar concepts |
| Contrasts | Opposing views |
| Builds On | Prerequisite concept |
| Application | Where used in practice |
| Source | Attribution |

### Rules

1. **No orphans** - Every permanent note needs 3+ links
2. **Explain relationships** - Not just `[[Note]]` but `[[Note]] - how they relate`
3. **Bidirectional** - Strong relationships link both ways
4. **Link liberally** - More connections = more value

---

## Frontmatter Conventions

### Standard Properties

```yaml
---
title: "Note Title"
created: "YYYY-MM-DD"
type: "permanent-note|reference-note|project|area|dump|intel|framework"
status: "active|draft|completed|captured"
domain: "personal|professional|project|shared"
tags:
  - tag1
  - tag2
---
```

### Rules

- Always use YAML lists for tags
- Quote strings with special characters
- Dates in ISO format: `YYYY-MM-DD`

---

## Tagging Strategy

**Tags = WHAT** (categorization). **Folders = WHERE** (organization).

### Status Tags

```text
#status/fleeting
#status/developing
#status/active
#status/completed
```

### Type Tags

```text
#permanent-note
#reference-note
#framework
#pattern
#dump
#intel
```

### Always Include

- Status tag
- Type tag
- Domain tag (if applicable)

---

## Processing Workflow

### Inbox → Permanent Notes

```text
Read → Extract Atomic Ideas → Create Permanent Notes → Link → Archive/Delete Source
```

1. **Read fully** - Understand complete context
2. **Identify atomic ideas** - Each standalone concept
3. **Check for duplicates** - Search before creating
4. **Create permanent note** - Own words, 100-300 words
5. **Add 3+ links** - Related concepts + MOC
6. **Archive or delete source** - GTD canon: processed items leave

### File Lifecycle

| Source Type | After Processing |
|-------------|------------------|
| Fleeting notes | Delete |
| Dumps | Delete (insights live in frameworks) |
| Meeting notes | Archive or convert to reference |
| Rich sources | Convert to reference note |

---

## Quality Guardrails

### No Duplicates

Before creating, search for existing notes on topic. Enhance rather than duplicate.

### No Orphans

Every permanent note: minimum 3 links. If can't find 3 meaningful connections, question if note is valuable.

### Own Words Required

Never copy-paste. Read → Close source → Write in own words.

### Keep It Short

100-300 words. If exceeding 500, check atomicity - can it split?

---

## File Naming

| Type | Pattern |
|------|---------|
| Permanent note | Descriptive title (`Context-Switching-Reduces-Focus.md`) |
| Dump | `dump-YYYY-MM-DD-HHMM-slug.md` |
| Intel | `intel-YYYY-MM-DD.md` |
| Framework | `name-framework.md` |
| Pattern | `pattern-name.md` |

---

## MOC (Map of Content)

Hub notes that organize permanent notes by topic.

```markdown
# MOC - Topic Name

## Core Concepts
- [[Note 1]] - Brief description
- [[Note 2]] - Brief description

## Related MOCs
- [[MOC - Related Topic]]
```

**Rules:**

- 10+ permanent notes minimum
- Update when new notes added to topic
- Link permanent notes back to MOC

---

## Integration Points

When executing skills:

- `dump` → Creates raw capture in `00-inbox/dumps/`
- `intel` → Creates intel report in `archives/intelligence/intel/`
- `refine` → Processes raw → permanent notes with links
- `fuse` → Consolidates permanents → frameworks in `05-knowledge/`

All skills must follow these canonical rules for frontmatter, linking, and file placement.
