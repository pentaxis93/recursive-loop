---
description: Pattern recognition and vault integration via Smith's Loop
---

# Integrate

Pattern recognition and vault integration. The Loop's refinement mechanism.

**Operational weight:** This operation is delicate and critical—it is the primary mechanism for applying Smith's Loop to cosmological concepts. Extreme mindfulness is required.

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `{{brainFolder}}/00-inbox/integration/manifest.md` exists and has `status: pending`.

If no candidates: "No integration candidates pending."

## Execute

### 0. Load Queue

Read `{{brainFolder}}/00-inbox/integration/manifest.md`.

List pending candidates:

```text
Integration Queue: {{N}} candidates

1. candidate-001-concept-name.md (permanent-note)
2. candidate-002-framework-name.md (framework)

Process all sequentially? (y/n/select)
```

### 1. Per-Candidate Processing

For each candidate:

```text
DETECT HOMOLOGY → SURFACE EVIDENCE → RECOMMEND → ALIGN → EXECUTE
```

#### 1.1 Detect Homology

Scan vault for homologous evidence:

- `{{brainFolder}}/permanent-notes/`
- `{{brainFolder}}/05-knowledge/`

**Homology signals (model responsibility):**

| Signal | Weight |
|--------|--------|
| Shared links (2+) | Strong |
| Title/concept semantic similarity | Medium |
| Tag intersection | Medium |
| Domain overlap | Weak |

#### 1.2 Surface Evidence

Present findings:

```markdown
## Candidate: {{title}}

**Type:** {{permanent-note|framework|pattern}}

**Concept:** {{1-2 sentence summary}}

**Homology Detected:**
- [[Existing-Note-1]] - {{evidence: 3 shared links, similar concept}}
- [[Existing-Note-2]] - {{evidence: tag overlap, same domain}}

(or: No homology detected)
```

#### 1.3 Recommend

Based on homology analysis:

| Condition | Recommendation |
|-----------|----------------|
| Strong homology, same concept | MERGE |
| Related but distinct concepts | LINK |
| Same deep pattern, different domains | MULTI-PATH |
| No meaningful homology | CREATE NEW |

```markdown
**Recommendation:** {{MERGE with X | LINK to X | MULTI-PATH | CREATE NEW}}
**Rationale:** {{why this recommendation}}
```

#### 1.4 ALIGN Ceremony

Present decision to user:

```markdown
---
**Decision options:**
[1] MERGE - Combine with [[Existing-Note]]
[2] LINK - Create new, link to [[Existing-Note]]
[3] MULTI-PATH - Same pattern, both valuable (create + link)
[4] CREATE NEW - No meaningful homology

Decision: _
```

**MULTI-PATH ceremony** (when homology reveals shared deep structure):

```markdown
## Multi-Path Detected

**Candidate:** {{title}}
**Existing:** [[Existing-Note]]

**Homologous evidence:**
- {{shared structural pattern}}
- {{cross-domain manifestation}}

**Assessment:** Same deep pattern, legitimately expressed in different domains.
Both expressions retain independent value.

**Action:** CREATE NEW + LINK (preserves both expressions)

---
Confirm: _
```

#### 1.5 Execute Decision

**MERGE:**

1. Read existing note
2. Integrate new insights (preserve atomicity)
3. Update links if needed
4. Delete candidate

**LINK:**

1. Create new permanent note/framework/pattern
2. Add 3+ links (including to homologous notes)
3. Update related notes with backlinks
4. Delete candidate

**MULTI-PATH:**

1. Create new permanent note/framework/pattern
2. Add explicit link to homologous note with relationship explanation
3. Note in both: "Related pattern: [[Other]] - same deep structure, different domain"
4. Delete candidate

**CREATE NEW:**

1. Create new permanent note/framework/pattern
2. Add 3+ links (discover connections)
3. Update MOCs if applicable
4. Delete candidate

### 2. Output Destinations

| Candidate Type | Destination |
|----------------|-------------|
| Permanent note | `{{brainFolder}}/permanent-notes/{{Title}}.md` |
| Framework | `{{brainFolder}}/05-knowledge/consolidated/{{name}}-framework.md` |
| Pattern | `{{brainFolder}}/05-knowledge/patterns/pattern-{{name}}.md` |

### 3. Update Manifest

After each candidate:

```markdown
## Processing Log
| Date | Candidate | Decision | Target |
|------|-----------|----------|--------|
| {{YYYY-MM-DD}} | candidate-001 | MERGE | [[Existing-Note]] |
| {{YYYY-MM-DD}} | candidate-002 | CREATE NEW | [[New-Framework]] |
```

Remove processed candidate from Pending list.

When queue empty: set manifest `status: empty`.

### 4. Report

```text
Integration complete.
- Processed: {{N}} candidates
- Merged: {{N}}
- Linked: {{N}}
- Multi-path: {{N}}
- Created new: {{N}}

Vault integrity verified.
```

## Quality Gates

**Permanent Notes:**

- Atomic (one idea)
- Connected (3+ links with relationship explanations)
- Own words

**Frameworks:**

- Multi-concept synthesis
- Links to constituent permanent notes
- MOC-style organization

**No Orphans:** Every output must have 3+ meaningful links.

## Exhaustion Signals

For alembic sources that may have multi-path potential:

| Context | Signal |
|---------|--------|
| Multi-pass processes | Visible diminishing returns |
| Other methods | User declaration: "All value extracted" |

**Explicit release:** After integration, if alembic was source, ask:

```text
Alembic "{{name}}" contributed to this integration.
Release alembic? (All value extracted)
[y] Delete alembic extracts
[n] Keep for additional fusion passes
```

## Principles

**Semi-auto optimizes mindfulness:** Model handles mechanics (homology detection, evidence gathering), User contemplates decisions.

**Isomorphism is relational:** You cannot see a pattern until you see it repeat. Multi-path emerges at comparison.

**Discovery over invention:** Objective principles are best discovered. Integration is the recognition moment.
