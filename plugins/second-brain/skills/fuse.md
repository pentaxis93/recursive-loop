---
description: Synthesize scattered insights into integration candidates
---

# Fuse

Knowledge consolidation. Primary evolutionary pressure for cosmological concepts.

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `{{brainFolder}}/02-areas/Profile.md` exists. If not: prompt for /setup.

## Execute

### 0. Check Alembics

Scan `{{brainFolder}}/00-inbox/alembics/` for manifest with `status: ready-for-fusion` or `status: held`.

**If ready/held alembics found:**

```text
Alembics available:
- [ready] theme-a (5 extracts)
- [held] theme-b (3 extracts, previously fused)

Select source:
[1] Alembic: theme-a
[2] Alembic: theme-b (additional pass)
[3] Scan vault (ignore alembics)
```

**If alembic selected:**
- Use alembic extracts as input source
- Skip vault scan (Step 1)
- Proceed to pattern detection (Step 2)
- After fusion: set alembic status to `held` (not deleted—explicit release required)

**If no ready alembics or vault scan chosen:**
- Proceed to Step 1 (Gather)

### 1. Gather

Scan vault for unprocessed content:

| Location | Content |
|----------|---------|
| `00-inbox/dumps/` | Raw dumps |
| `01-projects/*/dumps/` | Project dumps |
| `archives/intelligence/` | Intel reports |

Ask: "Time period? (week, month, quarter, all, custom)"

Identify items with `status: "captured"` or missing consolidation metadata.

### 2. Detect Patterns

| Analysis | Focus |
|----------|-------|
| Frequency | Themes across multiple docs, recurring concerns |
| Temporal | How thinking evolved, inflection points |
| Domain | Cross-domain correlations (personal↔professional↔project) |
| Contradiction | Conflicts, tensions, perspective shifts |
| Meta | Decision patterns, problem-solving approaches |

### 3. Classify & Synthesize

For each identified pattern/insight:

**Classification test:** "Can this be split into 3+ standalone concepts?"
- YES → Framework/pattern candidate
- NO → Permanent note candidate

**Synthesize:**
- Permanent notes: atomic, single concept, own words
- Frameworks: multi-concept synthesis, structured sections
- Patterns: recurring structural insights across domains

### 4. Stage Candidates

**Output to:** `{{brainFolder}}/00-inbox/integration/candidate-NNN-slug.md`

```markdown
---
title: "{{Title}}"
created: "{{YYYY-MM-DD}}"
type: "integration-candidate"
candidate-type: "permanent-note|framework|pattern"
source-count: {{N}}
status: "pending"
---

# {{Title}}

## Concept

{{Synthesized content}}

## Source Evidence

- [[source-1]] - {{relevant insight}}
- [[source-2]] - {{relevant insight}}

## Proposed Links

- [[related-concept-1]] - {{relationship}}
- [[related-concept-2]] - {{relationship}}
```

**Numbering:** Sequential from 001, with descriptive slug.

### 5. Update Integration Manifest

Update `{{brainFolder}}/00-inbox/integration/manifest.md`:

```markdown
## Pending Candidates
- [ ] candidate-001-concept-name.md
- [ ] candidate-002-another-concept.md
```

Set manifest `status: pending`.

### 6. Handle Sources

**If fused from alembic:**
- Set alembic manifest `status: held`
- Do NOT delete extracts (explicit release required later)

**If fused from vault scan:**
- Delete processed dumps after staging candidates
- Git preserves history

**Rationale:** Explicit release lifecycle. Sources may have multi-path potential.

### 7. Prompt for Integration

```text
Fusion complete.
- {{N}} candidates staged to integration queue
- Sources: {{processed/held}}

Integration candidates ready. Invoke /integrate? (y/n)
```

If user confirms: invoke `/second-brain:integrate`
If user declines: candidates remain staged for later

## Output Types

### Permanent Note Candidate

Single indivisible concept. Will gain 3+ links during integration.

### Framework Candidate

Multi-concept synthesis with:
- Core principles (with evidence)
- Applications (use cases)
- Boundaries (when applies, when doesn't)
- Related frameworks

### Pattern Candidate

Recurring structural insight:
- Description of what recurs
- Occurrences with context
- Triggers and consequences
- Actions (amplify/mitigate)

## Guidelines

**Quality:** Don't force immature insights. Mark confidence clearly.

**Nuance:** Preserve complexity. Note limitations. Keep unresolved tensions.

**Traceability:** Link to sources. Show evidence. Enable audit.

**Multi-path awareness:** Same material may fuse into multiple valid outputs. Alembic `held` state preserves this option.
