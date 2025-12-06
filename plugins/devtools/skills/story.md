---
description: Craft atomic, meaningful commits from uncommitted changes
---

# Story

Analyze uncommitted changes and create atomic, meaningful commits.

> Each commit should tell a single story, complete and self-contained.

---

## Trigger

`/devtools:story` or "commit", "write commits", "craft commits"

---

## Workflow

1. **Discover** - `git status`, `git diff` to see all uncommitted changes
2. **Understand** - Analyze what was accomplished
3. **Group** - Identify related changes that tell one coherent story
4. **Plan** - Design atomic commits, present to user for approval
5. **Execute** - Create commits with clear, intentional messages

---

## Core Principles

### The Complete Feature Rule

A commit is complete only when it includes ALL of:

- Implementation (code, configs, scripts)
- Documentation (CLAUDE.md, README, inline docs)
- Tests (if applicable)

**NEVER separate:**

- ❌ "Add feature" → "Document feature"
- ❌ "Implement X" → "Update docs for X"

Documentation synchronization is not optional.

### What is "One Story"?

One user-facing capability or one conceptual change:

✅ **Good boundaries:**

- One feature with all its parts
- One bug fix (cause + fix + docs)
- One refactoring (change + updated docs)
- One configuration enhancement

❌ **Bad boundaries:**

- Mixing unrelated features
- Implementation without documentation
- Multiple unrelated changes

### Commit Philosophy

- **Atomic** - Complete, self-contained, leaves system working
- **Semantic** - Use prefixes: feat, fix, refactor, docs, style, test, chore
- **Intent over implementation** - Messages explain *why*, not just *what*
- **Logical progression** - Commits build on each other sensibly

---

## Message Format

```text
<type>(<scope>): <summary>

<body - the why, not the what>

<footer - breaking changes, issue refs>
```

**Types:** feat, fix, refactor, docs, style, test, chore, perf

---

## Decision Framework

When uncertain whether to split or combine:

1. **Can each commit stand alone?** If removing one breaks the other → combine
2. **Same user-facing purpose?** Same feature → same commit
3. **Would docs explain them separately?** Separate topics → separate commits
4. **Does code change affect documented behavior?** Docs MUST be in same commit

---

## The Anti-Pattern

**NEVER:**
```bash
git commit -m "feat(x): add feature"
git commit -m "docs: update for feature"  # WRONG
```

**ALWAYS:**
```bash
git commit -m "feat(x): add feature

Includes documentation updates."
```

`docs:` prefix only for:
- Pure doc improvements (typos, clarity)
- Doc infrastructure changes
- Docs unrelated to code changes

---

## Execution

Use `git add -p` for splitting changes within files.

After each commit, system should remain working.

Present commit plan to user before executing. User approves or modifies.

---

*A feature isn't done until it's documented. The git history tells a complete story.*
