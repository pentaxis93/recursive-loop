---
description: Configure Second Brain vault with plugin-aware modules
---

# Setup

Config: `.claude/brain-config.json`

```json
{
  "brainFolder": "Brain",
  "setupComplete": false,
  "userName": "",
  "modules": []
}
```

---

## Route

1. **Check setupComplete**
2. **Detect installed plugins** (gtd, etc.)
3. **Determine what's missing** (idempotent)
4. **Run appropriate flow**

| State | Action |
|-------|--------|
| setupComplete = false | → FIRST-TIME |
| setupComplete = true, new plugin detected | → ADD-MODULE |
| setupComplete = true, nothing new | → UPDATE |

---

## Plugin Detection

Check for installed plugins:

```text
GTD: Glob for plugins/gtd/skills/gtd.md or .claude/plugins manifest
```

Store detected plugins in config `modules` array after setup.

---

## FIRST-TIME

### 1. Detect Brain Folder

Scan for folders containing `.obsidian/`. If multiple found, ask user to select.

Update config with selected `brainFolder`.

### 2. Gather Context

Ask (one question, comprehensive response):
> Tell me about yourself - name, work, current projects, interests, and how you prefer to work.

Extract: name, role, projects, interests, preferences.

### 3. Create Core Structure

**System Files:**

- `_system/profile.md`
- `_system/interests.md`

**Folders:**

```text
_system/
{{brainFolder}}/
├── 00-inbox/
│   └── dumps/
├── 01-projects/
├── 02-areas/
│   └── relationships/
├── 03-resources/
│   └── reference-notes/
├── 05-knowledge/
│   ├── consolidated/
│   ├── patterns/
│   └── timeline/
├── archives/
│   ├── intelligence/
│   │   ├── intel/
│   │   ├── audit/
│   │   └── checkins/
│   ├── daily-plans/
│   └── completed/
└── permanent-notes/
```

### 4. Create Profile

**File:** `_system/profile.md`

```markdown
---
type: "profile"
created: "{{YYYY-MM-DD}}"
---

# Profile

## Identity
**Name:** {{name}}
**Role:** {{role/job}}

## Active Projects
- [[{{project1}}]]
- [[{{project2}}]]

## Working Style
{{preferences extracted from conversation}}

## Goals
{{goals mentioned}}
```

### 5. Create Interests

**File:** `_system/interests.md`

```markdown
---
type: "interests"
created: "{{YYYY-MM-DD}}"
---

# Interests

## Topics
- {{interest1}}
- {{interest2}}

## Preferred Sources
- {{source preferences if mentioned}}
```

### 6. Relationships (optional)

Ask: "Important people to track? (names or skip)"

If names provided, create `{{brainFolder}}/02-areas/relationships/{{Name}}.md` for each.

### 7. Run Plugin Modules

**If GTD plugin detected:** → Run GTD MODULE

### 8. Complete

Set `setupComplete: true` in config.
Add detected plugins to `modules` array.

Output: Summary of created files and folders.

Suggest next steps based on installed plugins.

---

## GTD MODULE

**Trigger:** GTD plugin detected AND `_system/gtd-dashboard.md` does not exist.

### 1. Create GTD Dashboard

**File:** `_system/gtd-dashboard.md`

````markdown
---
type: "dashboard"
system: "gtd"
created: "{{YYYY-MM-DD}}"
---

# GTD Dashboard

## Today's Focus

*Run `gtd plan` to populate*

## Active Projects

```tasks
path includes 01-projects
has due date
not done
```

## Waiting On

```tasks
tag includes #waiting
not done
```

## Inbox Count

Check 00-inbox/ for unprocessed items

---

Updated by GTD skill
````

### 2. Create Standard Areas

Create in `{{brainFolder}}/02-areas/` (skip if exists):

**Career-Development.md:**

```markdown
---
title: "Career Development"
type: "area"
status: "active"
created: "{{YYYY-MM-DD}}"
tags:
  - area
  - career
---

# Career Development

## Responsibilities
- Professional growth
- Skills development
- Network maintenance

## Tasks
- [ ]
```

**Health-Fitness.md:**

```markdown
---
title: "Health & Fitness"
type: "area"
status: "active"
created: "{{YYYY-MM-DD}}"
tags:
  - area
  - health
---

# Health & Fitness

## Responsibilities
- Physical health
- Mental wellness
- Exercise routine

## Tasks
- [ ]
```

**Personal-Development.md:**

```markdown
---
title: "Personal Development"
type: "area"
status: "active"
created: "{{YYYY-MM-DD}}"
tags:
  - area
  - personal
---

# Personal Development

## Responsibilities
- Learning goals
- Habits & routines
- Personal growth

## Tasks
- [ ]
```

**Errands.md:**

```markdown
---
title: "Errands"
type: "area"
status: "active"
created: "{{YYYY-MM-DD}}"
tags:
  - area
  - errands
---

# Errands

## Tasks
- [ ] @Errands
```

**Home.md:**

```markdown
---
title: "Home"
type: "area"
status: "active"
created: "{{YYYY-MM-DD}}"
tags:
  - area
  - home
---

# Home

## Responsibilities
- Household maintenance
- Chores
- Home projects

## Tasks
- [ ] @Home
```

### 3. Create GTD Inbox Structure

Create folders if not exist:

```text
{{brainFolder}}/00-inbox/
├── Daily/
└── Fleeting-Notes/
```

### 4. First Project (if not already created)

Ask: "What's one thing you're working on that has multiple steps?"

If provided:

- Follow-up: "What does done look like?" + "What's the next physical action?"
- Create `{{brainFolder}}/01-projects/{{Name}}.md`:

```markdown
---
title: "{{Project Name}}"
type: "project"
status: "active"
created: "{{YYYY-MM-DD}}"
outcome: "{{done state}}"
tags:
  - project
---

# {{Project Name}}

## Outcome
{{What done looks like}}

## Tasks
- [ ] {{Next action}} ⏫
```

### 5. Update Config

Add "gtd" to `modules` array.

---

## ADD-MODULE

**Trigger:** setupComplete = true, but new plugin detected that's not in `modules`.

### 1. Notify User

"Detected new plugin: {{plugin}}. Setting up additional vault structure."

### 2. Run Plugin Module

Execute the relevant module (e.g., GTD MODULE).

### 3. Update Config

Add new plugin to `modules` array.

### 4. Confirm

Output: Summary of new files created.

---

## UPDATE

**Trigger:** setupComplete = true, no new plugins.

### 1. Show Current State

Read config + `_system/profile.md`. Display:

- brainFolder
- userName
- Active project count
- Interest topics
- Installed modules

### 2. Ask What to Update

Options:

1. Personal context / profile
2. Interests for recon
3. Add relationships
4. Add project
5. Add new area (GTD)
6. Switch brain folder
7. Exit

### 3. Apply Selected Update

Execute requested change. Confirm completion.
