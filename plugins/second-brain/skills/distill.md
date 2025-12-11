---
description: Extract themed content into alembics for focused fusion
---

# Distill

---

## Alchemical Gate

**Classification:** `distill` is an alchemical skill.

**Requirement:** Opus-class servitor required.

```
if model != opus:
    return 403 Forbidden: "Alchemy requires Opus servitor"
```

---

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `{{brainFolder}}/02-areas/Profile.md` exists. If not: prompt for /setup.

Ensure `{{brainFolder}}/00-inbox/alembics/` exists. Create if missing.

## Concepts

**Alembic:** A themed fusion container. Holds extracts relevant to a single synthesis goal.

**Extract:** Content surgically removed from a capture, placed in an alembic.

**Residual:** What remains of a capture after extraction. Re-injected to `00-inbox/`.

**Manifest:** Tracks alembic state, validation, and extract inventory.

## Operations

### 1. Create Alembic

```text
distill create <theme-name>
```

**File:** `{{brainFolder}}/00-inbox/alembics/{{theme-name}}/_manifest.md`

```markdown
---
alembic: "{{theme-name}}"
created: "{{YYYY-MM-DD}}"
theme: |
  {{User-provided description of fusion intent.
   What question does this alembic answer?
   What framework should emerge?}}
status: empty
ready-flag: false
last-validated: null
validation:
  result: null
  failures: []
  warnings: []
  observations: []
---

# Alembic: {{theme-name}}

## Theme
{{Precise definition of fusion intent}}

## Extracts
| File | Added | Source | Brief |
|------|-------|--------|-------|

## Log
- {{YYYY-MM-DD HH:MM}}: Created alembic
```

### 2. Add Extract

```text
distill add <alembic> <source-file> [--partial]
```

**Full extraction:** Entire capture moves to alembic.

**Partial extraction (`--partial`):**

1. Display source content
2. Ask: "Which content belongs to theme `{{alembic}}`?"
3. Extract selected content → alembic
4. Generate residual (source − extracted)
5. Write residual to `00-inbox/` with suffix `-residual`
6. Delete or archive original based on source location

**Extract file:** `{{brainFolder}}/00-inbox/alembics/{{alembic}}/extract-{{NNN}}.md`

```markdown
---
title: "Extracted: {{concept}}"
type: extract
source: "{{path/to/original}}"  # Only if source is archived
extracted: "{{YYYY-MM-DD}}"
alembic: "{{theme-name}}"
---

{{extracted content}}
```

**Provenance rule:**

- Source archived → include `source:` path
- Source active/deleted → omit `source:` (content lives in extract now)

**After extraction:**

1. Update manifest `## Extracts` table
2. Add log entry
3. Set `status: pending-review`
4. Trigger validation

### 3. Remove Extract

```text
distill remove <alembic> <extract-file>
```

1. Read extract content
2. Ask: "Re-inject to inbox, or discard?"
   - Re-inject → Write to `00-inbox/` as capture
   - Discard → Delete extract
3. Remove from manifest table
4. Add log entry
5. Trigger validation

### 4. Validate Alembic

```text
distill validate <alembic>
```

**Talos performs validation:**

#### Structural Checks

| Check | Method |
|-------|--------|
| Manifest exists | File exists at `_manifest.md` |
| Extracts exist | All files in table exist |
| Source integrity | Archived sources resolve (if `source:` present) |

#### Semantic Checks

| Check | Method |
|-------|--------|
| Thematic coherence | Each extract content ↔ theme definition alignment |
| Redundancy | Pairwise extract comparison, flag >30% overlap |

#### Advisory Observations

- Extract count and diversity assessment
- Inbox scan for potentially related unprocessed content
- Suggestions for theme refinement

**Validation Output:**

Update manifest frontmatter:

```yaml
last-validated: "{{YYYY-MM-DD HH:MM}}"
validation:
  result: pass | fail
  failures:
    - "{{blocking issue}}"
  warnings:
    - "{{advisory flag}}"
  observations:
    - "{{contextual note}}"
```

