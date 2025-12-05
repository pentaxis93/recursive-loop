# Second Brain

Knowledge capture and intelligence extraction for Obsidian-based systems.

## Installation

```text
/plugin marketplace add pentaxis93/recursive-loop
/plugin install second-brain@pentaxis93
```

## Architecture

**Hook:** Injects vault operation rules at session start (PARA + Zettelkasten methodology, linking rules, frontmatter conventions).

**Skills:** Action workflows for knowledge lifecycle.

```text
dump → [raw capture] → refine → [atomic notes] → fuse → [frameworks]
recon → [intel report] ↗
debrief → [weekly patterns] ↗
```

## Commands

### /second-brain:setup

Configure Second Brain vault with plugin-aware modules.

**Run:** `/second-brain:setup`

1. Detect Obsidian vault (folder with `.obsidian/`)
2. Gather user context (name, role, projects, interests)
3. Create PARA folder structure and system files
4. **Detect installed plugins** (gtd, etc.) and configure accordingly
5. Optionally set up relationships and first project

**Plugin-aware:** Automatically detects gtd plugin and creates GTD-specific structure (dashboard, areas, inbox folders).

**Idempotent:** Install a new plugin later? Run `/setup` again — it detects what's missing and adds it.

**Run again to update:** profile, interests, relationships, add modules, or switch vault.

### /second-brain:dump

Capture stream-of-consciousness with domain classification.

### /second-brain:recon

Intelligence gathering with 7-day freshness verification.

### /second-brain:fuse

Consolidate scattered insights into frameworks.

### /second-brain:refine

Process raw captures into atomic permanent notes with links.

### /second-brain:debrief

Weekly cross-domain pattern recognition and reflection.

## Skills

### dump

Capture stream-of-consciousness with domain classification and insight extraction.

**Invoke:** "dump", "what's on your mind"

1. Collect raw thoughts (any format)
2. Classify domain (personal/professional/project/mixed)
3. Extract themes, questions, decisions, actions, insights
4. Output structured file to inbox

**Requires:** `.claude/brain-config.json` with `brainFolder` path.

### recon

Reconnaissance - extract verified intel from noise.

**Invoke:** "recon", "news", "what's happening", "intel"

1. Read user profile and interests from `_system/` files
2. Research with 7-day freshness requirement
3. Verify sources (Tier 1-3 credibility)
4. Analyze strategic relevance
5. Identify opportunities and threats
6. Output structured report with verification

**Requires:** `_system/profile.md`, `_system/interests.md` (optional: `_system/watchlist.md`)

### fuse

Fuse scattered insights into frameworks through pattern synthesis.

**Invoke:** "fuse", "consolidate", "build frameworks", "synthesize"

1. Gather unprocessed dumps and recon reports
2. Detect patterns (frequency, temporal, domain, contradiction)
3. Synthesize frameworks with principles and applications
4. Output to `05-knowledge/` (frameworks, patterns, timelines)
5. Delete processed dumps (GTD canon)
6. Route tasks to Zettelkasten/projects
7. Integrate links and update MOC

**Requires:** `_system/profile.md`, processed dumps in `00-inbox/dumps/` or `01-projects/*/dumps/`

### refine

Process raw captures into atomic permanent notes with proper linking.

**Invoke:** "refine", "process notes", "extract insights", "create permanent notes"

1. Gather unprocessed content from inbox
2. Extract atomic ideas (one idea = one note)
3. Check for duplicates before creating
4. Create permanent notes in own words (100-300 words)
5. Add 3+ links with relationship explanations
6. Create reference notes for rich sources
7. Archive or delete processed sources

**Requires:** Raw content in `00-inbox/` or `00-inbox/dumps/`

### debrief

Cross-domain pattern analysis and strategic reflection for weekly review.

**Invoke:** "debrief", "weekly review", "reflect on my week"

1. Gather context (dumps, recons, previous debriefs)
2. Guided reflection across domains (personal, professional, projects)
3. Pattern recognition (themes, energy, cross-domain connections)
4. Forward planning (priorities, experiments, success criteria)
5. Output structured check-in document

**Requires:** `_system/profile.md` (optional but enhances personalization)

## Managing Changes

- **Disable:** `/plugin disable second-brain`
- **Uninstall:** `/plugin uninstall second-brain`
- **Update:** `/plugin update second-brain`
