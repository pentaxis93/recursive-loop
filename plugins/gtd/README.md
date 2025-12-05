# GTD

Getting Things Done execution engine for Obsidian-based second brain systems.

## Installation

```text
/plugin marketplace add pentaxis93/claude-code-plugins
/plugin install gtd@pentaxis93
```

**Post-install:** Run `/setup` to configure GTD vault structure. See [Prerequisites](#prerequisites).

## Skills

### gtd

Three operations: `PROCESS → PLAN → CLOSE`

**Invoke:** `gtd process`, `gtd plan`, or `gtd close`

1. **PROCESS** — Clarify inbox items. Route to projects/areas. Delete processed.
2. **PLAN** — Gather tasks from active projects. Prioritize. Generate daily plan.
3. **CLOSE** — Review accomplishments. Prep tomorrow's focus.

**Requires:** `.claude/brain-config.json` with `brainFolder` path.

## Prerequisites

Requires `second-brain` plugin.

**After installing gtd, run `/setup` to configure GTD structure.**

The setup command (from second-brain) detects gtd and creates:

- `_system/gtd-dashboard.md`
- Standard areas (Career, Health, Personal, Errands, Home)
- GTD inbox structure (Daily/, Fleeting-Notes/)

Already ran `/setup` before installing gtd? Run it again — it's idempotent and will add the missing GTD structure.

## Commands

### /gtd:capture

Append input to daily inbox file with timestamp.

**Invoke:** `/gtd:capture [your thought]`

### /gtd:process-gtd

Clarify and route inbox items (GTD PROCESS).

### /gtd:plan-gtd

Generate prioritized daily plan (GTD PLAN).

### /gtd:close-gtd

Review day and prep tomorrow (GTD CLOSE).

## References

### references/gtd.md

Condensed GTD methodology: five stages, weekly review, horizons of focus.

## Managing Changes

- **Disable:** `/plugin disable gtd`
- **Uninstall:** `/plugin uninstall gtd`
- **Update:** `/plugin update gtd`
