# Git Error Decoder

*What git says vs. what git means.*

---

## The Classics

### "fatal: not a git repository"

**Translation:** You're in the wrong directory, or this project was never initialized with git.

**Fix:**

```bash
pwd                          # Where am I?
ls -la                       # Is there a .git folder?
cd /correct/path             # Go where you meant to be
# or
git init                     # If this should be a repo
```

---

### "error: Your local changes would be overwritten"

**Git says:**

```text
error: Your local changes to the following files would be overwritten by checkout:
        file.txt
Please commit your changes or stash them before you switch branches.
```

**Translation:** You have uncommitted changes in files that differ on the target branch. Git refuses to destroy your work.

**Fix:**

```bash
git stash                    # Save changes temporarily
git checkout <branch>        # Now switch
git stash pop                # Restore changes (may conflict)
# or
git commit -am "WIP"         # Commit as work-in-progress
```

---

### "fatal: refusing to merge unrelated histories"

**Translation:** These two branches have no common ancestor. They're strangers. This often happens when combining two separate repos or after a `git init` mishap.

**Fix (if intentional):**

```bash
git merge <branch> --allow-unrelated-histories
```

**Question first:** Should these really be merged? This error often signals a deeper problem.

---

### "! [rejected] (non-fast-forward)"

**Git says:**

```text
! [rejected]        main -> main (non-fast-forward)
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart.
```

**Translation:** Someone else pushed changes you don't have. You can't push until you integrate their work.

**Fix:**

```bash
git fetch origin
git rebase origin/main       # Replay your commits on top
# or
git pull --rebase           # Fetch + rebase in one
git push                    # Now it'll work
```

**Never:** `git push --force` on shared branches (this rewrites history others depend on).

---

### "CONFLICT (content): Merge conflict in..."

**Translation:** Git found changes to the same lines and can't decide which version wins. You must choose.

**Fix:**

1. Open the file, find the conflict markers:

   ```text
   <<<<<<< HEAD
   your version
   =======
   their version
   >>>>>>> branch
   ```

2. Edit to keep what you want (remove markers)
3. `git add <file>`
4. `git rebase --continue` or `git commit`

---

### "fatal: 'origin' does not appear to be a git repository"

**Translation:** Git doesn't know where "origin" points. Either the remote was never set up, or the URL is wrong.

**Fix:**

```bash
git remote -v                # What remotes exist?
git remote add origin <url>  # Add if missing
git remote set-url origin <url>  # Fix if wrong
```

---

### "HEAD detached at..."

**Translation:** You're not on a branch. You checked out a specific commit, tag, or remote ref directly. Commits you make here will be orphaned when you leave.

**Fix:**

```bash
git checkout -b new-branch   # Create branch from here
# or
git checkout main            # Go back to a branch
```

---

## The Cryptic Ones

### "fatal: bad object HEAD"

**Translation:** Repository corruption. The HEAD reference points to something that doesn't exist.

**Fix:**

```bash
# Try to recover
git fsck --full
# If that fails, re-clone:
cd ..
git clone <url> fresh-copy
```

---

### "error: cannot lock ref"

**Git says:**

```text
error: cannot lock ref 'refs/heads/main': Unable to create '.git/refs/heads/main.lock': File exists.
```

**Translation:** A previous git operation crashed and left a lock file behind.

**Fix:**

```bash
rm .git/refs/heads/main.lock    # Remove the stale lock
# or find all locks:
find .git -name "*.lock" -delete
```

---

### "fatal: packed object [hash] (stored in .git/objects/pack/...) is corrupt"

**Translation:** A packfile is damaged. This can happen from disk issues, interrupted operations, or cosmic rays.

**Fix:**

```bash
# Try repair
git fsck --full
git gc --prune=now

# If that fails, you may need to re-clone
# But first, save any unpushed commits:
git format-patch origin/main --stdout > my-changes.patch
```

---

### "error: RPC failed; curl transfer closed with outstanding read data remaining"

**Translation:** Network hiccup during a large transfer. The connection dropped before git finished.

**Fix:**

```bash
# Increase buffer size
git config --global http.postBuffer 524288000

# Or clone with depth first, then fetch the rest
git clone --depth 1 <url>
git fetch --unshallow
```

---

## The Rebase Gauntlet

### "interactive rebase already started"

**Translation:** You're in the middle of a rebase and tried to start another.

**Fix:**

```bash
git rebase --continue        # If you've resolved conflicts
git rebase --abort           # If you want to give up
```

---

### "Could not apply [hash]..."

**Translation:** During rebase, this commit couldn't be replayed cleanly. Conflicts exist.

**Fix:**

1. `git status` to see conflicted files
2. Resolve conflicts
3. `git add <files>`
4. `git rebase --continue`

---

### "No rebase in progress?"

**Translation:** You ran `git rebase --continue` but git doesn't think a rebase is happening.

**Likely cause:** The rebase finished or was aborted already.

**Check:** `git status` to see current state.

---

## The Push/Pull Confusion

### "Already up to date."

**On pull:** Your branch already has all commits from the remote. Nothing to fetch.

**On merge:** The branch you're merging is already fully contained in your current branch.

**Not a problem.** Just means there's nothing new.

---

### "fatal: The current branch has no upstream branch"

**Translation:** This branch exists locally but isn't linked to a remote branch.

**Fix:**

```bash
git push -u origin <branch>   # Push and set upstream
```

---

### "Your branch is ahead of 'origin/main' by N commits"

**Translation:** You have commits locally that haven't been pushed yet.

**Fix:** `git push` when ready.

---

### "Your branch is behind 'origin/main' by N commits"

**Translation:** The remote has commits you don't have locally.

**Fix:** `git pull` or `git fetch && git rebase origin/main`

---

### "Your branch and 'origin/main' have diverged"

**Translation:** Both you and the remote have commits the other doesn't. You'll need to merge or rebase.

**Fix:**

```bash
git fetch origin
git rebase origin/main       # Preferred: replay your commits on top
# or
git merge origin/main        # Creates merge commit
```

---

## Famous Last Words

*Errors that follow these phrases:*

| Phrase | What follows |
|--------|--------------|
| "I'll just force push real quick" | Rebase Kraken awakens |
| "I don't need to pull first" | Non-fast-forward rejection |
| "What does detached HEAD mean?" | Orphaned commits |
| "I'll clean up the commits later" | They never do |
| "It works on my machine" | Untracked file phantom |

---

## The Universal Recovery Mantra

When lost:

```bash
git status                   # Where am I?
git reflog                   # Where have I been?
git log --oneline -10        # What's the recent history?
git stash list               # Did I stash something?
```

*The reflog remembers what you wish to forget.*
