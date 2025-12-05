---
description: Clean up commit history before PR using interactive rebase, squash, amend, and fixup
---

# History Surgery

*The art of making your git history lie beautifully.*

## The Core Insight

Your working history is not your public history. When you're working, you commit often—WIP saves, experiments, "fixed the typo in the last commit." That's healthy. But your PR history should tell a clean story: logical commits, clear messages, reviewable chunks.

History surgery is the reconciliation: take the messy reality of development and reshape it into the clean narrative of intentional changes. No one needs to see how the sausage was made.

**The rule:** Rewrite history before you push. Never after.

---

**When to use:** Before `git push` or `gh pr create`, when commits are messy, have poor messages, or need reorganizing.

**See also:** [recovery.md](recovery.md) if surgery goes wrong, [conflict-resolution.md](conflict-resolution.md) if rebase conflicts arise.

---

## Core Workflow

### Decision: Which Tool?

| Situation | Tool |
|-----------|------|
| Fix the last commit message | `git commit --amend` |
| Add forgotten changes to last commit | `git commit --amend --no-edit` |
| Squash last N commits into one | `git rebase -i HEAD~N` |
| Rewrite multiple commit messages | `git rebase -i HEAD~N` |
| Clean up before PR | `git rebase -i origin/main` |

### Amend: Fix the Last Commit

```bash
# Change the commit message
git commit --amend -m "Better message"

# Add staged changes to last commit (keep message)
git add <file>
git commit --amend --no-edit
```

**Warning:** Never amend commits that have been pushed to a shared branch.

### Squash: Combine Multiple Commits

To squash the last 3 commits into one:

```bash
git rebase -i HEAD~3
```

Editor opens with:

```text
pick abc1234 First commit
pick def5678 Second commit
pick ghi9012 Third commit
```

Change to:

```text
pick abc1234 First commit
squash def5678 Second commit
squash ghi9012 Third commit
```

Save and close. Next editor: write the combined commit message.

### Reword: Fix Older Commit Messages

```bash
git rebase -i HEAD~3
```

Change `pick` to `reword` (or `r`) for commits needing new messages:

```text
pick abc1234 First commit
reword def5678 Bad message here
pick ghi9012 Third commit
```

Save. Editor opens for each `reword` commit to edit its message.

---

## Advanced Scenarios

### Reorder Commits

In interactive rebase, simply change the line order:

```text
pick ghi9012 Third commit   # Now first
pick abc1234 First commit   # Now second
pick def5678 Second commit  # Now third
```

**Caution:** Reordering can cause conflicts if commits depend on each other.

### Split a Commit

To split one commit into multiple:

```bash
git rebase -i HEAD~3
```

Mark the commit as `edit`:

```text
edit abc1234 Big commit to split
pick def5678 Next commit
```

When rebase stops at that commit:

```bash
git reset HEAD~1              # Undo commit, keep changes staged
git add <some-files>
git commit -m "First part"
git add <other-files>
git commit -m "Second part"
git rebase --continue
```

### Drop a Commit

Delete the line or change `pick` to `drop`:

```text
pick abc1234 Keep this
drop def5678 Delete this
pick ghi9012 Keep this too
```

### Fixup: Squash Without Message Prompt

Like `squash` but automatically uses the first commit's message:

```text
pick abc1234 Main commit
fixup def5678 Small fix (message discarded)
fixup ghi9012 Another fix (message discarded)
```

### Autosquash Workflow

Mark commits for automatic squashing:

```bash
# Create a fixup commit for abc1234
git commit --fixup=abc1234

# Later, autosquash applies them automatically
git rebase -i --autosquash origin/main
```

---

## Handling Conflicts During Rebase

If conflicts occur:

```bash
# 1. Resolve conflicts in the files
# 2. Stage resolved files
git add <resolved-file>

# 3. Continue rebase
git rebase --continue

# OR abort and return to original state
git rebase --abort
```

---

## Safety Rules

1. **Never rewrite pushed history** on shared branches
2. **Always have a backup** - note the commit hash before rebasing: `git rev-parse HEAD`
3. **If confused, abort** - `git rebase --abort` returns to original state
4. **Recovery** - use `git reflog` to find pre-rebase state

---

## Quick Reference

```bash
# Amend last commit message
git commit --amend -m "New message"

# Add to last commit
git add . && git commit --amend --no-edit

# Interactive rebase last N commits
git rebase -i HEAD~N

# Rebase onto main (clean up feature branch)
git rebase -i origin/main

# Abort failed rebase
git rebase --abort

# Continue after resolving conflicts
git rebase --continue

# Create fixup commit
git commit --fixup=<commit-hash>

# Auto-apply fixups
git rebase -i --autosquash origin/main
```

### Rebase Commands

| Command | Action |
|---------|--------|
| `pick` / `p` | Keep commit as-is |
| `reword` / `r` | Keep commit, edit message |
| `edit` / `e` | Stop to amend or split |
| `squash` / `s` | Combine with previous, edit message |
| `fixup` / `f` | Combine with previous, discard message |
| `drop` / `d` | Delete commit |

---

## Worked Example: Cleaning Up Before PR

**Starting state** (messy development history):

```text
$ git log --oneline
a1b2c3d WIP
f4e5d6c fix typo
7890abc more auth stuff
1234def WIP save
5678ghi start auth feature
```

**Goal:** Clean this into two logical commits.

**Step 1:** Start interactive rebase

```bash
git rebase -i HEAD~5
```

**Step 2:** Editor opens—rearrange and mark:

```text
pick 5678ghi start auth feature
fixup 1234def WIP save
fixup 7890abc more auth stuff
fixup f4e5d6c fix typo
fixup a1b2c3d WIP
```

**Step 3:** Save and close. All commits squash into the first.

**Step 4:** Now you have one commit. If you want to split it into logical pieces, use `edit` instead and `git reset HEAD~1` to unstage, then recommit in parts.

**Result:**

```text
$ git log --oneline
9876xyz feat(auth): implement user authentication
```

*One clean commit. No one knows about the five WIP saves.*
