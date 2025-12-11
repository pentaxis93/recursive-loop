---
description: Comprehensive vault library health check with prioritized action list
---

# Maintain

**Gate:** Iron (mechanical) + Silver (judgment items flagged for review)

Comprehensive library health check. Distinguishes mechanical findings (facts) from judgment-needed items (recommendations).

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `{{brainFolder}}/02-areas/Profile.md` exists. If not: prompt for /setup.

Parse scope argument:

- `full` (default) - All checks
- `links` - Dead links, broken embeds only
- `orphans` - Unlinked notes only
- `stale` - Aged content only
- `structure` - MOCs, tag sprawl only
- `frontmatter` - YAML validation only

## Execute

### 1. Mechanical Checks (Iron Gate)

These produce facts, not opinions.

#### Dead Links

Scan all `.md` files for `[[wikilinks]]`:

- Extract link targets
- Check if target file exists
- Report broken links with source file and line number

#### Broken Embeds

Scan for `![[embed]]` syntax:

- Check if embedded file exists
- Report missing embeds with source location

#### Orphan Detection

For each note in `permanent-notes/`, `05-knowledge/`:

- Count inbound links (other files linking TO this note)
- Flag notes with zero inbound links
- Exclude system directories: `.obsidian/`, `_talos/`, `templates/`

#### Frontmatter Validation

For each `.md` file:

- Check YAML block exists and parses
- Verify required fields by note type:
  - permanent-note: `title`, `created`, `type`, `tags`
  - framework: `title`, `created`, `type`
  - project: `title`, `status`
  - area: `title`
- Report missing/malformed fields

#### Empty Notes

Flag files with:

- Only frontmatter, no body content
- Body content < 50 characters (excluding frontmatter)

#### Duplicate Detection

Hash note content (excluding frontmatter):

- Flag exact duplicates
- Flag near-duplicates (>80% similarity by line overlap)
- Report pairs with similarity score

### 2. Judgment Checks (Silver Gate)

These require human decision. Flag, don't fix.

#### Stale Content

Notes meeting ALL criteria:

- Last modified >90 days ago
- Zero inbound links
- Not in `archives/` or `templates/`

Present for review: archive, update, or intentional dormancy?

#### MOC Coverage

Scan topic clusters:

- Count notes sharing common tags or link neighborhoods
- Flag clusters of 5+ notes with no MOC
- Suggest MOC creation candidates

#### Link Density

For permanent notes:

- Count outbound links
- Flag notes with <3 outbound links (Zettelkasten minimum)
- Present for review: isolated by design or missing connections?

#### Tag Sprawl

Aggregate all tags across vault:

- Count usage per tag
- Flag tags used only 1-2 times
- Present for review: consolidate, delete, or emerging category?

#### Archive Candidates

Identify:

- Projects with `status: completed` not in `archives/`
- Projects with all tasks checked
- Reference notes >180 days old with zero recent links

Present for review: ready for archive?

### 3. Classify and Prioritize

Sort findings into priority tiers:

**Critical (Broken Functionality):**

- Dead links in active projects
- Broken embeds
- Malformed frontmatter preventing parsing

**Moderate (Degraded Quality):**

- Orphaned permanent notes
- Near-duplicate content
- Stale MOCs

**Minor (Aesthetic):**

- Tag inconsistency
- Missing optional frontmatter fields
- Low link density

### 4. Output

**File:** `{{brainFolder}}/archives/intelligence/audit/maintain-{{YYYY-MM-DD}}.md`

```markdown
---
type: library-health
created: {{YYYY-MM-DD}}
scope: {{scope}}
tags:
  - maintenance
  - library-health
---

# Library Health Report

**Generated:** {{timestamp}}
**Scope:** {{full/specific}}

---

## Summary

| Category | Count |
|----------|-------|
| Mechanical findings | {{n}} |
| Judgment items | {{n}} |
| Auto-fixable | {{n}} |

**Estimated fix time:** {{duration}}

---

## Mechanical Findings (Iron Gate)

### Critical (Broken Functionality)

{{numbered list with specific file paths, line numbers, issues}}

### Moderate (Degraded Quality)

{{numbered list}}

### Minor (Aesthetic)

{{numbered list}}

**Auto-fixable items:**
{{list items that can be fixed with approval - frontmatter insertion, etc.}}

---

## Judgment Needed (Silver Gate)

### Stale Content Review

| File | Last Modified | Inbound Links | Recommendation |
|------|---------------|---------------|----------------|
| {{path}} | {{date}} | {{count}} | Review: archive/update/keep |

### Structure Recommendations

**MOC Candidates:**

- {{topic cluster}}: {{n}} notes, no organizing structure

**Low Link Density:**

- {{file}}: {{n}} outbound links (minimum 3 recommended)

### Tag Sprawl

| Tag | Usage Count | Recommendation |
|-----|-------------|----------------|
| {{tag}} | {{n}} | Consolidate/delete/keep |

### Archive Candidates

| File | Reason | Last Activity |
|------|--------|---------------|
| {{path}} | {{completed/stale/etc}} | {{date}} |

---

## Recommended Actions

1. {{Highest priority action}}
2. {{Next priority}}
3. {{...}}

---

## Execute

**To auto-fix mechanical items:** "proceed with mechanical fixes"

**Fixable items:**
{{numbered list of what will be fixed}}

**Judgment items require explicit instruction per item.**

---

*Next maintenance recommended: {{date}} or after significant vault changes.*
```

### 5. Execution Mode

If user approves mechanical fixes:

**Auto-fixable operations:**

- Insert missing frontmatter from templates
- (Future: fix simple broken links if unambiguous target exists)

**Never auto-execute:**

- Deletions
- Archives (file moves)
- Merges
- Link additions

Report what was fixed. Re-run affected checks to confirm.

## Constraints

- Never auto-delete content without explicit approval
- Never auto-archive without explicit approval
- Frontmatter fixes use vault standard templates
- Report findings, don't lecture about them
- One complete report per invocation (no partial outputs)
- Respect system directories: `.obsidian/`, `_talos/`, `templates/`

## Integration

- Findings may surface evolution requests → create proposals in `_talos/evolution/1-proposals/`
- Links to `/second-brain:audit` for deeper GTD-focused assessment
- Complements audit (GTD health) with library health (structural integrity)
- Can chain: `maintain` → identify issues → `audit` → assess impact on workflow
