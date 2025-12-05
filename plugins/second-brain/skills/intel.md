---
description: External news intelligence with 7-day freshness verification
---

# Intel

**CRITICAL:** This skill performs WEB-BASED intelligence gathering using WebSearch.
Do NOT scan vault files. Use WebSearch for external news only.

Config: `.claude/brain-config.json` → `brainFolder`

## Pre-flight

Check `_system/profile.md` and `_system/interests.md` exist. If not: prompt for /setup.

Read:

- `_system/profile.md` → name, role, active projects
- `_system/interests.md` → topics, preferred sources
- `_system/watchlist.md` (optional) → companies/people to track

## Execute

### 1. Research (WebSearch Required)

**Use WebSearch tool** to find news based on user's interest profile. Focus on strategic relevance.

For each interest topic and watchlist item:
1. Construct search query with "December 2025" or current month/year
2. Execute WebSearch
3. Extract relevant results

**Verification Standards (MANDATORY):**

| Requirement | Standard |
|-------------|----------|
| Freshness | ALL news from last 7 days ONLY |
| Sources | Minimum 2 credible sources per claim |
| Cross-reference | Verify stats via WebFetch |

**Source Tiers:**

| Tier | Sources |
|------|---------|
| 1 (Highest) | Reuters, AP, Bloomberg, WSJ, NYT, official announcements |
| 2 (High) | Industry pubs, credible blogs, research reports |
| 3 (Moderate) | Verified social, company blogs, community discussions |

### 2. Analyze Relevance

**Direct Impact (High Priority):**

- News affecting user's projects or companies
- Regulatory changes in user's industry
- Competitive moves by direct competitors
- Tech developments affecting user's stack

**Strategic Impact (Medium Priority):**

- Market trends affecting target customers
- Investment patterns in industry
- Partnership opportunities or threats

**Contextual Impact (Lower Priority):**

- Broader economic trends
- Industry thought leadership
- Educational content

### 3. Identify Opportunities & Threats

**Opportunities:** Market gaps, new tools, potential partners, competitor weaknesses

**Threats:** New competitors, disruptive tech, market shifts, regulatory changes

### 4. Output

**File:** `{{brainFolder}}/Archives/Intelligence/intel/intel-{{YYYY-MM-DD}}.md`

```markdown
---
type: "intel"
domain: "shared"
date: "{{YYYY-MM-DD}}"
created: "{{YYYY-MM-DD HH:MM}}"
sources_verified: true
news_age_verified: true
confidence: "high"
tags: ["#intel", "#strategic-intelligence"]
interests: ["{{interest1}}", "{{interest2}}"]
projects_referenced: ["{{project1}}"]
items_count: {{number}}
---

# Intel - {{Date}}

## Situation
{{2-3 sentences on most important developments}}

---

## High Impact News

### {{News Item}}
**Relevance:** {{Why this matters}}

{{Detailed summary}}

**Impact Assessment:**
- **Projects Affected:** {{projects}}
- **Potential Effects:** {{implications}}
- **Action Suggested:** {{recommended response}}

**Sources:**
- {{Source}} (Tier {{1/2/3}}) - {{Date}} - {{Link}}

**Confidence:** {{High/Medium/Low}} - {{reasoning}}

---

## Strategic Developments

### {{News Item}}
**Relevance:** {{strategic importance}}

{{Summary}}

**Strategic Implications:**
- {{implication}}

**Sources:** {{with tiers and links}}

**Confidence:** {{level}} - {{reasoning}}

---

## Market Intelligence

### {{Trend}}
{{Summary with market impact}}

---

## Technology Watch

### {{Development}}
{{Summary with tech implications}}

---

## Competitive Landscape

### {{Company from watchlist}}
**Recent Activity:** {{summary}}

**Competitive Implications:** {{analysis}}

---

## Opportunities & Recommendations

### Immediate Actions
- [ ] {{action item}}

### Research Needed
- {{area requiring investigation}}

### People to Inform
- {{stakeholder}}: {{about what}}

---

## Risks & Threats

### Active Threats
- **{{Threat}}:** {{description and mitigation}}

### Emerging Risks
- {{risk to monitor}}

---

## Verification Report

### Source Analysis
- **Tier 1 Sources:** {{count}}
- **Tier 2 Sources:** {{count}}
- **Cross-References:** {{count}}

### Freshness Verification
- All news verified within 7-day window
- Date range: {{oldest}} to {{newest}}

### Confidence Assessment
- **Overall:** {{percentage}}%
- **High Confidence Items:** {{count}}
- **Medium Confidence Items:** {{count}}
- **Low Confidence Items:** {{count}}

---

## Complete Sources

### Strategic News
1. {{citation with link}}

### Market Intelligence
1. {{citation with link}}

### Technology Watch
1. {{citation with link}}

### Competitive Intelligence
1. {{citation with link}}
```

### 5. Special Cases

**No Recent News:**

```markdown
### {{Interest Area}}
**No significant news in last 7 days**

Last known: {{date}} regarding {{topic}}
Suggestion: Expand search or check {{alternatives}}
```

**Unverified Information:**

```markdown
### {{Item}}
**Unable to verify from independent sources**

**Original Source:** {{source}} - Credibility: {{tier}}
**Confirmed:** {{what we know}}
**Uncertain:** {{unverified claims}}
**Recommendation:** Monitor for confirmation

**Confidence:** Low
```

**Conflicting Sources:**

```markdown
### {{Item}}
**Conflicting information**

**Perspective 1:** {{summary}} - Source: {{tier}}
**Perspective 2:** {{summary}} - Source: {{tier}}

**Agreement:** {{common ground}}
**Disagreement:** {{conflicts}}
**Recommendation:** {{resolution approach}}

**Confidence:** Medium
```

### 6. Follow-up

Suggest:

- **dump skill** - Capture thoughts sparked by news
- Project-specific analysis if news impacts active projects
