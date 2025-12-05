---
description: Internal vault reconnaissance and system health assessment
---

# Audit

**CRITICAL:** This skill performs INTERNAL vault scanning only.
Do NOT use WebSearch. Scan vault files for system health assessment.

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `_system/profile.md` exists. If not: prompt for /setup.

Read:

- `_system/profile.md` → name, role, active projects
- `_system/gtd-dashboard.md` → current focus, recent activity

## Execute

### 1. Inbox Status

Scan `{{brainFolder}}/00-inbox/`:

- Count capture files (flat in inbox)
- Count files in `dumps/`
- Report status:
  - GREEN: Empty (GTD compliant)
  - YELLOW: 1-4 items (needs processing)
  - RED: 5+ items (urgent processing needed)

### 2. Project Survey

Scan `{{brainFolder}}/01-projects/`:

- Count active projects (status: active)
- Count open tasks per project (unchecked `- [ ]`)
- Identify HIGH priority projects (⏫ or high: prefix)
- Flag completed projects still marked active
- Flag stalled projects (no modification >7 days)

### 3. Area Assessment

Scan `{{brainFolder}}/02-areas/`:

- Count area files
- Count relationship files in `relationships/`
- Identify open tasks per area
- Note waiting-on items (#waiting tag)

### 4. Knowledge Assets

Survey `{{brainFolder}}/05-knowledge/`:

- Count frameworks in `consolidated/`
- Count patterns in `patterns/`
- Note recent additions (modified <7 days)

Survey `{{brainFolder}}/permanent-notes/`:

- Count permanent notes
- Identify orphaned notes (fewer than 3 links)

### 5. Recent Activity

Read `_system/gtd-dashboard.md`:

- Extract today's focus
- Extract recent completions
- Note deferred work
- Identify active context

### 6. Friction Points

Identify and categorize by severity:

**HIGH:**

- Projects without next actions
- Tasks due within 3 days
- Inbox RED status

**MEDIUM:**

- Completed projects not archived
- Deferred high-priority work
- Tasks due within 7 days

**LOW:**

- Stale projects (>7 days no activity)
- Orphaned permanent notes
- Inbox YELLOW status

### 7. Tactical Recommendations

Generate actionable recommendations:

**IMMEDIATE (Today/Tomorrow):**

- Archive completed projects
- Process RED inbox items
- Address overdue tasks

**SHORT-TERM (This Week):**

- Review stalled projects
- Process YELLOW inbox
- Follow up on waiting items

**MEDIUM-TERM (Next Week):**

- Knowledge consolidation candidates
- Project milestone reviews
- Area responsibility checks

**STRATEGIC:**

- System pattern observations
- Workflow improvement suggestions
- Capacity/energy notes

### 8. System Health

Assess overall health metrics:

**GTD Compliance:**

- Inbox empty? (Y/N)
- Single source of truth maintained? (Y/N)
- Every project has next action? (Y/N)

**Organizational Integrity:**

- PARA structure intact? (Y/N)
- Zettelkasten linking active? (Y/N)
- Recent consolidation work? (Y/N)

**Processing Rhythm:**

- Daily processing occurring? (Y/N)
- Weekly review happening? (Y/N)
- Dashboard current? (Y/N)

### 9. Output

**File:** `{{brainFolder}}/archives/intelligence/audit/audit-{{YYYY-MM-DD}}.md`

```markdown
---
type: audit
created: {{YYYY-MM-DD}}
modified: {{YYYY-MM-DD}}
tags:
  - audit
  - intelligence
  - system-health
---

# Vault Audit: {{YYYY-MM-DD}}

**Operator:** {{Assistant identity}}
**Subject:** {{User name}}
**Scope:** Full vault survey

---

## Executive Summary

**Vault Status:** {{Healthy/Needs Attention/Critical}}

**Task Load:** {{X}} open project tasks, {{Y}} open area tasks.

**Critical Finding:** {{Most important issue or "None"}}

**Tactical Priority:** {{Top priority for immediate action}}

---

## Domain Assessment

### I. Inbox Status {{GREEN/YELLOW/RED}}

**Location:** `{{brainFolder}}/00-inbox/`

- **Captures:** {{count}}
- **Dumps:** {{count}}
- **Status:** {{color}} - {{explanation}}

---

### II. Active Projects ({{count}} Total)

#### HIGH PRIORITY PROJECTS

**1. {{Project Name}}**
- **Status:** Active, {{priority}}
- **Task Load:** {{open}}/{{total}} tasks
- **Next Action:** {{next action or "MISSING"}}
- **Last Modified:** {{date}}

{{Repeat for each high priority project}}

#### OTHER ACTIVE PROJECTS

{{List remaining projects with key metrics}}

#### FLAGS

- **Completed but not archived:** {{list or "None"}}
- **Stalled (>7 days):** {{list or "None"}}
- **Missing next action:** {{list or "None"}}

---

### III. Areas of Responsibility ({{count}} Active)

**Area Files:** {{count}}
**Relationship Files:** {{count}}

{{Brief assessment of each area with open task counts}}

---

### IV. Knowledge Assets

**Frameworks:** {{count}} in `05-knowledge/consolidated/`
**Patterns:** {{count}} in `05-knowledge/patterns/`
**Permanent notes:** {{count}}
**Recent Additions:** {{list items modified <7 days}}

---

### V. Recent Activity

{{Summary from gtd-dashboard.md}}

- **Today's Focus:** {{focus}}
- **Recent Completions:** {{list}}
- **Deferred Work:** {{list}}

---

## Friction Points

### HIGH Severity
{{List with descriptions}}

### MEDIUM Severity
{{List with descriptions}}

### LOW Severity
{{List with descriptions}}

---

## Tactical Recommendations

### IMMEDIATE (Today/Tomorrow)
1. {{action}}
2. {{action}}

### SHORT-TERM (This Week)
1. {{action}}
2. {{action}}

### MEDIUM-TERM (Next Week)
1. {{action}}
2. {{action}}

### STRATEGIC
{{Long-term observations and suggestions}}

---

## System Health

**GTD Compliance:** {{HIGH/MEDIUM/LOW}}
- Inbox empty: {{Y/N}}
- Single source of truth: {{Y/N}}
- Projects have next actions: {{Y/N}}

**Organizational Integrity:** {{HIGH/MEDIUM/LOW}}
- PARA structure: {{Y/N}}
- Zettelkasten linking: {{Y/N}}
- Recent consolidation: {{Y/N}}

**Processing Rhythm:** {{HIGH/MEDIUM/LOW}}
- Daily processing: {{Y/N}}
- Weekly review: {{Y/N}}
- Dashboard current: {{Y/N}}

---

## Closing Assessment

**Vault Status:** {{summary}}

**Critical Path:** {{what needs attention most}}

**Recommendation:** {{primary recommended action}}

---

*Next audit recommended: {{date}} or user request.*
```

### 10. Follow-up

Suggest:

- **gtd skill (PROCESS)** - If inbox needs processing
- **gtd skill (PLAN)** - If daily plan needed
- **fuse skill** - If knowledge consolidation candidates identified
- **refine skill** - If raw captures need processing
