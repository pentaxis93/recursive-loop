---
description: Recover from git mistakes using reflog, reset, revert, and cherry-pick
---

# Git Recovery

*The reflog remembers what you wish to forget.*

## The Core Insight

Git is designed for recovery. Almost nothing is truly deleted—only unreachable. When you reset, rebase, or amend, the old commits don't vanish; they become orphans, floating in the object database until the garbage collector claims them (~90 days).

The reflog is your time machine. It records every movement of HEAD: every commit, checkout, reset, rebase. When you think you've lost work, you've usually just lost the reference to it.

The Five Stages of Git Grief end at `git reflog`. Start there.

---

**When to use:** When you've made a mistake, lost commits, or need to undo changes.

**See also:** [conflict-resolution.md](conflict-resolution.md) if recovery involves resolving conflicts, [history-surgery.md](history-surgery.md) for controlled history changes.

---

## Core Workflow

### Diagnosis: What Happened?

| Symptom | Likely Cause | Solution |
|---------|--------------|----------|
| "Lost" commits after rebase | Commits still in reflog | Reflog recovery |
| Wrong commit message | Recent commit | `git commit --amend` |
| Committed to wrong branch | Recent commit | Reset + cherry-pick |
| Need to undo a pushed commit | Public history | `git revert` |
| Staged files I don't want | Staged changes | `git restore --staged` |
| Want to discard local changes | Working tree dirty | `git restore` |

### The Reflog: Your Safety Net

Git records every HEAD movement. Nothing is truly lost for ~90 days.

```bash
# View recent HEAD positions
git reflog

# Output:
# abc1234 HEAD@{0}: rebase finished
# def5678 HEAD@{1}: rebase: checkout main
# ghi9012 HEAD@{2}: commit: My work  <-- your "lost" commit
```

### Recover "Lost" Commits

```bash
# 1. Find the commit in reflog
git reflog

# 2. Reset to that point
git reset --hard HEAD@{2}

# OR create a branch from it
git branch recovery-branch HEAD@{2}
```

### Reset: Undo Commits

Three modes with different effects:

| Mode | Commits | Staging Area | Working Tree |
|------|---------|--------------|--------------|
| `--soft` | Undone | Preserved | Preserved |
| `--mixed` (default) | Undone | Cleared | Preserved |
| `--hard` | Undone | Cleared | Cleared |

```bash
# Undo last commit, keep changes staged
git reset --soft HEAD~1

# Undo last commit, unstage changes (default)
git reset HEAD~1

# Undo last commit, discard all changes (DESTRUCTIVE)
git reset --hard HEAD~1

# Undo last 3 commits
git reset --soft HEAD~3
```

### Revert: Undo a Pushed Commit

Creates a new commit that undoes a previous commit. Safe for shared branches.

```bash
# Revert a specific commit
git revert <commit-hash>

# Revert without auto-commit (review first)
git revert --no-commit <commit-hash>

# Revert a merge commit (specify which parent to keep)
git revert -m 1 <merge-commit-hash>
```

---

## Common Recovery Scenarios

### Committed to Wrong Branch

```bash
# On wrong-branch with accidental commit
git log --oneline -1  # note the commit hash

# Move to correct branch
git checkout correct-branch

# Cherry-pick the commit
git cherry-pick <commit-hash>

# Go back and remove from wrong branch
git checkout wrong-branch
git reset --hard HEAD~1
```

### Recover from Bad Rebase

```bash
# Find pre-rebase state in reflog
git reflog
# Look for: "rebase: checkout" or the commit before rebase started

# Reset to pre-rebase state
git reset --hard HEAD@{N}  # N = position in reflog

# OR use ORIG_HEAD (set automatically before dangerous operations)
git reset --hard ORIG_HEAD
```

### Accidentally Deleted a Branch

```bash
# Find the branch tip in reflog
git reflog | grep "branch-name"
# OR
git reflog --all | grep "branch-name"

# Recreate the branch
git branch branch-name <commit-hash>
```

### Discard Uncommitted Changes

```bash
# Discard changes to specific file
git restore <file>

# Discard all working tree changes
git restore .

# Unstage files (keep changes in working tree)
git restore --staged <file>
git restore --staged .

# Nuclear option: discard everything
git reset --hard HEAD
git clean -fd  # removes untracked files too (DANGEROUS)
```

### Recover Stashed Changes

```bash
# List stashes
git stash list

# Apply most recent stash
git stash pop

# Apply specific stash
git stash apply stash@{2}

# Recover accidentally dropped stash (within ~30 days)
git fsck --unreachable | grep commit
git show <commit-hash>  # check if it's your stash
git stash apply <commit-hash>
```

---

## Advanced Recovery

### Cherry-Pick Specific Commits

Extract commits from anywhere and apply to current branch:

```bash
# Pick a single commit
git cherry-pick <commit-hash>

# Pick multiple commits
git cherry-pick <hash1> <hash2> <hash3>

# Pick a range (exclusive of first)
git cherry-pick A..B

# Pick without committing (just apply changes)
git cherry-pick --no-commit <hash>
```

### Recover Deleted File from History

```bash
# Find when file was deleted
git log --all --full-history -- <file-path>

# Restore from the commit before deletion
git checkout <commit-hash>^ -- <file-path>
```

### Undo a Merge

```bash
# If not yet pushed
git reset --hard HEAD~1

# If already pushed (creates revert commit)
git revert -m 1 <merge-commit-hash>
```

### Reset a File to Specific Version

```bash
# Reset file to version from specific commit
git checkout <commit-hash> -- <file-path>

# Reset file to version from main
git checkout main -- <file-path>
```

---

## Prevention

1. **Commit often** - More restore points
2. **Use branches** - Isolate experiments
3. **Check before `--hard`** - `git status` and `git stash` first
4. **Note commit hashes** - Before risky operations: `git rev-parse HEAD`

---

## Quick Reference

```bash
# View reflog
git reflog

# Undo commit, keep changes staged
git reset --soft HEAD~1

# Undo commit, keep changes unstaged
git reset HEAD~1

# Undo commit, discard changes
git reset --hard HEAD~1

# Revert pushed commit (safe)
git revert <hash>

# Recover to reflog position
git reset --hard HEAD@{N}

# Recover to pre-dangerous-operation state
git reset --hard ORIG_HEAD

# Discard working tree changes
git restore <file>

# Unstage files
git restore --staged <file>

# Cherry-pick a commit
git cherry-pick <hash>

# Recreate deleted branch
git branch <name> <hash>
```

### Reset Modes Summary

```text
git reset --soft HEAD~1   # Undo commit → changes staged
git reset HEAD~1          # Undo commit → changes unstaged
git reset --hard HEAD~1   # Undo commit → changes GONE
```
