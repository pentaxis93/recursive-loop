---
description: Comprehensive vault library health check with prioritized action list
---

Execute the maintain skill workflow.

**Scope options:** `full` (default), `links`, `orphans`, `stale`, `structure`, `frontmatter`

This skill performs library health assessment:

1. Scan for dead links, orphans, broken embeds
2. Validate frontmatter across note types
3. Detect duplicates and stale content
4. Assess MOC coverage and tag consistency
5. Generate prioritized findings (mechanical vs judgment-needed)

**Iron Gate (mechanical):** Facts that can be auto-fixed with approval
**Silver Gate (judgment):** Items requiring human decision

Do NOT use WebSearch. Scan vault files only.
