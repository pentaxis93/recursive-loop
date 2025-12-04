---
description: Close the feedback loop — observe system production, trace usage, diagnose decay, prescribe action
---

# Observe System

**The feedback mechanism.** Apply Fourth Way self-observation to the knowledge system itself. Where `observe-self` photographs a single cognitive moment, `observe-system` takes a time-lapse of the entire ecosystem.

## The Core Insight

Production without consumption is accumulation.
Accumulation without pruning is entropy.

The system produces artifacts:

- Frameworks from `fuse`
- Patterns from `fuse`
- Permanent notes from `refine`
- Skills from `observe-self`
- Daily plans from `gtd`

But does it *use* them? Does it *learn* from them?

This closes the loop:

```text
Input → Process → Output → Execute
                              ↓
                    observe-system
                              ↓
              Measure → Learn → Improve
```

---

## Dependency

**Requires:** `second-brain` plugin with `setupComplete: true`

Read `.claude/brain-config.json` to get `brainFolder` path.

---

## Guard Clause

**Before Pass 1:** Check minimum corpus for meaningful observation.

```text
If vault has:
  - < 5 frameworks in 05-Knowledge/consolidated/ OR
  - < 10 permanent notes OR
  - < 4 weeks of dumps/debriefs
-> Exit with INSUFFICIENT_CORPUS
```

**Output if guard fails:**

```text
INSUFFICIENT_CORPUS

The system needs time to produce artifacts before observation is meaningful.

Minimum requirements:
- 5+ frameworks in 05-Knowledge/consolidated/
- 10+ permanent notes
- 4+ weeks of activity (dumps or debriefs)

Current state: [show counts]

Return when the system has more production history.
```

---

## Four-Pass System Observation

```text
INVENTORY → TRACE → DIAGNOSE → PRESCRIBE
```

**Input:** The vault (via `brainFolder` path) and `.claude/skills/` directory.

---

### Pass 1: INVENTORY — Catalog System Production

What has the system created?

**Scan these locations:**

| Artifact Type | Location | Identifying Marker |
|---------------|----------|--------------------|
| Frameworks | `05-Knowledge/consolidated/*.md` | `type: "framework"` in frontmatter |
| Patterns | `05-Knowledge/patterns/*.md` | `type: "pattern"` in frontmatter |
| Permanent Notes | `Permanent Notes/**/*.md` | Standalone notes with wikilinks |
| Skills | `.claude/skills/*.md` | YAML frontmatter present |
| Daily Plans | `Archives/Daily Plans/*.md` | `type: "plan"` or date filename |
| Debriefs | `Archives/Intelligence/checkins/debrief-*.md` | `type: "debrief"` |
| Recon Reports | `Archives/Intelligence/recon/*.md` | `type: "recon"` |

**For each artifact, extract:**

- Path
- Type
- Created date (from frontmatter or file stat)
- Last updated
- Outbound links (wikilinks found)
- Domain (if present)
- Status (if present)

**Output:** Artifact inventory with counts by type and creation timeline.

---

### Pass 2: TRACE — Track Usage and References

What has been used vs. what sits dormant?

**Trace methods:**

| Artifact Type | Usage Signal | Detection Method |
|---------------|--------------|------------------|
| Frameworks | Referenced in new content | Grep `[[framework-name]]` in dumps, notes, debriefs |
| Patterns | Manifested in debriefs | Pattern name appears in "Recurring Themes" sections |
| Permanent Notes | Linked from newer notes | Count backlinks created *after* note creation |
| Skills | Invocations | Skill name mentioned in dumps/debriefs |
| Daily Plans | Completion rate | Compare tasks listed vs tasks checked |

**Usage score calculation:**

```text
usage_score = (
    backlinks_count * 2 +
    mentions_in_dumps * 1 +
    mentions_in_debriefs * 3 +
    explicit_applications * 5
) / weeks_since_creation
```

**Temporal classification:**

- Week 1-2: `fresh` (high activity expected)
- Week 3-4: `stabilizing` (some references expected)
- Week 5+: `mature` (should show sustained use or flag for review)

**Track skill genealogy:**

```text
Skill A (observe-self output)
  └── Referenced in Skill B creation
      └── Referenced in Skill C creation
```

Skills that spawn others have high "generative value" even if not directly invoked.

**Output:** Usage matrix with scores and temporal state per artifact.

---

### Pass 3: DIAGNOSE — Detect Decay and Dysfunction

What's failing?

**Decay detection rules:**

| Condition | Threshold | Diagnosis Code |
|-----------|-----------|----------------|
| Framework not referenced | 4+ weeks | `DORMANT_FRAMEWORK` |
| Pattern not in debriefs | 6+ weeks | `STALE_PATTERN` |
| Skill never invoked after creation | 3+ weeks | `UNUSED_SKILL` |
| Permanent note with 0 backlinks | 4+ weeks | `ORPHANED_NOTE` |
| Plan completion rate | < 30% for 2+ weeks | `OVERPLANNING` |
| Unprocessed dumps accumulating | 10+ dumps | `PROCESSING_BACKLOG` |
| MOC not updated | 4+ weeks | `STALE_MOC` |
| Note with < 3 links | Any | `UNDERLINKING` |

**System metrics to calculate:**

```text
flow_score = (
    dumps_processed_to_permanent / dumps_created
) * (
    permanents_linked_to_frameworks / permanents_created
)
```

