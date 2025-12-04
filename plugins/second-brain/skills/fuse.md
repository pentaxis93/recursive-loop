---
description: Fuse scattered insights into frameworks through pattern synthesis
---

# Fuse

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `_system/profile.md` exists. If not: prompt for /setup.

## Execute

### 1. Gather

Scan vault for unprocessed content:

| Location | Content |
|----------|---------|
| `00-Inbox/dumps/` | Unprocessed dumps |
| `01-Projects/*/dumps/` | Project dumps |
| `Archives/Intelligence/recon/` | Recon reports |

Ask: "Time period? (week, month, quarter, all, custom)"

Identify items with `status: "captured"` or missing consolidation metadata.

### 2. Detect Patterns

| Analysis | Focus |
|----------|-------|
| Frequency | Themes across multiple docs, recurring concerns |
| Temporal | How thinking evolved, inflection points |
| Domain | Cross-domain correlations (personal↔professional↔project) |
| Contradiction | Conflicts, tensions, perspective shifts |
| Meta | Decision patterns, problem-solving, energy/creativity |

### 3. Synthesize Frameworks

From patterns → principles:

1. **Identify Core Principles** - What rules/heuristics emerge?
2. **Test Against Evidence** - Do sources support? Counter-examples?
3. **Define Boundaries** - When applies, when doesn't, assumptions
4. **Create Applications** - Use cases, decision templates

### 4. Output

#### Framework File

**File:** `{{brainFolder}}/05-Knowledge/consolidated/{{name}}-framework.md`

```markdown
---
type: "framework"
domain: "{{domain}}"
framework: "{{name}}"
created: "{{YYYY-MM-DD}}"
last_updated: "{{YYYY-MM-DD}}"
source_documents: {{count}}
status: "emerging|working|stable"
tags: ["#framework", "#consolidated", "#{{topic}}"]
---

# {{Framework Name}}

## Overview
{{Description and purpose}}

**Status:** {{Emerging|Working|Stable}}
**Sources:** {{count}} documents

---

## Core Principles

### Principle 1: {{Name}}
**Statement:** {{Clear principle}}

**Evidence:**
- [[dump-YYYY-MM-DD]] - {{insight}}
- [[recon-YYYY-MM-DD]] - {{evidence}}

**Confidence:** {{High|Medium|Low}} - {{reasoning}}

---

## Applications

### {{Use Case}}
**When:** {{situation}}

**How:**
1. {{step}}

**Expected:** {{outcome}}

---

## Boundaries

**Works when:**
- {{condition}}

**Fails when:**
- {{anti-condition}}

**Pitfalls:**
- {{pitfall}}

---

## Evolution

### {{Date Range}}: {{Phase}}
**Catalysts:** {{triggers}}
**Shifts:** {{changes}}

---

## Related
- [[other-framework]] - {{relationship}}

---

*Fused from {{X}} sources | Confidence: {{level}} | Status: {{status}}*
```

#### Pattern File

**File:** `{{brainFolder}}/05-Knowledge/patterns/pattern-{{name}}.md`

```markdown
---
type: "pattern"
pattern: "{{name}}"
created: "{{YYYY-MM-DD}}"
domains: ["{{domain1}}", "{{domain2}}"]
frequency: "high|medium|low"
tags: ["#pattern", "#analysis"]
---

# Pattern: {{Name}}

## Description
{{What recurs}}

**Frequency:** {{X}} occurrences over {{timeframe}}
**Domains:** {{where it appears}}

---

## Occurrences

### {{Date}} - [[source]]
**Context:** {{situation}}
**Manifestation:** {{how it appeared}}
**Outcome:** {{result}}

---

## Analysis

**Triggers:** {{what causes it}}
**Consequences:** {{what follows}}
**Actions:** {{amplify if positive, mitigate if negative}}
```

#### Timeline Entry

**File:** `{{brainFolder}}/05-Knowledge/timeline/{{topic}}-evolution-{{YYYY-MM}}.md`

```markdown
---
type: "timeline"
topic: "{{theme}}"
date_range: "{{start}} to {{end}}"
created: "{{YYYY-MM-DD}}"
tags: ["#timeline", "#evolution"]
---

# Evolution: {{Theme}}

## Shift
**From:** {{initial state}}
**To:** {{end state}}
**Key Change:** {{fundamental shift}}

## Catalysts
- [[source]] - {{trigger}}

## Evidence Trail
- [[early-doc]] - {{initial thinking}}
- [[later-doc]] - {{evolved understanding}}

## Impact
**Decisions:** {{effect}}
**Frameworks:** {{created/updated}}
```

### 5. Delete Processed Dumps

After successful fusion:

```bash
rm "{{dump_path}}"
```

**Rationale:**
- GTD canon: processed items leave system
- Git preserves history if needed
- Insights live in frameworks
- Clean vault = reduced cognitive load

### 6. Route Tasks

| Task Type | Destination |
|-----------|-------------|
| Framework ready | `02-Areas/Zettelkasten.md` High Priority |
| Needs analysis | `02-Areas/Zettelkasten.md` Someday/Maybe |
| Pattern to monitor | `02-Areas/Zettelkasten.md` Waiting On |
| Framework application | Relevant project |

### 7. Integrate

#### Link to Projects/Areas

Calculate relevance:

| Match | Points |
|-------|--------|
| Domain tag match | +3 |
| Topic tag overlap | +2 |
| Project in sources | +3 |
| Name in content | +1 |

Threshold: >= 3 points → add link

Update `## 🔗 Related` → `**Resources:**` in projects
Update `## 📚 Resources & References` in areas

#### Update MOC

**File:** `{{brainFolder}}/05-Knowledge/MOC-Consolidated-Knowledge.md`

```markdown
---
type: "moc"
title: "Knowledge Index"
last_updated: "{{YYYY-MM-DD}}"
tags: ["#moc", "#knowledge"]
---

# Knowledge Index

## Frameworks by Domain

### Professional
- [[framework]] - {{description}} ({{status}})

### Personal
- [[framework]] - {{description}} ({{status}})

---

## Patterns
- [[pattern-name]] - {{description}} ({{frequency}})

---

## Applied To

### [[framework]]
**Projects:** [[project1]], [[project2]]

---

*Frameworks: {{X}} | Patterns: {{Y}}*
```

#### Update Profile (if strategic)

If framework mentions "strategic", "goal", "priority" or supports stated goals:

Add to `_system/profile.md` under `## Active Knowledge Frameworks`:

```markdown
### [[framework]]
**Applies to:** {{contexts}}
**Key Guidance:** {{summary}}
```

### 8. Confirm

Report:
- Documents processed
- Frameworks created/updated
- Patterns identified
- Tasks routed
- Links created

## Guidelines

**Quality:** Don't force immature insights. Mark status clearly.

**Nuance:** Preserve complexity. Note limitations. Keep unresolved tensions.

**Traceability:** Link to sources. Show evidence. Enable audit.

**Living:** Frameworks evolve. Iterate. Version via Git.
