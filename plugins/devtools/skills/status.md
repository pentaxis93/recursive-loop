---
description: Check git and PR status across all managed repositories
---

# Status

Report on git hygiene and PR state across all managed repositories.

---

## Trigger

`/devtools:status` or "status", "pr status", "check all repos"

---

## Scope

Read managed repositories from: `{{brainFolder}}/02-areas/Talos-Administration.md`

Section: `## Managed Repositories`

---

## Checks

For each managed repository:

### 1. Local State

```bash
git -C {{path}} status --porcelain
```

Report:

- Uncommitted changes (count)
- Staged changes (count)
- Untracked files (count)

### 2. Branch State

```bash
git -C {{path}} branch -vv
```

Report:

- Current branch
- Ahead/behind remote
- Feature branches present

### 3. Open PRs

Extract repo from remote URL:

```bash
git -C {{path}} remote get-url origin
# Parse: git@github.com:owner/repo.git → owner/repo
```

Query GitHub:

```bash
gh pr list --repo {{owner/repo}} --state open --json number,title,headRefName,createdAt
```

Report:

- Count of open PRs
- List with: number, title, branch, age

### 4. CI Status (for open PRs)

```bash
gh pr checks {{number}} --repo {{owner/repo}}
```

Report:

- Passing / Failing / Pending

---

## Output Format

```markdown
## Repository Status

### {{repo-name}}
**Path:** {{path}}
**Branch:** {{current-branch}}

| Metric | Value |
|--------|-------|
| Uncommitted | {{count}} |
| Open PRs | {{count}} |
| CI Status | {{status}} |

{{#if open-prs}}
**Open PRs:**
| # | Title | Branch | Age | CI |
|---|-------|--------|-----|-----|
{{#each open-prs}}
| {{number}} | {{title}} | {{branch}} | {{age}} | {{ci}} |
{{/each}}
{{/if}}

{{#if uncommitted}}
**Uncommitted changes:** Run `/devtools:story` to commit
{{/if}}

---
```

Repeat for each managed repository.

---

## Summary

At end, provide:

```markdown
## Summary

| Repo | Local | PRs | Action Needed |
|------|-------|-----|---------------|
{{#each repos}}
| {{name}} | {{local-status}} | {{pr-count}} | {{action}} |
{{/each}}

{{#if all-clean}}
✓ All repositories clean. No action needed.
{{else}}
**Recommended:** {{next-action}}
{{/if}}
```

---

## Actions Suggested

| State | Suggestion |
|-------|------------|
| Uncommitted changes | `/devtools:story` then `/devtools:plot` |
| Open PRs passing | Review and merge |
| Open PRs failing | Check CI, fix, or park |
| Stale PRs (>7 days) | Review or close |
| Feature branches without PR | Create PR or delete branch |

---

*Status is the first step. Know the state before changing it.*