Low flow score = knowledge bottleneck somewhere in pipeline.

**Severity classification:**

- **Critical:** Immediate attention (8+ week dormancy, flow_score < 0.2)
- **Warning:** Review needed (4-8 week dormancy, orphans accumulating)
- **Info:** Monitor (minor linking issues, early decay signals)

**Output:** Diagnostic report with flagged items, severity, and system metrics.

---

### Pass 4: PRESCRIBE — Generate Actionable Recommendations

Transform observation into action.

**Prescription categories:**

| Category | Trigger | Recommended Action |
|----------|---------|-------------------|
| **PRUNE** | Dormant 8+ weeks, no genealogy value | Archive to `Archives/Deprecated/` or delete |
| **REVIVE** | Dormant 4-8 weeks, high initial value | Revisit and update; add fresh references |
| **FUSE** | Multiple related patterns/frameworks | Consolidate into single framework |
| **SPLIT** | Overloaded framework (10+ principles) | Decompose into focused units |
| **DEEPEN** | High-use but shallow (< 100 words) | Elaborate with examples and context |
| **CONNECT** | Orphaned but valuable | Suggest specific link targets |
| **RETIRE** | Skill superseded by newer skill | Deprecate and document lineage |

**Priority calculation:**

```text
priority = (
    impact_if_fixed * 3 +
    effort_to_fix * -1 +
    cascade_effects * 2
)
```

**For each prescription, output:**

```markdown
### [CATEGORY]: [artifact name]

**Diagnosis:** [CODE]
**Severity:** [Critical|Warning|Info]

**Evidence:**
- Created: [date]
- Last referenced: [date]
- Backlinks: [count]
- Skill genealogy: [lineage or "None"]

**Recommended Action:**
1. [Step 1]
2. [Step 2]

**Expected Outcome:**
[What changes when this is done]
```

**Action:** Write observation report to vault.

---

## Output

**File:** `{{brainFolder}}/Archives/Intelligence/system-health/observe-system-{{YYYY-MM-DD}}.md`

````markdown
---
type: "system-observation"
date: "{{YYYY-MM-DD}}"
created: "{{YYYY-MM-DD HH:MM}}"
observation_period: "{{start_date}} to {{end_date}}"
artifacts_inventoried: {{count}}
issues_detected: {{count}}
recommendations: {{count}}
tags: ["#meta-cognition", "#system-health", "#observe-system"]
---

# System Observation — {{Date}}

## Executive Summary

**System Health:** {{Healthy|Attention Needed|Degrading|Critical}}

**Key Findings:**
- [Finding 1]
- [Finding 2]
- [Finding 3]

**Top Priority Actions:**
1. [Action]
2. [Action]
3. [Action]

---

## Pass 1: Production Inventory

### Artifact Counts

| Type | Total | This Period | Trend |
|------|-------|-------------|-------|
| Frameworks | {{n}} | {{n}} | {{↑↓→}} |
| Patterns | {{n}} | {{n}} | {{↑↓→}} |
| Permanent Notes | {{n}} | {{n}} | {{↑↓→}} |
| Skills | {{n}} | {{n}} | {{↑↓→}} |
| Daily Plans | {{n}} | {{n}} | {{↑↓→}} |

### Newest Artifacts
- [[artifact]] — {{date}} — {{type}}

---

## Pass 2: Usage Trace

### High-Usage Artifacts (Top 10)

| Artifact | Type | Usage Score | Last Referenced |
|----------|------|-------------|-----------------|
| [[name]] | framework | {{score}} | {{date}} |

### Skill Genealogy

```text
[skill A]
└── spawned: [skill B], [skill C]
```

### Knowledge Flow

```text
Dumps Created:    {{n}}
Dumps Processed:  {{n}} ({{%}}%)
→ Permanent Notes: {{n}}
→ Frameworks:      {{n}}

Flow Score: {{0.0-1.0}}
```

---

## Pass 3: Diagnostic Report

### Critical Issues
[List or "None"]

### Warnings
[List or "None"]

### System Metrics

| Metric | Value | Benchmark | Status |
|--------|-------|-----------|--------|
| Framework utilization | {{%}} | > 60% | {{✓✗}} |
| Note orphan rate | {{%}} | < 10% | {{✓✗}} |
| Skill invocation rate | {{%}} | > 50% | {{✓✗}} |
| Plan completion rate | {{%}} | > 40% | {{✓✗}} |
| Dump processing lag | {{days}} | < 7 days | {{✓✗}} |
| Flow score | {{n}} | > 0.5 | {{✓✗}} |

---

## Pass 4: Prescriptions

### Priority 1
[Prescription block]

### Priority 2
[Prescription block]

---

## Recommendations Summary

### Immediate (This Week)
- [ ] [Action]

### Near-Term (This Month)
- [ ] [Action]

### Strategic (This Quarter)
- [ ] [Action]

---

Observed {{n}} artifacts over {{n}} weeks | {{n}} issues detected | {{n}} prescriptions generated
````

---

## Invocation Triggers

- `observe system`
- `system health`
- `knowledge audit`
- `what's decaying`
- `how is my system doing`

---

## Integration with Pulse Hook

The `system-pulse.sh` hook runs at SessionStart and provides light awareness.
This full skill is for deep periodic analysis.

```text
Pulse (every session) → flags issues → triggers observe-system (monthly)
```

When pulse shows `Attention Needed`, user should run full `observe system`.
