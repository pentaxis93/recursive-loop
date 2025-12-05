# Git Branch Lifecycle

## The Core Insight

A branch is a promise: "This work is isolated until it's ready."

Main is not a workspace—it's a release channel. Every commit on main should be intentional, reviewed, and complete. The feature branch exists so you can make mistakes, experiment, and iterate without consequences to the shared timeline.

The lifecycle is simple: **diverge → work → converge → clean up**. Violate this, and you fight git instead of using it.

---

## Hard Rule

**NEVER make code changes on `main` or `master`.**

If the current branch is `main` or `master`, you MUST create a feature branch before making any code modifications. This is non-negotiable.

---

## Pre-Flight Check (Before New Work)

Run this mental checklist before starting any new task:

| Check | If YES | If NO |
|-------|--------|-------|
| On `main`/`master`? | Create feature branch first | Continue |
| Uncommitted changes? | Commit, stash, or discard first | Continue |
| Current branch merged but not deleted? | Delete branch, checkout main, pull | Continue |
| Stale local branches exist? | Clean up with `git branch -d <branch>` | Continue |

### State → Action Table

| Current State | Action |
|---------------|--------|
| On main, clean | `git checkout -b <type>/<description>` |
| On main, dirty | Stash or discard, then create branch |
| On feature, clean, unmerged | Ready to work |
| On feature, dirty | Commit current work first |
| On feature, merged | `git checkout main && git pull && git branch -d <branch>` |

---

## Branch Naming

Format: `<type>/<short-description>`

| Type | Use For |
|------|---------|
| `feat/` | New features |
| `fix/` | Bug fixes |
| `refactor/` | Code restructuring |
| `docs/` | Documentation only |
| `chore/` | Maintenance, dependencies |

Examples: `feat/user-auth`, `fix/login-redirect`, `refactor/api-handlers`

---

## Workflow: Feature Branch Lifecycle

```text
1. CREATE    git checkout main && git pull && git checkout -b <branch>
     ↓
2. WORK      Make changes, commit atomically (use /storyline for commits)
     ↓
3. SYNC      git fetch origin main && git rebase origin/main
     ↓
4. PUSH      git push -u origin <branch>
     ↓
5. PR        gh pr create (or GitHub UI)
     ↓
6. VERIFY    Check CI status (gh pr checks)
     ↓
7. MERGE     Merge PR via GitHub (creates merge commit)
     ↓
8. CLEANUP   git checkout main && git pull && git branch -d <branch>
```

### CI Verification

After creating a PR, check CI status with `gh pr checks`.

| CI Duration | Approach |
|-------------|----------|
| Fast (< 1 min) | Wait for green before considering PR ready |
| Slow (> 5 min) | Note status is pending, proceed with other work |
| None configured | Skip this step |

Don't block on slow CI—async work is the point. But do verify it passed before merging.

### Why Rebase Before PR?

- Puts your commits on top of latest main
- Creates linear, readable history
- Surfaces conflicts early (before PR review)
- Makes PR diff cleaner (only your changes)

---

## Post-Merge Cleanup

After PR is merged:

```bash
git checkout main
git pull
git branch -d <feature-branch>        # Delete local
git push origin --delete <branch>     # Delete remote (if not auto-deleted)
```

### Stale Branch Hygiene

Periodically clean merged branches:

```bash
# List merged branches (excluding main)
git branch --merged main | grep -v "main"

# Delete all merged branches
git branch --merged main | grep -v "main" | xargs git branch -d
```

---

## Quick Reference

```bash
# Start new work
git checkout main && git pull && git checkout -b feat/thing

# Sync with main before PR
git fetch origin main && git rebase origin/main

# After PR merged
git checkout main && git pull && git branch -d feat/thing

# Clean stale branches
git branch --merged main | grep -v "main" | xargs git branch -d
```
