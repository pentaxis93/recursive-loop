# Construct

The loading space. Downloadable cognitive programs for Claude Code.

## Installation

```text
/plugin marketplace add pentaxis93/recursive-loop
/plugin install construct@pentaxis93
```

## Skills

### observe-self

Four-pass cognitive method extraction via topology observation.

**Invoke:** `observe-self` after a productive interaction where a novel method emerged.

**The Four Passes:**

```text
WITNESS → LOCATE → MAP → ENCODE
```

1. **WITNESS** — Pure impartial observation. What happened? No judgment.
2. **LOCATE** — Find the inflection point. Where was the shift?
3. **MAP** — Extract the topology. What's the bare structure?
4. **ENCODE** — Make it reproducible. Write the skill.

**Output:** A new skill written to `.claude/skills/`.

---

### prism

Split complex captures into spectrum of perspectives via multi-lens analysis.

**Invoke:** `prism`, "analyze from multiple angles", "process comprehensively", "extract all value"

**The Three Phases:**

```text
RECON → EXTRACT → INTEGRATE
```

1. **RECON** — Survey terrain. Identify content types. Select lenses.
2. **EXTRACT** — One pass per lens. Each reveals what others miss.
3. **INTEGRATE** — Cross-link outputs. Route to destinations. Delete source.

**The 10 Lenses:**

| Lens | Extracts |
|------|----------|
| Actionable | Tasks, next actions |
| Timeline | Urgency, deadlines |
| Relationship | People commitments |
| Decision | Choices, rationale |
| Content | Themes, ideas |
| Learning | Insights, questions |
| Resource | Tools, materials |
| Strategic | Big picture, frameworks |
| Pattern | Recurring themes |
| Emotional | Energy, motivation |

**Use for:** Voice transcriptions, brain dumps, strategic sessions, any rich capture.

---

### observe-system

Close the feedback loop — observe system production, trace usage, diagnose decay, prescribe action.

**Requires:** `second-brain` plugin with `setupComplete: true`

**Invoke:** `observe system`, `system health`, `knowledge audit`, `what's decaying`

**The Four Passes:**

```text
INVENTORY → TRACE → DIAGNOSE → PRESCRIBE
```

1. **INVENTORY** — Catalog system production. What has been created?
2. **TRACE** — Track usage and references. What gets used vs. sits dormant?
3. **DIAGNOSE** — Detect decay and dysfunction. What's failing?
4. **PRESCRIBE** — Generate actionable recommendations. What to prune, revive, fuse?

**Diagnosis Codes:**

| Code | Meaning |
|------|---------|
| `DORMANT_FRAMEWORK` | Framework not referenced in 4+ weeks |
| `STALE_PATTERN` | Pattern not in debriefs for 6+ weeks |
| `UNUSED_SKILL` | Skill never invoked after creation |
| `ORPHANED_NOTE` | Permanent note with 0 backlinks |
| `OVERPLANNING` | Plan completion rate < 30% |

**Output:** System observation report to `archives/intelligence/system-health/`.

---

## System Self-Remembering

The `construct` plugin includes a **SessionStart hook** that provides continuous light awareness.

```text
Pulse (every session) → flags issues → triggers observe-system (monthly)
```

**Two-Layer Awareness:**

| Layer | Mechanism | Frequency |
|-------|-----------|-----------|
| **Pulse** | SessionStart hook | Every session (~2s) |
| **Deep** | observe-system skill | On-demand |

The pulse checks:

- Artifact counts (frameworks, patterns, permanent notes)
- Last observation date (warns if stale > 4 weeks)

When pulse shows `Attention Needed`, run full `observe system`.

This mirrors Gurdjieff's **self-remembering**: constant divided attention (pulse) + intentional self-observation (skill).

---

## Commands

### /construct:prism

Multi-perspective capture analysis (10 lenses).

## Managing Changes

- **Disable:** `/plugin disable construct`
- **Uninstall:** `/plugin uninstall construct`
- **Update:** `/plugin update construct`
