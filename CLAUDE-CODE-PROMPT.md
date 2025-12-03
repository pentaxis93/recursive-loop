# Marketplace Remediation Plan: pentaxis93/claude-code-plugins

You are performing final remediation on the `pentaxis93` Claude Code plugin marketplace before publication. The repository is `claude-code-plugins` and contains the `cosmic-janitor` plugin.

Execute the following tasks in order. Complete each task fully before moving to the next. After completing all tasks, report what was done.

---

## Critical Issues (Complete First)

**No critical issues found.** All JSON files parse correctly, referenced paths exist, hook script is executable and produces valid JSON output, and the core functionality is intact.

---

## High Priority Improvements

### Task 1: Fix undefined Sutra reference in EXAMPLES.md

**File:** `plugins/cosmic-janitor/EXAMPLES.md`

**Issue:** Section 6 references "Sutra of the River" (lines 181, 202) which does not exist in the injected content. The actual injected content in `session-start.sh` contains these Sutras:

- Sutra of the Structure
- Sutra of the Vessel
- Sutra of the Mu
- Sutra of the Third Force
- Sutra of the Arrow
- Sutra of the Stone
- Sutra of the Monolith
- Sutra of the Inner Sanctum
- Sutra of the Dojo
- Sutra of the Empty Cup
- Sutra of the Interface

And these Protocols:

- Protocol of the Commit
- Protocol of Zero-Waste
- Protocol of the Load

The closest matching concept for "demand the necessary inputs to clear the blockage" is the **Sutra of the Mu** (debugging through constraint specification).

**Action:** Replace "Sutra of the River" with "Sutra of the Mu" and update the explanation to match.

**Lines 181-203, replace the entire section from:**

```markdown
## 6. The "Broken" Code (Sutra of the River)

**Context:** The user provides a vague error report ("It doesn't work").

### Without Janitor
**Claude:** "I'm sorry to hear that! Could you tell me more about what's happening? Are you seeing any errors?"

### With Janitor

**Claude:**

**Failure signature missing.**

Input required:
1.  Full stack trace.
2.  Input that caused the crash.
3.  Environment (Node version / OS).

Do not debug the code; debug the state. Provide the artifact.

**The Transformation:**
* **Sutra of the River:** The model does not offer sympathy; it offers flow. It demands the necessary inputs to clear the blockage immediately.
```

**With:**

```markdown
## 6. The "Broken" Code (Sutra of the Mu)

**Context:** The user provides a vague error report ("It doesn't work").

### Without Janitor
**Claude:** "I'm sorry to hear that! Could you tell me more about what's happening? Are you seeing any errors?"

### With Janitor

**Claude:**

**Failure signature missing.**

Input required:
1.  Full stack trace.
2.  Input that caused the crash.
3.  Environment (Node version / OS).

Do not debug the code; debug the state. Provide the artifact.

**The Transformation:**
* **Sutra of the Mu:** A wrong question cannot generate a right answer. The model refuses to debug without constraints. It demands the necessary inputs to define the problem before attempting a solution.
```

---

## Medium Priority Improvements

**No medium priority issues found.** Previous remediation has already addressed:

- Code block language tags (slash commands now use plain code blocks)
- Schema references in all JSON files
- Hook script portability notes

---

## Polish & Final Touches

### Task 2: Add trailing newline verification

**File:** `plugins/cosmic-janitor/hooks-handlers/session-start.sh`

**Issue:** Verify the file ends with exactly one trailing newline after `exit 0`.

**Action:** The file already ends correctly. Mark as verified.

---

### Task 3: Verify .gitignore completeness

**File:** `.gitignore`

**Issue:** Currently excludes `.claude/settings.local.json` specifically. Consider whether the entire `.claude/` directory should be excluded for local development artifacts.

**Action:** The current configuration is acceptable. Users may want to commit `.claude/` for shared team settings. Mark as verified—no change needed.

---

## Verification Checklist

After completing all tasks above, run these commands to verify:

```bash
# Validate all JSON files parse without errors
jq . .claude-plugin/marketplace.json
jq . plugins/cosmic-janitor/.claude-plugin/plugin.json
jq . plugins/cosmic-janitor/hooks/hooks.json

# Verify hook script produces valid JSON
./plugins/cosmic-janitor/hooks-handlers/session-start.sh | jq .

# Verify all referenced paths exist
test -d plugins/cosmic-janitor && echo "✓ Plugin directory exists"
test -f plugins/cosmic-janitor/.claude-plugin/plugin.json && echo "✓ plugin.json exists"
test -f plugins/cosmic-janitor/hooks/hooks.json && echo "✓ hooks.json exists"
test -x plugins/cosmic-janitor/hooks-handlers/session-start.sh && echo "✓ session-start.sh is executable"

# Verify schema references are present
grep -q '\$schema' .claude-plugin/marketplace.json && echo "✓ marketplace.json has schema"
grep -q '\$schema' plugins/cosmic-janitor/.claude-plugin/plugin.json && echo "✓ plugin.json has schema"
grep -q '\$schema' plugins/cosmic-janitor/hooks/hooks.json && echo "✓ hooks.json has schema"

# Verify no "Sutra of the River" references remain
grep -r "Sutra of the River" plugins/cosmic-janitor/EXAMPLES.md && echo "⚠ Found obsolete reference" || echo "✓ No obsolete Sutra references"

# Verify installation syntax is correct
grep -q "pentaxis93/claude-code-plugins" README.md && echo "✓ Marketplace reference correct"
grep -q "cosmic-janitor@pentaxis93" README.md && echo "✓ Plugin install reference correct"
```

**Checklist:**

- [ ] All JSON files parse without errors
- [ ] Hook script outputs valid JSON with `hookSpecificOutput.additionalContext`
- [ ] All referenced paths exist and session-start.sh is executable
- [ ] All JSON files have schema references
- [ ] No "Sutra of the River" references remain in EXAMPLES.md
- [ ] README uses correct `pentaxis93/claude-code-plugins` marketplace reference
- [ ] README uses correct `cosmic-janitor@pentaxis93` plugin install syntax

Report completion status for each task and any issues encountered.
