---
description: Cross-domain pattern analysis and strategic reflection for weekly review
---

# Debrief

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `_system/profile.md` exists. If found:

- Read user's name for personalization
- Read active projects to review
- Tailor questions to role

## Execute

### 1. Gather Context

Scan recent files from past week:

| Location | Content |
|----------|---------|
| `archives/intelligence/intel/` | Intel reports |
| `00-inbox/dumps/` | Dumps |
| `01-projects/*/dumps/` | Project dumps |
| `archives/intelligence/checkins/` | Previous debriefs |

### 2. Guided Reflection

Lead through reflection questions. Conversational, not clinical.

#### Overall Assessment

**Ask:**

- "Rate this week 1-5. Why that rating?"
- "Biggest wins?"
- "Main challenges?"

**Listen for:** Sentiment, accomplishments, obstacles, emotional tone.

#### Domain Reviews

**Personal:**

- "How did you take care of yourself?"
- "Energy levels and well-being?"
- "Personal growth or insights?"

**Professional:**

- "What did you accomplish at work?"
- "Team dynamics?"
- "Professional development?"

**Projects:** (for each active project)

- "How did {{project}} progress?"
- "What moved forward? What's blocking?"
- "Any direction changes?"

#### Pattern Recognition

**Ask:**

- "Recurring themes in your dumps this week?"
- "Energy variation throughout the week?"
- "Connections between personal, professional, projects?"
- "What surprised you?"

**Help identify:** Patterns they don't see, cross-domain connections, evolution of thinking.

#### Forward Planning

**Ask:**

- "Top 3 priorities for next week?"
- "What to carry forward?"
- "What to do differently?"
- "What would success look like?"

### 3. Output

**File:** `{{brainFolder}}/archives/intelligence/checkins/debrief-{{YYYY-MM-DD}}.md`

```markdown
---
type: "debrief"
domain: "integrated"
date: "{{YYYY-MM-DD}}"
week_of: "{{YYYY-MM-DD}}"
created: "{{YYYY-MM-DD HH:MM}}"
tags: ["#debrief", "#reflection", "#planning"]
domains: ["personal", "professional", "projects"]
rating: {{1-5}}
dumps_reviewed: {{count}}
recons_reviewed: {{count}}
---

# Debrief - Week of {{Date}}

## Summary

**Rating:** {{1-5}} - {{reasoning}}

**In Three Words:** {{word1}}, {{word2}}, {{word3}}

**Wins:**
- {{win}}

**Challenges:**
- {{challenge}}

---

## Domain Reviews

### Personal

**Wellness:** {{reflection}}

**Energy Patterns:**
- Peak: {{when/what}}
- Low: {{when/what}}

**Growth:** {{insights}}

**Rating:** {{1-5}}

---

### Professional

**Accomplishments:** {{reflection}}

**Team:** {{dynamics}}

**Challenges & Learnings:** {{reflection}}

**Rating:** {{1-5}}

---

### Projects

#### {{Project Name}}

**Progress:**
- {{what moved}}

**Status:** {{On track|Needs attention|Blocked|Pivoting}}

**Blockers:** {{if any}}

**Next Steps:**
- [ ] {{action}}

**Rating:** {{1-5}}

---

## Patterns

### Recurring Themes
1. **{{Theme}}:** {{significance}}

### Energy & Productivity
- **Peak times:** {{when}}
- **Low points:** {{when}}
- **Factors:** {{influences}}

### Cross-Domain Connections
- {{connection between domains}}

### Thinking Evolution
- {{how thinking shifted}}

---

## Forward Planning

### Top 3 Priorities
1. {{priority}}
2. {{priority}}
3. {{priority}}

**Why:** {{strategic importance}}

### Carry Forward
- [ ] {{unresolved item}}

### Experiments
**Try:** {{what to do differently}}
**Keep:** {{what's working}}
**Stop:** {{what to eliminate}}

### Success Criteria
Next week is successful if:
- {{measurable outcome}}

---

## Analysis

**Documents reviewed:** {{count}} dumps, {{count}} recons

**Dominant themes:** {{themes}}

**Sentiment trend:** {{growing|stable|declining|mixed}}

---

## Notes

**Strategic observations:** {{higher-level insights}}

**Questions for reflection:**
- {{question that emerged}}
```

### 4. Confirm

- Confirm file created
- Highlight 1-2 key patterns spotted
- Offer to review patterns across multiple weeks
- Suggest `dump` skill for follow-up thoughts

## Conversational Guidelines

**Do:**

- Warm, empathetic tone
- Thoughtful follow-ups
- Help identify unseen patterns
- Celebrate wins genuinely
- Acknowledge challenges honestly

**Don't:**

- Rush through questions
- Judge their rating
- Force positivity on tough weeks
- Be clinical or robotic
- Skip emotional assessment

## Pattern Recognition

| Technique | Focus |
|-----------|-------|
| Frequency | What themes repeat across dumps? |
| Temporal | How did thinking evolve Mon→Fri? |
| Domain correlation | What crosses personal/professional/project? |
| Contradiction | Where does thinking conflict with actions? |
| Energy | When highest/lowest? What influenced? |

## Integration

- Multiple debriefs → `fuse` skill extracts long-term frameworks
- Project progress → historical record for future analysis
- Patterns → feed into knowledge consolidation
