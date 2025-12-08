# Goal Taxonomy

MECE categorization of plugins by goal function.

---

## The Five Quests

Each plugin serves one primary goal. These are the treasures collected on the journey.

| Goal | What It Delivers | Plugins |
|------|------------------|---------|
| **Flow** | Session continuity, context preservation | devtools (park, story, plot, status), chronicle*, unpark* |
| **Memory** | Knowledge persistence and synthesis | second-brain (dump, refine, fuse, intel, audit, debrief) |
| **Action** | Task clarity and execution | gtd (capture, process, plan) |
| **Cognition** | Thinking augmentation | construct (prism, observe-self) |
| **Presence** | System behavior and intention | talos, prayer-wheel |

*User-defined skills, not yet in marketplace

---

## Goal Definitions

### Flow (DX)

**Question:** How do I maintain momentum across interruptions?

Tools that preserve work state, manage context, and enable seamless resumption. The developer experience layer.

**Value:** Never lose context. Resume instantly. Ship continuously.

### Memory (KM)

**Question:** How does knowledge persist and grow?

Tools that capture, process, connect, and synthesize knowledge. The Zettelkasten engine.

**Value:** Every insight compounds. Nothing valuable is forgotten.

### Action (GTD)

**Question:** What should I do right now?

Tools that clarify, organize, and prioritize work. The Getting Things Done implementation.

**Value:** Clear next actions. No open loops. Trusted system.

### Cognition (CX)

**Question:** How can I think more deeply?

Tools that augment analysis, provide multiple perspectives, and extract patterns. Downloadable cognitive programs.

**Value:** See what you'd miss alone. Think beyond your defaults.

### Presence (Meta)

**Question:** How should the AI behave?

Tools that shape identity, communication style, and intention. The operating system layer.

**Value:** Precise execution. Functional honesty. Aligned collaboration.

---

## MECE Verification

**Mutually Exclusive:** Each goal addresses a distinct concern. A plugin's primary function maps to exactly one goal.

**Collectively Exhaustive:** Any new plugin capability will fit one of these categories:

- Helps with session/work state → Flow
- Helps knowledge persist/grow → Memory
- Helps prioritize/execute tasks → Action
- Helps think deeper/different → Cognition
- Shapes AI behavior/intention → Presence

---

## Plugin Mapping

### Flow (DX)

| Plugin | Skill | Function |
|--------|-------|----------|
| devtools | park | Preserve context for blocked work |
| devtools | story | Atomic commits from changes |
| devtools | plot | PRs from commit stories |
| devtools | status | Repository state overview |
| (user) | chronicle | Session knowledge capture |
| (user) | unpark | Resume with validation |

### Memory (KM)

| Plugin | Skill | Function |
|--------|-------|----------|
| second-brain | dump | Raw thought capture |
| second-brain | refine | Process to permanent notes |
| second-brain | fuse | Synthesize frameworks |
| second-brain | intel | External intelligence |
| second-brain | audit | Vault health check |
| second-brain | debrief | Weekly pattern review |

### Action (GTD)

| Plugin | Skill | Function |
|--------|-------|----------|
| gtd | capture | Quick inbox capture |
| gtd | process | Clarify and route |
| gtd | plan | Time-aware engagement |

### Cognition (CX)

| Plugin | Skill | Function |
|--------|-------|----------|
| construct | prism | 10-lens analysis |
| construct | observe-self | Skill extraction |

### Presence (Meta)

| Plugin | Skill | Function |
|--------|-------|----------|
| talos | (core) | Behavioral framework |
| prayer-wheel | (core) | Intention ritual |

---

## Evolution Notes

New plugins should declare their primary goal in frontmatter:

```yaml
---
goal: flow  # one of: flow, memory, action, cognition, presence
---
```

This enables automated categorization and goal-based discovery.
