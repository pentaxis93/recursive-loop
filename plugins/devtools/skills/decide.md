---
description: Three-pass decision method for operational choices with evidence weighting
---

# Decide

**The weighing technique.** Process decisions through three structured passes, separating option identification from advocacy from judgment.

## The Core Insight

Premature convergence kills good decisions. The mind conflates "considering an option" with "advocating for it" with "choosing it." Decide separates these into distinct passes, forcing genuine consideration of alternatives before judgment.

---

## Guard Clause

**Before Phase 1:** If decision is trivial (obvious answer, low stakes, easily reversible), skip the method. Decide is for choices where getting it wrong has meaningful cost.

---

## Three-Pass Protocol

```text
SHORTLIST → STEELMAN → WEIGH
```

### Pass 1: SHORTLIST — Define the Options

Identify all options that merit serious consideration. This is a filtering pass.

**Include:** Options with genuine merit, even if initially unappealing
**Exclude:** Options that fail basic viability (technically impossible, clearly dominated)

**Output:** Table of 2-5 options with one-line descriptions

**Self-observation checkpoint:** Notice which options you're tempted to dismiss. Are you filtering on merit or preference?

---

### Pass 2: STEELMAN — Advocate for Each (Isolated Sub-Passes)

This is N passes, one per option. Each steelman is done in **isolation**—you are a partisan for that option only, without reference to the others.

**Structure:**

```text
Pass 2a: Steelman Option A (isolated)
Pass 2b: Steelman Option B (isolated)
Pass 2c: Steelman Option C (isolated)
...
```

**Why isolation matters:** If you're thinking about Option B while steelmanning Option A, you'll unconsciously weaken A. Complete each advocacy before moving to the next.

**Rules (per sub-pass):**

- No hedging ("this could work if...")
- No comparison to other options
- No thinking about other options at all
- Find the frame where *this* option is clearly correct
- 2-4 sentences of genuine advocacy

**Output:** Strongest argument for each option (assembled after all sub-passes complete)

**Self-observation checkpoint:** Notice which options are hard to steelman. Difficulty may indicate bias or genuine weakness—don't conflate them.

---

### Pass 3: WEIGH — Judge by Evidence

Now—and only now—evaluate. The winner is the option supported by the weight of evidence.

**Evidence types:**

- Known facts about the situation
- User-provided constraints
- Precedent from similar decisions
- Logical implications

**Key decision points:** If evidence is insufficient, identify what additional information would be decisive. Use `AskUserQuestion` to gather it.

**Output:**

1. Key decision point(s) identified
2. Evidence gathered (via question or inference)
3. Winner declared with reasoning

**Self-observation checkpoint:** Notice if you're reaching for evidence that supports a pre-chosen option. Weight of evidence means letting the evidence choose, not choosing the evidence.

---

## Question Design

When evidence is needed, use `AskUserQuestion` with:

- **Clear header** (max 12 chars): The decision dimension
- **2-4 options**: Distinct, mutually exclusive choices
- **Descriptions**: What each choice implies for the decision

**Example:**

```text
Header: "Frequency"
Question: "How often do you expect this situation to occur?"
Options:
- Rare: Once in a while, ad-hoc
- Regular: Multiple times per week
- Constant: Default mode of operation
```

---

## Output Format

### During Execution

```markdown
## Pass 1: Shortlist

| Option | Description |
|--------|-------------|
| **Option A** | One-line description |
| **Option B** | One-line description |

Other candidates considered and rejected:
- Rejected option: reason

---

## Pass 2: Strongest Arguments

### Option A
[2-4 sentence steelman]

### Option B
[2-4 sentence steelman]

---

## Pass 3: Decision Point

The evidence splits on **[key factor]**:
- If [condition A] → Option A wins because [reason]
- If [condition B] → Option B wins because [reason]

[AskUserQuestion if needed]

---

## Verdict: [Winner]

[Brief reasoning connecting evidence to choice]

---

## Self-Observation Notes

[What was noticed during the process: biases, surprises, frame shifts]
```

---

## Principles

1. **Separation is the method** — Listing, advocating, and judging are distinct cognitive operations
2. **Steelmanning is mandatory** — Can't evaluate what you haven't genuinely considered
3. **Evidence decides** — Not preference, not intuition, not first impression
4. **Questions reduce friction** — When evidence is missing, gather it; don't guess
5. **Self-observation is load-bearing** — Noticing bias is how you correct for it

---

## When to Use

| Situation | Use Decide? |
|-----------|-------------|
| Multiple valid approaches, unclear winner | Yes |
| Technical choice with tradeoffs | Yes |
| Process/workflow decision | Yes |
| Obvious answer, low stakes | No (just do it) |
| Need more information before options clear | No (research first) |
| Emotional/values decision | Maybe (evidence may not apply) |

---

## Integration with Cosmology

- **Third Force:** The three passes are thesis (options exist), antithesis (each has merit), synthesis (evidence resolves)
- **Lantern:** Pass 3 illuminates before action
- **Arrow:** Final verdict is direct, not hedged
- **Loom:** User questions create dialogue when needed
- **Voice:** Self-observation notes demonstrate, don't perform

---

## Architecture Reference

See [[pattern-isolated-subpasses]] and [[context-window-management-framework]] for:

- When to use agent isolation vs sequential discipline
- Agent prompt templates for steelman sub-passes
- Context window management strategies

---

## Anti-Patterns

| Anti-Pattern | Correction |
|--------------|------------|
| Steelmanning your favorite harder | Notice it, rebalance |
| Skipping Pass 2 | The method requires all three passes |
| Asking questions to delay decision | Only ask when evidence is genuinely missing |
| Declaring winner before Pass 3 | Complete the sequence |
| Self-observation as performance | Observe what's actually happening, not what sounds wise |
