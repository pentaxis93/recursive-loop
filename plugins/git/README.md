# Git

Git best practices for multi-agent workflow with clean history.

## Installation

```text
/plugin marketplace add pentaxis93/recursive-loop
/plugin install git@pentaxis93
```

## What It Does

### SessionStart Hook (Always-On)

On every session start, the plugin:

1. **Checks git status** — branch, uncommitted changes, stale branches
2. **Injects methodology** — branch lifecycle rules
3. **Warns if on main** — hard block on code changes to main/master

**You will see warnings if:**

- Currently on `main` or `master` branch
- Uncommitted changes exist
- Stale branches (merged but not deleted) exist

### Hard Rule

Claude will **refuse to make code changes on `main` or `master`**. A feature branch must be created first.

## Skills

### history-surgery

Clean up commit history before PR using interactive rebase, squash, amend, and fixup.

**Triggers:** "clean up commits", "squash", "rebase -i", "before PR"

**Covers:**

- Amend last commit
- Squash multiple commits
- Reword commit messages
- Reorder, split, drop commits
- Fixup and autosquash workflow

### conflict-resolution

Resolve merge conflicts using 3-way merge understanding and resolution strategies.

**Triggers:** merge conflict detected, "resolve conflict"

**Covers:**

- 3-way merge model (base/ours/theirs)
- Resolution workflow
- Accept ours/theirs strategies
- Rerere (remember resolutions)
- Diff3 conflict style

### recovery

Recover from git mistakes using reflog, reset, revert, and cherry-pick.

**Triggers:** "lost commits", "undo", "recover", "messed up"

**Covers:**

- Reflog navigation
- Reset (soft/mixed/hard)
- Revert pushed commits
- Cherry-pick rescue
- Recover deleted branches
- Stash recovery

### worktree

Use git worktrees for multi-agent parallel work without conflicts.

**Triggers:** "parallel work", "multi-agent", "worktree"

**Covers:**

- Create/remove worktrees
- Multi-agent patterns
- Branch locking
- Cleanup workflows

## Branch Lifecycle

The injected methodology enforces:

```text
1. CREATE    git checkout main && git pull && git checkout -b <branch>
     ↓
2. WORK      Make changes, commit atomically
     ↓
3. SYNC      git fetch origin main && git rebase origin/main
     ↓
4. PUSH      git push -u origin <branch>
     ↓
5. PR        gh pr create
     ↓
6. MERGE     Merge PR via GitHub
     ↓
7. CLEANUP   git checkout main && git pull && git branch -d <branch>
```

## Integration

Complements the `/storyline` command:

- **`/storyline`** — Handles commit crafting (atomic, conventional messages)
- **`git` plugin** — Handles branch lifecycle, history cleanup, recovery

## Managing Changes

- **Disable:** `/plugin disable git`
- **Uninstall:** `/plugin uninstall git`
- **Update:** `/plugin update git`
