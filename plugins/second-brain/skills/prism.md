---
description: Split complex captures into spectrum of perspectives via multi-lens analysis
---

# Prism

**The decomposition technique.** Process rich captures through multiple analytical lenses, extracting maximum value by refusing single-pass compression.

---

## Alchemical Gate

**Classification:** `prism` is an alchemical skill.

**Requirement:** Opus-class servitor required.

```text
if model != opus:
    return 403 Forbidden: "Alchemy requires Opus servitor"
```

---

## The Core Insight

Complex captures contain multiple signal types: actions, decisions, patterns, emotions, strategies. Single-pass processing forces premature closure—choosing one perspective loses the others.

Prism splits the beam. Each lens reveals what others miss.

---

## Guard Clause

**Before Phase 1:** If capture is simple (< 10 lines, single clear intent), use direct processing. Prism is for rich material only.

---

## Three-Phase Protocol

```text
RECON → EXTRACT → INTEGRATE
```

### Phase 1: RECON — Survey the Terrain

**User must touch the capture first.**

1. **Present the content:**
   - Short (<500 chars): Show full text
   - Long: Show first ~300 chars + "... (X more lines)"

2. **Then ask** via `AskUserQuestion`:
   - "Which lenses?" with recommended options based on content type
   - Include "Let me see more" option for long captures

**Principle:** [[User-Touch-Requirement]] - User cannot select lenses for material they haven't seen.

After user sees content, observe:

- What content types are present?
- What domains does it span?
- What's the complexity level?

**Output:** Lens selection with user confirmation.

---

### Phase 2: EXTRACT — One Pass Per Lens

Process sequentially through selected lenses. Each lens asks different questions, produces different outputs.

**Order:** Concrete → Abstract, Near-term → Long-term

---

### Phase 3: INTEGRATE — Synthesize and Route

- Cross-link all outputs
- Identify emergent patterns
- Route to destinations
- Archive processed capture to `vault/archives/sources/`

---

## The 10 Lenses

| # | Lens | Domain | Extracts | Routes To |
|---|------|--------|----------|-----------|
| 1 | **Actionable** | GTD | Tasks, next actions, commitments | Project/Area notes |
| 2 | **Timeline** | Temporal | Urgency, deadlines, sequences | Task metadata |
| 3 | **Relationship** | People | Commitments to/from others, follow-ups | Relationship notes |
| 4 | **Decision** | Choice | Decisions made, options, rationale | Reference notes |
| 5 | **Content** | Creative | Themes, ideas, narratives | Fleeting notes |
| 6 | **Learning** | Growth | Insights, questions, knowledge gaps | Permanent notes |
| 7 | **Resource** | Reference | Tools, materials, citations | Resources folder |
| 8 | **Strategic** | Context | Big picture, frameworks, positioning | Reference notes |
| 9 | **Pattern** | Meta | Recurring themes, habits, tendencies | Knowledge/patterns |
| 10 | **Emotional** | Self | Energy, motivation, concerns | Self area |

---

## Lens Selection

### By Complexity

| Level | Lines | Lenses |
|-------|-------|--------|
| Simple | < 10 | Skip prism, direct process |
| Medium | 10-50 | 2-3 lenses |
| Complex | 50+ | 3-5 lenses |

### By Capture Type

| Type | Recommended Lenses |
|------|-------------------|
| Strategic planning | Strategic + Decision + Timeline + Actionable |
| Meeting notes | Relationship + Actionable + Decision |
| Research session | Learning + Content + Resource |
| Creative brainstorm | Content + Pattern + Actionable |
| Personal reflection | Emotional + Pattern + Learning |
| Voice transcription | Full recon, user choice |

### Processing Order

When multiple lenses selected, process in this sequence:

```text
1. Actionable   (days)
2. Timeline     (days-weeks)
3. Relationship (days-weeks)
4. Decision     (weeks)
5. Content      (weeks-months)
6. Learning     (weeks-months)
7. Resource     (months)
8. Strategic    (months-years)
9. Pattern      (ongoing)
10. Emotional   (ongoing)
```

