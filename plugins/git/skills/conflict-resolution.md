---
description: Resolve merge conflicts using 3-way merge understanding and resolution strategies
---

# Conflict Resolution

*When two truths collide, a third must be chosen.*

## The Core Insight

A conflict is not a failure—it's a question. Git is saying: "Two humans changed the same thing differently, and I refuse to guess which one is right."

This is git being humble, not broken. The merge algorithm successfully handled every other line in the codebase; it only stopped where genuine ambiguity exists. Your job is to answer the question it's asking: "What should this code actually be?"

The Hydra grows from avoidance. Face each conflict directly, understand both versions, synthesize the answer. The longer you wait, the more contexts you lose.

---

**When to use:** When git reports "CONFLICT" and stops mid-operation.

**See also:** [recovery.md](recovery.md) if you need to abort and start over, [history-surgery.md](history-surgery.md) for rebasing that may cause conflicts.

---

## Core Workflow

### Understanding Conflicts

A conflict occurs when git cannot automatically reconcile changes. The 3-way merge compares:

```text
        BASE (common ancestor)
       /    \
    OURS     THEIRS
   (HEAD)   (incoming)
```

- **BASE**: The common ancestor commit
- **OURS**: Your current branch (HEAD)
- **THEIRS**: The branch being merged/rebased

**Note:** During rebase, ours/theirs are swapped! Your commits become "theirs" because they're being replayed onto the target.

### Conflict Markers

Git marks conflicts in the file:

```text
<<<<<<< HEAD
Your changes (ours)
=======
Incoming changes (theirs)
>>>>>>> branch-name
```

### Resolution Steps

```bash
# 1. See which files have conflicts
git status

# 2. Open each conflicted file and resolve
#    - Remove conflict markers
#    - Keep the code you want
#    - Test that it works

# 3. Stage resolved files
git add <resolved-file>

# 4. Continue the operation
git rebase --continue   # if rebasing
git merge --continue    # if merging
git cherry-pick --continue  # if cherry-picking
```

### Decision: Keep Which Version?

| Situation | Action |
|-----------|--------|
| Keep only your version | Delete theirs + markers |
| Keep only their version | Delete yours + markers |
| Combine both | Manually merge the code |
| Need to think | `git checkout --conflict=merge <file>` to reset |

---

## Resolution Strategies

### Accept One Side Entirely

```bash
# Keep your version for a file
git checkout --ours <file>
git add <file>

# Keep their version for a file
git checkout --theirs <file>
git add <file>
```

**Rebase warning:** During rebase, `--ours` is the branch you're rebasing onto (main), and `--theirs` is your commits being replayed.

### Accept One Side for All Conflicts

```bash
# During merge: prefer our changes on conflict
git merge -X ours <branch>

# During merge: prefer their changes on conflict
git merge -X theirs <branch>

# During rebase: equivalent strategies
git rebase -X ours <branch>   # prefer main's version
git rebase -X theirs <branch> # prefer your commits' version
```

### Abort and Start Over

```bash
git rebase --abort
git merge --abort
git cherry-pick --abort
```

Returns to the state before the operation started.

---

## Advanced Scenarios

### Rerere: Remember Resolutions

Enable git to remember how you resolved conflicts and auto-apply next time:

```bash
# Enable rerere globally
git config --global rerere.enabled true

# After resolving, git remembers the resolution
# Next time the same conflict occurs, git applies it automatically
```

### Diff3 Conflict Style

Show the base version in conflict markers for more context:

```bash
git config --global merge.conflictstyle diff3
```

Conflicts now show:

```text
<<<<<<< HEAD
Your changes
||||||| base
Original code (common ancestor)
=======
Their changes
>>>>>>> branch
```

### Check Conflict Files

```bash
# List files with conflicts
git diff --name-only --diff-filter=U

# Show conflicts in a file
git diff <file>
```

### Resolve Binary File Conflicts

Binary files can't be merged textually:

```bash
# Keep your version
git checkout --ours <binary-file>

# Keep their version
git checkout --theirs <binary-file>

git add <binary-file>
```

### Skip a Conflicting Commit (Rebase)

If a commit is no longer needed during rebase:

```bash
git rebase --skip
```

---

## Prevention

1. **Rebase frequently** - `git fetch && git rebase origin/main` keeps your branch close to main
2. **Small, focused branches** - Less divergence = fewer conflicts
3. **Communicate** - Know who's working on which files
4. **Pull before push** - Always sync before sharing

---

## Quick Reference

```bash
# See conflicted files
git status
git diff --name-only --diff-filter=U

# Resolve by keeping one side
git checkout --ours <file>    # keep current branch
git checkout --theirs <file>  # keep incoming

# After manual resolution
git add <file>
git rebase --continue  # or merge --continue

# Give up
git rebase --abort
git merge --abort

# Enable conflict memory
git config --global rerere.enabled true

# Better conflict markers
git config --global merge.conflictstyle diff3
```

### Ours vs Theirs Cheat Sheet

| Operation | `--ours` | `--theirs` |
|-----------|----------|------------|
| `git merge` | Current branch (HEAD) | Branch being merged in |
| `git rebase` | Branch rebasing onto (main) | Your commits being replayed |
| `git cherry-pick` | Current branch (HEAD) | Commit being picked |
