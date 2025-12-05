# The Laws of Version Control

*Wisdom carved from bitter experience.*

---

## The Prime Directives

### The Law of Main

**Principle:** The trunk is sacred ground.

**Law:** Never commit directly to `main`. Never force push to `main`. What lands on `main` should be reviewed, tested, and intentional. The branch that deploys to production is not your sandbox.

**Invocation:** Before every commit, verify your branch. Before every push, verify your target.

---

### The Law of the Reflog

**Principle:** Git forgets nothing for 90 days.

**Law:** The reflog records every movement of HEAD. What seems lost is merely unreachable. Before declaring work destroyed, consult the oracle: `git reflog`.

**Corollary:** You have 90 days to discover your mistake. After that, the garbage collector claims what nothing references.

---

### The Law of Atomicity

**Principle:** A commit should do one thing completely.

**Law:** Each commit is a complete thought—a single logical change that leaves the system working. If you cannot summarize it in one sentence, it should be multiple commits. If removing it breaks unrelated things, it contains too much.

**Test:** Can this commit be reverted independently? Can it be cherry-picked meaningfully?

---

## The Branching Sutras

### The Sutra of the Feature Branch

**Principle:** Isolation enables focus.

**Law:** Every task gets its own branch. Work in isolation, integrate deliberately. A branch is cheap; a tangled main is expensive.

**Lifecycle:** Create → Work → Rebase → Review → Merge → Delete. The branch that lingers becomes the branch that conflicts.

---

### The Sutra of Fresh Foundations

**Principle:** Build on current ground, not ancient history.

**Law:** Before starting work, pull main. Before opening a PR, rebase onto main. The further you drift, the harder the return. Merge conflicts compound like technical debt.

**Rhythm:** `git fetch origin && git rebase origin/main` should feel like breathing.

---

### The Sutra of the Clean Departure

**Principle:** What is merged should be deleted.

**Law:** A branch that has served its purpose and merged to main must be removed. The zombie branch creates confusion, pollutes autocompletion, and obscures active work. Delete locally, delete remotely, prune references.

---

## The Collaboration Commandments

### The First Commandment: Thou Shalt Not Rewrite Shared History

**Principle:** What has been pushed belongs to everyone.

**Law:** Once commits are pushed to a shared branch, they are immutable. Rebase locally, merge publicly. If you must fix a public commit, use `revert` to create a new commit that undoes it—never `reset` or `rebase` what others have pulled.

**Consequence of violation:** The Rebase Kraken awakens. Force pushes cascade. Collaborators curse your name.

---

### The Second Commandment: Communicate Before Force

**Principle:** Power requires consent.

**Law:** If you must force push (and you probably shouldn't), warn your collaborators first. Use `--force-with-lease` as a minimal safeguard—it fails if someone else has pushed. But even then, coordinate. Surprises in shared repos destroy trust.

---

### The Third Commandment: Pull Before Push

**Principle:** Listen before speaking.

**Law:** Before pushing, fetch the remote state. Integrate others' work before demanding they integrate yours. The non-fast-forward rejection is not an obstacle to overcome with force—it is git telling you that you missed something.

---

## The Recovery Proverbs

- *"The reflog remembers what you wish to forget."*
- *"A commit is never truly lost—only unreachable."*
- *"When in doubt, `git status` out."*
- *"Reset soft to keep, reset hard to weep."*
- *"He who commits on main shall rebase in production."*
- *"The stash giveth, and the stash taketh away—if you remember it exists."*
- *"Force push to main once, shame on you. Force push to main twice, revoke your access."*
- *"There is no undo, only redo differently."*

---

## The Five Stages of Git Grief

1. **Denial:** "My commits can't be gone. I definitely pushed them."

2. **Anger:** "Why doesn't git just work like a normal system?!"

3. **Bargaining:** "If I can just get this back, I'll never force push again."

4. **Depression:** "I'm going to have to rewrite everything from scratch."

5. **Acceptance:** `git reflog` → find commit → `git cherry-pick` → peace.

*Most git disasters end at Stage 5 within minutes. The reflog is the exit from the grief cycle.*

---

## The Hierarchy of Git Sins

**Venial sins (easily forgiven):**

- Forgetting to pull before starting work
- Poor commit messages
- Committing to the wrong branch (before pushing)
- Forgetting to add files

**Mortal sins (require penance):**

- Force pushing to shared branches
- Committing secrets to the repo
- Deleting branches with unmerged work
- Rebasing public history

**Unforgivable sins:**

- `git push --force origin main` in production
- `rm -rf .git` to "fix" a problem
- Committing node_modules

---

## Closing Meditation

```text
The branch is temporary.
The commit endures—at the scale of 90 days.
The reflog remembers—at the scale of 90 days.
Nothing is truly lost until gc runs.

Commit early.
Commit often.
Push when ready.
Rebase before merge.
Delete when done.

This is the way.
```