---

## Lens Protocols

### 1. Actionable Lens

**Questions:**

- What needs to be done?
- What's the desired outcome?
- What's the next physical action?

**Extract:** Tasks with context tags, time estimates, priority

**Format:**

```markdown
- [ ] {{action}} @{{context}} ~{{time}} {{priority}}
```

---

### 2. Timeline Lens

**Questions:**

- What's urgent?
- What are the deadlines?
- What's time-sensitive?

**Extract:** Due dates (📅), priority flags (⏫), scheduling dependencies

---

### 3. Relationship Lens

**Questions:**

- Who is mentioned?
- What commitments were made?
- What needs follow-up?

**Extract:** People-linked tasks, waiting-on items, relationship notes

**Route:** `02-areas/relationships/{{person}}.md`

---

### 4. Decision Lens

**Questions:**

- What was decided?
- What were the options?
- What was the reasoning?

**Extract:** Decision records with context, tradeoffs, rationale

**Format:**

```markdown
## Decision: {{title}}
**Decided:** {{choice}}
**Options:** {{alternatives}}
**Rationale:** {{reasoning}}
**Review:** {{trigger}}
```

---

### 5. Content Lens

**Questions:**

- What themes emerge?
- What ideas are worth developing?
- What could become content?

**Extract:** Content ideas, themes, narrative structures

**Route:** Fleeting notes → develop later

---

### 6. Learning Lens

**Questions:**

- What did I learn?
- What questions emerged?
- What knowledge gaps exist?

**Extract:** Insights, research questions, learning notes

**Route:** Fleeting → Permanent notes

---

### 7. Resource Lens

**Questions:**

- What tools were mentioned?
- What resources are needed?
- What references were cited?

**Extract:** Resource notes, tool evaluations, reading lists

**Route:** `03-resources/reference-notes/`

---

### 8. Strategic Lens

**Questions:**

- What's the big picture?
- What frameworks apply?
- What context informs future decisions?

**Extract:** Strategic reference notes, framework documentation

**Format:**

```markdown
## Strategic Context: {{topic}}
**Landscape:** {{situation}}
**Frameworks:** {{models applied}}
**Positioning:** {{where to be}}
**Assumptions:** {{what's believed}}
**Implications:** {{what follows}}
```

---

### 9. Pattern Lens

**Questions:**

- What recurs?
- What themes keep appearing?
- What cross-cuts domains?

**Extract:** Pattern notes, recurring themes

**Route:** `05-knowledge/patterns/`

---

### 10. Emotional Lens

**Questions:**

- What excites?
- What drains?
- What worries?

**Extract:** Energy insights, motivation patterns

**Route:** Self area, personal development notes

---

## Integration Protocol

After all lenses complete:

1. **Cross-link** all outputs (minimum 3 links per artifact)
2. **Synthesis note** if 4+ lenses applied
3. **Update** GTD dashboard if projects changed
4. **Archive** processed capture to `vault/archives/sources/`
5. **Report** results to user

---

## Principles

1. **Rich captures need multiple passes** — Single-pass loses value
2. **Order matters** — Concrete → abstract, near → far
3. **Linking multiplies value** — Outputs interconnect
4. **Not all lenses every time** — Match to complexity
5. **User intent determines selection** — Ask when unclear
6. **Automate mechanical, preserve thoughtful** — AI extracts, human judges

---

## Lens Synergies

**Pairs well:**

- Actionable + Timeline (tasks with urgency)
- Relationship + Actionable (people-linked tasks)
- Decision + Strategic (choice with context)
- Content + Pattern (ideas with themes)
- Learning + Resource (insights with materials)

**Overlaps:**

- Actionable ↔ Timeline (both temporal)
- Content ↔ Learning (both extract ideas)
- Strategic ↔ Decision (both about choices)
- Pattern ↔ Emotional (both track tendencies)

When overlap detected: use both if rich, combine if sparse.
