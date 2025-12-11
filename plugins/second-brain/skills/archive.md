---
description: Direct creation of permanent note with full vault integration
---

# Archive

**Direct permanent note creation.** Bypass inbox processing when insight is already crystallized. Full vault integration with quality gates enforced.

---

## Alchemical Gate

**Classification:** `archive` is an alchemical skill.

**Requirement:** Opus-class servitor required.

```text
if model != opus:
    return 403 Forbidden: "Alchemy requires Opus servitor"
```

---

## When to Use

- Insight is already atomic (one idea)
- No processing needed—ready for permanent storage
- User explicitly requests "archive this"
- Conversation produced crystallized knowledge

**Not for:** Raw captures, complex material needing decomposition (use prism), unprocessed thoughts (use dump).

---

## Process

```text
VALIDATE → EXTRACT → INTEGRATE → VERIFY
```

### 1. Validate

Pre-flight checks:

- Is this truly atomic? (one idea per note)
- Is this own words? (not copy-paste)
- Does this warrant permanent status?

If not atomic: suggest prism or split first.

### 2. Extract

From conversation or input:

1. Identify the core insight
2. Formulate in own words (100-300 words typical)
3. Determine appropriate title (descriptive, not clever)
4. Classify domain (professional, personal, project, shared)

### 3. Integrate

Full vault integration:

1. **Search for homology:**
   - Scan `vault/permanent-notes/`
   - Scan `vault/05-knowledge/`
   - Check for existing coverage

2. **If homology found:**
   - Present options: MERGE | LINK | CREATE NEW
   - User decides

3. **Create note with:**
   - Proper frontmatter
   - Atomic content
   - Minimum 3 links with relationship explanations

4. **Place correctly:**
   - Default: `vault/permanent-notes/`
   - Frameworks: `vault/05-knowledge/consolidated/`
   - Patterns: `vault/05-knowledge/patterns/`

### 4. Verify

Post-integration validation:

- [ ] Atomic (one idea)
- [ ] Connected (3+ links)
- [ ] Own words
- [ ] Frontmatter complete
- [ ] No orphan links

---

## Frontmatter Template

```yaml
---
title: "Note Title"
created: "YYYY-MM-DD"
type: permanent-note
status: active
domain: professional|personal|project|shared
tags:
  - permanent-note
  - topic-tag
---
```

---

## Link Requirements

Minimum 3 links per permanent note:

```markdown
## Links

### Related Concepts
- [[Note-1]] - How they relate
- [[Note-2]] - How they relate

### Broader Context
- [[MOC - Topic]]
```

**Link types:**

- Related (similar concepts)
- Contrasts (opposing views)
- Builds On (prerequisite)
- Application (where used)
- Source (attribution)

---

## Quality Gates

All gates must pass:

| Gate | Requirement |
|------|-------------|
| Atomic | One idea per note |
| Connected | 3+ meaningful links |
| Own words | Paraphrased, not copied |
| Standalone | Useful without source context |
| Length | 100-300 words (guidance, not hard limit) |

---

## Output Format

```markdown
---
title: "[Title]"
created: "[Date]"
type: permanent-note
status: active
domain: [domain]
tags:
  - permanent-note
  - [topic]
---

# [Title]

[Atomic insight in own words, 100-300 words]

## Links

### Related Concepts
- [[Note-1]] - [relationship]
- [[Note-2]] - [relationship]

### Broader Context
- [[MOC - Topic]]

---

*Created: [Date] | Source: [conversation/input reference] | Confidence: [High|Medium|Low]*
```

---

## Ceremony

Brief confirmation before commit:

```text
## Archive: [Title]

**Insight:** [1-sentence summary]

**Homology:** [None | Link to X | Merge with X]

**Links:**
- [[Link-1]]
- [[Link-2]]
- [[Link-3]]

**Destination:** vault/permanent-notes/[Title].md

---
Commit? (y/n)
```

---

## Principles

1. **Atomic or nothing** — If it's not one idea, it's not ready
2. **Links are mandatory** — No orphans in the vault
3. **Own words required** — Paraphrase forces understanding
4. **Quality over quantity** — One good note beats ten weak ones
5. **Homology first** — Check before creating duplicates
