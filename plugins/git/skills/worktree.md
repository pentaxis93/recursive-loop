---
description: Use git worktrees for multi-agent parallel work without conflicts
---

# Git Worktrees

*Many hands, many directories, one repository.*

## The Core Insight

The traditional git workflow assumes one human, one task, one branch at a time. But reality is messier: you're mid-feature when an urgent bug needs fixing, or multiple agents need to work in parallel without stepping on each other.

Stashing and branch-switching is the amateur solution—fragile, context-destroying, prone to "wait, where did my changes go?"

Worktrees are the professional solution: each branch gets its own directory, its own working tree, but they all share the same git history and objects. Context-switch by changing directories, not by juggling git state.

For multi-agent work, this isn't optional—it's essential. Each agent operates in isolation, commits independently, and merges when ready. No coordination overhead, no stash collisions, no "who has main checked out?"

---

**When to use:** Parallel work on multiple features, code review while working, or multi-agent scenarios.

**See also:** [branch-lifecycle](../assets/branch-lifecycle.md) for the workflow each worktree should follow.

---

## Core Concept

A **worktree** is an additional working directory linked to the same repository. Each worktree checks out a different branch, sharing the same `.git` data.

```text
repo/                    # Main worktree (main branch)
├── .git/
├── src/
└── ...

repo-feat-auth/          # Additional worktree (feat/auth branch)
├── .git -> ../repo/.git # Linked to main repo
├── src/
└── ...

repo-fix-bug/            # Another worktree (fix/bug branch)
├── .git -> ../repo/.git
├── src/
└── ...
```

**Benefits:**

- No stashing required to switch context
- Multiple agents can work simultaneously
- Each worktree has its own working directory state
- All share the same git history and remotes

---

## Core Workflow

### Create a Worktree

```bash
# Create worktree with new branch
git worktree add ../repo-feat-auth -b feat/auth

# Create worktree with existing branch
git worktree add ../repo-feat-auth feat/auth

# Create worktree from specific commit/branch
git worktree add ../repo-hotfix main
```

**Naming convention:** `<repo-name>-<branch-slug>`

### List Worktrees

```bash
git worktree list

# Output:
# /path/to/repo           abc1234 [main]
# /path/to/repo-feat-auth def5678 [feat/auth]
# /path/to/repo-fix-bug   ghi9012 [fix/bug]
```

### Remove a Worktree

```bash
# Remove after work is done (branch merged)
git worktree remove ../repo-feat-auth

# Force remove (discards uncommitted changes)
git worktree remove --force ../repo-feat-auth

# Clean up stale worktree references
git worktree prune
```

### Workflow for New Feature

```bash
# 1. From main repo, create worktree with new branch
cd /path/to/repo
git worktree add ../repo-feat-thing -b feat/thing

# 2. Work in the new worktree
cd ../repo-feat-thing
# ... make changes, commit ...

# 3. Push and create PR
git push -u origin feat/thing
gh pr create

# 4. After PR merged, clean up
cd /path/to/repo
git worktree remove ../repo-feat-thing
git branch -d feat/thing
```

---

## Multi-Agent Patterns

### Pattern 1: One Worktree Per Agent

Each agent gets its own worktree and branch:

```bash
# Agent 1 setup
git worktree add ../repo-agent1-task -b feat/agent1-task

# Agent 2 setup
git worktree add ../repo-agent2-task -b feat/agent2-task

# Agents work in parallel, no conflicts
```

### Pattern 2: Shared Repo, Isolated Branches

Agents share the main worktree but work on separate branches:

```bash
# Agent 1: creates branch, works, pushes
git checkout -b feat/agent1-task
# ... work ...
git push -u origin feat/agent1-task

# Agent 2: (after Agent 1 switches or stashes)
git checkout -b feat/agent2-task
# ... work ...
```

**Worktree approach is preferred** - avoids stash/switch coordination.

### Pattern 3: Review While Working

```bash
# Main worktree: your current work
cd /path/to/repo  # on feat/my-work

# Create worktree to review PR
git fetch origin pull/123/head:pr-123
git worktree add ../repo-review pr-123

# Review in separate directory, then clean up
git worktree remove ../repo-review
git branch -D pr-123
```

---

## Advanced Scenarios

### Branch Locking

A branch can only be checked out in one worktree at a time. If you try to checkout an already-checked-out branch:

```text
fatal: 'feat/thing' is already checked out at '/path/to/repo-feat-thing'
```

**Solutions:**

- Use the existing worktree
- Create a new branch: `git worktree add ../new-wt -b feat/thing-v2`
- Remove the other worktree first

### Worktree with Detached HEAD

For temporary exploration without a branch:

```bash
git worktree add --detach ../repo-explore abc1234
```

### Move a Worktree

```bash
git worktree move ../repo-old-path ../repo-new-path
```

### Lock a Worktree

Prevent accidental removal:

```bash
git worktree lock ../repo-important
git worktree unlock ../repo-important
```

### Worktrees and Submodules

If repo has submodules, initialize them in each worktree:

```bash
cd ../repo-feat-thing
git submodule update --init --recursive
```

---

## Cleanup Best Practices

### After PR Merged

```bash
# 1. Remove worktree
git worktree remove ../repo-feat-thing

# 2. Delete local branch
git branch -d feat/thing

# 3. Prune any stale references
git worktree prune
```

### Periodic Maintenance

```bash
# List all worktrees
git worktree list

# Prune worktrees whose directories were manually deleted
git worktree prune

# Check for stale worktrees
git worktree list --porcelain | grep -A2 "worktree"
```

### Bulk Cleanup

```bash
# Remove all worktrees for merged branches
for wt in $(git worktree list --porcelain | grep "^worktree" | cut -d' ' -f2 | tail -n+2); do
  branch=$(git -C "$wt" branch --show-current)
  if git branch --merged main | grep -q "$branch"; then
    echo "Removing merged worktree: $wt ($branch)"
    git worktree remove "$wt"
    git branch -d "$branch"
  fi
done
```

---

## Quick Reference

```bash
# Create worktree with new branch
git worktree add ../path -b branch-name

# Create worktree with existing branch
git worktree add ../path branch-name

# List worktrees
git worktree list

# Remove worktree
git worktree remove ../path

# Force remove (discards changes)
git worktree remove --force ../path

# Clean stale references
git worktree prune

# Lock/unlock worktree
git worktree lock ../path
git worktree unlock ../path

# Move worktree
git worktree move ../old ../new
```

### Multi-Agent Checklist

1. Each agent creates its own worktree + branch
2. Work in parallel without coordination
3. Push and PR from each worktree
4. Clean up worktree + branch after merge
5. Run `git worktree prune` periodically