**Status Transitions:**

| Current | Event | Next |
|---------|-------|------|
| empty | first extract added | pending-review |
| pending-review | validation passes | valid |
| pending-review | validation fails | invalid |
| valid | mutation | pending-review |
| invalid | mutation/fix | pending-review |
| valid | user sets ready-flag | ready-for-fusion |
| ready-for-fusion | fuse executes | fused |
| fused | user approves | [delete alembic] |

Add log entry with validation result.

### 5. Mark Ready

```text
distill ready <alembic>
```

1. Run validation
2. If `status: valid`:
   - Set `ready-flag: true`
   - Set `status: ready-for-fusion`
   - Log entry
3. If `status: invalid`:
   - Report failures
   - Do not set ready

### 6. List Alembics

```text
distill list
```

Scan `00-inbox/alembics/*/` for manifests.

Output:

| Alembic | Status | Extracts | Last Validated |
|---------|--------|----------|----------------|
| {{name}} | {{status}} | {{count}} | {{date}} |

### 7. Inspect Alembic

```text
distill inspect <alembic>
```

Display:

- Full manifest
- Theme description
- Extract summaries
- Validation state
- Observations/warnings

## Integration with Fuse

When `fuse` is invoked:

1. Check for alembics with `status: ready-for-fusion`
2. If found, ask: "Fuse from alembic `{{name}}`, or scan vault?"
3. If alembic selected:
   - Use alembic extracts as sole input
   - Skip vault scan
   - After fusion approved: delete alembic folder

## Residual Handling

When partial extraction creates residual:

**Residual file:** `{{brainFolder}}/00-inbox/{{original-name}}-residual.md`

```markdown
---
title: "{{original-title}} (Residual)"
type: dump
created: "{{original-date}}"
residual-from: "{{original-path}}"
extracted-to:
  - "alembics/{{theme1}}/extract-001.md"
status: captured
---

{{remaining content after extraction}}
```

Residual re-enters normal processing pipeline via `/process-inbox` or `refine`.

## Workflow Example

```text
1. User runs dump, captures mixed themes A, B, C

2. distill create "theme-a"
   → Creates alembic with theme definition

3. distill add theme-a dump-2024-01-15.md --partial
   → Extracts A-relevant content
   → Residual with B+C content → 00-inbox/

4. distill add theme-a dump-2024-01-20.md --partial
   → Extracts more A-relevant content
   → Validation runs automatically

5. distill validate theme-a
   → Talos checks coherence
   → Status: valid (1 warning: "thin coverage")

6. User adds more extracts over time...

7. distill ready theme-a
   → Status: ready-for-fusion

8. fuse
   → "Fuse from alembic theme-a?"
   → Yes → Framework created from alembic contents
   → User approves → Alembic deleted
```

## Quality Guardrails

**Before extraction:**

- Read source fully
- Understand theme definition
- Identify clear boundaries

**During extraction:**

- Preserve context needed for standalone understanding
- Don't over-extract (leave related-but-different content)
- Don't under-extract (get all relevant material)

**Validation criteria:**

- Coherence: Does extract serve stated theme?
- Sufficiency: Enough material for meaningful synthesis?
- Redundancy: Are extracts distinct contributions?

## Error Handling

| Error | Response |
|-------|----------|
| Alembic not found | List available alembics |
| Extract not found | List extracts in alembic |
| Validation fails | Report failures, suggest fixes |
| Source missing (for provenance) | Warn, continue without source link |
| Theme undefined | Prompt for theme definition |

## Commands Summary

| Command | Purpose |
|---------|---------|
| `distill create <name>` | Create new alembic |
| `distill add <alembic> <source> [--partial]` | Add extract |
| `distill remove <alembic> <extract>` | Remove extract |
| `distill validate <alembic>` | Run validation |
| `distill ready <alembic>` | Mark ready for fusion |
| `distill list` | List all alembics |
| `distill inspect <alembic>` | Show alembic details |
