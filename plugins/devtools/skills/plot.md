---
description: Weave stories into plot arcs (PRs) across managed repositories
---

# Plot

Analyze uncommitted changes across all managed repositories, identify narrative threads, and submit coherent PRs.

> Stories tell what happened. Plot tells why it matters.

---

## Trigger

`/devtools:plot` or "plot", "create PRs", "submit changes"

---

## Scope

Read managed repositories from Talos config: `{{brainFolder}}/02-areas/Talos-Administration.md`

Section: `## Managed Repositories`

```yaml
repositories:
  - path: /home/pentaxis/src/eterne
    remote: origin
    main: main
  - path: /home/pentaxis/.claude/plugins/marketplaces/recursive-loop
    remote: origin
    main: main
```

If section missing: prompt user to define scope.

---

## Pass 1: RECON

**Goal:** Understand all uncommitted changes, identify plot threads.

### For each managed repository

```bash
git -C {{path}} status
git -C {{path}} diff
git -C {{path}} diff --cached
```

### Analyze

1. **What changed** - files, additions, deletions, modifications
2. **Why it changed** - infer intent from context, recent conversation
3. **What belongs together** - changes serving same narrative purpose

### Identify Plot Threads

Group changes into logical PRs. A plot thread:

- Has a single coherent purpose
- May span multiple repos (cross-repo feature)
- Contains all related changes (no orphans)
- Can be reviewed independently

### Output: Plot Plan

```markdown
## Plot Plan

### Thread 1: feature/gtd-idempotent-plan
**Purpose:** Time-aware idempotent GTD planning
**Repos:** recursive-loop
**Changes:**
- plugins/gtd/skills/gtd.md (rewrite)
**PR Title:** feat(gtd): time-aware idempotent PLAN operation
**Dependencies:** none

### Thread 2: feature/park-command
**Purpose:** Context preservation for blocked work
**Repos:** recursive-loop, eterne
**Changes:**
- recursive-loop: plugins/devtools/{commands,skills}/park.md
- eterne: brain/02-areas/GTD-Dashboard.md
**PR Title:** feat(devtools): park command for context preservation
**Dependencies:** none
**Note:** Cross-repo - create linked PRs
```

### User Checkpoint

Present plan. User approves, modifies, or rejects.

**Never proceed without approval.**

---

## Pass 2: EXECUTE

For each approved plot thread, in dependency order:

### 2.1 Create Branch

```bash
git -C {{path}} checkout -b {{branch-name}}
```

For cross-repo threads: create branch in all affected repos.

### 2.2 Commit

Invoke `story` principles:

- Atomic commits
- Complete (code + docs)
- Semantic messages
- Intent over implementation

Use `git add -p` if needed to split changes.

### 2.3 Push

```bash
git -C {{path}} push -u origin {{branch-name}}
```

### 2.4 Create PR

Extract repo slug from remote URL:

```bash
git -C {{path}} remote get-url {{remote}}
# Parse: git@github.com:owner/repo.git → owner/repo
```

Create PR:

```bash
gh pr create --repo {{owner/repo}} \
  --title "{{PR title}}" \
  --body "$(cat <<'EOF'
## Summary
{{Purpose and what it accomplishes}}

## Changes
{{Bullet list of key changes}}

## Testing
{{How to verify}}

{{#if cross-repo}}
## Related PRs
- {{link to related PR in other repo}}
{{/if}}
EOF
)"
```

### 2.5 Monitor & Merge

**Active monitoring with fast-path merge.**

```bash
# Poll CI status (10 second window)
for i in {1..10}; do
  STATUS=$(gh pr checks {{pr-number}} --json state --jq '.[].state' | sort -u)
  if [[ "$STATUS" == "SUCCESS" ]]; then
    # Fast-path: all checks passed
    gh pr merge {{pr-number}} --squash --delete-branch
    break
  elif [[ "$STATUS" == *"FAILURE"* ]]; then
    # CI failed - attempt remediation
    break
  fi
  sleep 1
done
```

#### Decision Matrix

| CI Status @ 10s | Action |
|-----------------|--------|
| All SUCCESS | Auto-merge (squash), delete branch, continue |
| Any FAILURE | Attempt fix (see remediation below) |
| Still PENDING | Report to user, continue to next thread |

#### Remediation (on failure)

1. Fetch failure output: `gh pr checks {{pr-number}} --json name,output`
2. Analyze error (lint, test, build)
3. Attempt fix (max 3 attempts)
4. Commit: `fix(ci): {{description}}`
5. Push and re-monitor (restart 10s window)
6. If still failing after 3 attempts: report to user, continue

#### Report Format

After each PR (merged, pending, or failed):

```text
PR #{{number}}: {{title}}
URL: {{url}}
CI: {{status}} ({{duration}})
Action: {{merged | pending | failed - reason}}
```

### 2.6 Thread Summary

After all threads processed:

```text
## Plot Summary

| PR | Title | CI | Action |
|----|-------|----|----|
| #42 | docs: goal taxonomy | ✓ 8s | Merged |
| #43 | feat: PREFLIGHT | ✗ lint | Pending fix |

Merged: 1
Pending: 1
Failed: 0
```

---

## Pass 3: CLEANUP (optional)

After PRs merged (not automatic - user triggers):

```bash
git -C {{path}} checkout main
git -C {{path}} pull
git -C {{path}} branch -d {{branch-name}}
```

---

## Cross-Repo Handling

When a plot thread spans multiple repositories:

1. Create branches in all repos simultaneously
2. Commit changes in each repo
3. Create PRs with cross-references in descriptions
4. Link PRs: "Related: org/other-repo#123"
5. Note merge order if dependencies exist

---

## Git Hygiene Invariants

Plot maintains:

| Branch Type | State |
|-------------|-------|
| main | Clean, passing, deployable |
| feature/* | Active development OR parked with documentation |
| No orphans | Every branch has purpose or gets pruned |

---

## Edge Cases

| Situation | Handling |
|-----------|----------|
| CI unfixable | Park branch, document in Parking Lot, continue |
| Merge conflict | Rebase, resolve, re-push, re-check CI |
| Partial completion | Report successes and failures, park blocked threads |
| Empty thread | Skip with note |
| User abort | Clean up created branches, report state |

---

## State Recovery

If interrupted mid-execution:

1. Check each repo for feature branches
2. Check GitHub for open PRs
3. Resume from last incomplete thread
4. Or: user can `/park` and restart fresh

---

> Stories are told. Plots are woven. Each PR is a narrative arc that advances the codebase's story.
