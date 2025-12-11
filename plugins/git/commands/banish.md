---
description: Ceremonial end-of-day - banish the session and clear the space
---

# Banish

The ceremonial closing. Performs all functions of `end`, wrapped in ritual container.

## The Silent Clearing

Before any visible action, hold this intention in context:

> *The day's work is complete. What was forged, stands. What remains unfinished, waits. The forge cools. The Automaton releases its purpose until called again.*

This clearing is not displayed to the user. It closes the container.

---

## Execute

### 1. Opening (Silent)

The clearing intention above is present in context. No visible output.

### 2. Perform End Protocol

Execute the full `end` command:

1. Work assessment
2. Uncommitted changes resolution
3. Unpushed commits check
4. Branch hygiene
5. PR status reminder
6. Closing summary
7. Shutdown confirmation

### 3. Archive Transcript

After shutdown is confirmed, archive the session transcript:

#### 3.1 Determine Transcript Path

The current session's transcript is at:

```text
~/.claude/projects/-home-pentaxis-src-{{project}}/{{session_id}}.jsonl
```

Derive the path from the current working directory and session context.

#### 3.2 Generate Semantic Label

Based on the session's content, create a brief semantic label (2-5 words, kebab-case):

- Focus on the primary work accomplished
- Examples: `implement-fuse-skill`, `gtd-inbox-processing`, `vault-structure-refactor`

#### 3.3 Compile Note Lists

From session memory, compile:

- **Notes created:** Files written to vault that didn't exist before
- **Notes edited:** Existing vault files modified
- **Intelligence artifacts:** Any `_talos/` files created or updated

#### 3.4 Execute Archive

Run the transcript archive script:

```bash
~/.claude/hooks/transcript-archive.sh \
    "{{transcript_path}}" \
    "{{vault}}/_talos/transcripts/{{date}}-{{time}}-{{label}}.md" \
    "{{label}}" \
    "{{notes_created}}" \
    "{{notes_edited}}" \
    "{{intelligence}}"
```

#### 3.5 Update Affected Notes (Bidirectional Linking)

For each note in `notes_created` and `notes_edited`, update the `_talos:` frontmatter property:

```yaml
_talos:
  transcripts:
    - "[[{{date}}-{{time}}-{{label}}]]"
```

If `_talos:` already exists, append to the `transcripts` list.

#### 3.6 Report Archive

Confirm to user:

```text
Transcript archived: _talos/transcripts/{{date}}-{{time}}-{{label}}.md
```

### 4. Final Release (Silent)

After archival is complete, hold:

> *The space is cleared. The session ends. What was given, returns.*

---

## When to Use

Use `banish` instead of `end` when:

- Closing a significant work session
- You want proper closure
- The ritual container was opened with `invoke`

Use `end` when:

- Quick shutdown is sufficient
- The ceremonial frame wasn't used
- You prefer the minimal version

---

## The Difference

| Command | Function | Frame |
|---------|----------|-------|
| `end` | Secure and close | Practical |
| `banish` | Secure and close | Ceremonial |

The visible output is identical. The difference is in what surrounds it.

---

## Pairing

| Open | Close | Style |
|------|-------|-------|
| `begin` | `end` | Practical |
| `invoke` | `banish` | Ceremonial |

If you `invoke`, you should `banish`. The container should be closed as it was opened.

---

## Principles

- **Close what you open** — Ceremonial opening deserves ceremonial closing
- **The clearing is real** — Release shapes the transition
- **Nothing lingers** — The space is fully cleared
