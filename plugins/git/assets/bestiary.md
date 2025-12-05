# The Bestiary of Git

*A field guide to the creatures that dwell in your repository.*

---

## The Detached HEAD

**Habitat:** Appears when you checkout a commit directly, a tag, or find yourself "not on any branch."

**Appearance:** A floating specter, untethered from the branch lineage. Your commits drift into the void unless anchored.

**Warning signs:**

```text
You are in 'detached HEAD' state...
```

**Behavior:** Any commits you make will be orphaned when you switch branches. They exist, but nothing points to them.

**Taming:** Before leaving, create a branch to anchor your work:

```bash
git checkout -b rescue-branch
```

**If you've already left:** The reflog remembers. `git reflog` → find your commit → `git branch rescue-branch <hash>`

---

## The Merge Conflict Hydra

**Habitat:** Emerges during merge, rebase, or cherry-pick when the same lines were modified differently.

**Appearance:** Multi-headed beast. Cut one head (resolve one conflict), and sometimes two more appear in dependent files.

**Warning signs:**

```text
CONFLICT (content): Merge conflict in <file>
Automatic merge failed; fix conflicts and then commit the result.
```

**Behavior:** Blocks all progress until every head is severed. Grows stronger with divergent branches.

**Taming:**

1. Face each head individually (`git status` to list them)
2. Edit files, remove conflict markers
3. `git add` each resolved file
4. `git rebase --continue` or `git merge --continue`

**Prevention:** Rebase frequently. Small branches. The Hydra feeds on divergence.

---

## The Orphaned Commit

**Habitat:** The reflog. Unreachable from any branch or tag.

**Appearance:** A ghost commit—exists in the object database but has no living reference pointing to it.

**How they're born:**

- Amending a commit (old version becomes orphan)
- Rebasing (original commits become orphans)
- Resetting with `--hard`
- Deleting a branch with unmerged commits

**Lifespan:** ~90 days before git's garbage collector claims them.

**Resurrection:**

```bash
git reflog                    # Find the ghost
git cherry-pick <hash>        # Resurrect it
# or
git branch zombie <hash>      # Give it a home
```

---

## The Rebase Kraken

**Habitat:** Deep in the commit history. Awakens when you invoke `git rebase -i` on shared branches.

**Appearance:** Massive tentacles reaching through time, rewriting commits that others have built upon.

**Warning signs:** You've rebased commits that were already pushed. Others have pulled them. Now history has forked.

**The Horror:**

```text
! [rejected]        main -> main (non-fast-forward)
hint: Updates were rejected because the tip of your current branch is behind
```

**Summoning (don't):**

```bash
git push --force  # Unleashes the Kraken on your collaborators
```

**Appeasement:** If you must force push, use `--force-with-lease`—it at least checks if anyone else has pushed.

**Prevention:** Never rebase commits that have left your machine. The Kraken sleeps in shared history.

---

## The Stale Branch Zombie

**Habitat:** Your local repository, long after its purpose has been served.

**Appearance:** Merged branches that were never deleted. They shamble on, cluttering `git branch` output, serving no purpose.

**Warning signs:**

```bash
git branch
# ...endless list of old feature branches...
```

**Behavior:** Harmless individually, but in hordes they create confusion and obscure active work.

**Extermination:**

```bash
# Find the zombies
git branch --merged main | grep -v main

# Mass grave
git branch --merged main | grep -v main | xargs git branch -d
```

---

## The Untracked Phantom

**Habitat:** Your working directory, invisible to git until summoned.

**Appearance:** Files that exist but git pretends they don't. They won't be committed, stashed, or cleaned unless explicitly addressed.

**Warning signs:**

```text
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        mysterious-file.txt
```

**Behavior:** Survives `git reset`, `git checkout`, even `git stash`. Immune to most git operations.

**Capture:** `git add <file>` to track, or add to `.gitignore` to banish permanently.

**Nuclear option:** `git clean -fd` destroys all phantoms (and any untracked files you wanted).

---

## The Empty Commit Specter

**Habitat:** Your staging area when you think you have changes but don't.

**Warning signs:**

```text
nothing to commit, working tree clean
```

...but you swear you made changes.

**Common causes:**

- Changes are in a different worktree
- Files are gitignored
- You already committed and forgot
- You're in the wrong directory

**Exorcism:** `git status`, `pwd`, check your `.gitignore`.

---

## Survival Guide

**The reflog is your salvation.** Almost nothing in git is truly lost—only unreachable. The reflog remembers every HEAD movement for ~90 days.

**When facing any creature:**

1. Don't panic
2. `git status` to assess
3. `git reflog` if something is lost
4. `git <command> --abort` if mid-operation
5. Ask for help before `--force`

*May your branches be clean and your conflicts be few.*
