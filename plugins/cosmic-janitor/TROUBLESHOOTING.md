# Cosmic Janitor: Troubleshooting Guide

This guide helps diagnose and resolve common issues with the `cosmic-janitor` plugin.

---

## Quick Diagnostics

Run this checklist to identify your issue in under 60 seconds.

### 1. Is the plugin installed?

```bash
claude plugin list | grep cosmic-janitor
```

**Expected output**: `cosmic-janitor (enabled)`

**If missing**: See [Installation Issues](#installation-issues)
**If disabled**: Run `/plugin enable cosmic-janitor` inside Claude Code.

### 2. Is the hook firing?

Start a new session.

**Expected behavior**:
- **Zero Preamble**: No "Sure, I can help" text.
- **Atomic Blocks**: Code arrives in isolated, copy-pasteable chunks.
- **Functional Honesty**: Direct, technical language.

**If behavior is unchanged** (polite, verbose): See [Hook Issues](#hook-issues).

### 3. Is the behavior correct but "shocking"?

**Symptom**: Plugin works, but responses feel "rude," "incomplete," or "too direct."

**Status**: **Working as Designed.**
See [Behavior Shock](#behavior-shock) to understand why we do this.

---

## Decision Tree

```
Start Here
│
├─ Plugin not in list
│  └─→ [Installation Issues]
│
├─ Plugin enabled but Claude is still polite
│  └─→ [Hook Issues]
│
├─ Performance degradation
│  └─→ [Performance Issues]
│
└─ Plugin works but feels "broken" or "rude"
   └─→ [Behavior Shock]
```

---

## Installation Issues

### Issue: Plugin not appearing after marketplace install

**Symptoms:**
- Ran `/plugin install ...` successfully.
- `/plugin list` is empty or missing `cosmic-janitor`.

**Solution:**
1. **Restart Claude Code:** The plugin registry sometimes requires a fresh session.
2. **Check Global vs. Project:**
   Did you install it globally (`-g`) or for the current project?
   ```bash
   # Check global list
   claude plugin list --global
   ```
3. **Reinstall:**
   ```bash
   /plugin uninstall cosmic-janitor
   /plugin install cosmic-janitor@pentaxis93
   ```

---

## Hook Issues

### Issue: SessionStart hook not firing

**Symptoms:**
- Plugin is enabled.
- Claude is still "glazing" (being polite/verbose).

**Cause:**
The `SessionStart` hook failed to inject the system instructions, or the context window was flushed.

**Diagnostics:**
1. **Reset the session:**
   Run `/reset`. The hook only fires at the *start* of a session (or after a reset). Old sessions retain old personas.
2. **Check Hook Configuration:**
   Inspect the plugin's hook registration (path depends on your OS/install method, usually `~/.claude/plugins/...`).
   Ensure `hooks.json` contains:
   ```json
   "hooks": { "SessionStart": "..." }
   ```

### Issue: "Invalid JSON in hook output"

**Symptoms:**
- Error message on startup: `Error: Invalid JSON in hook output`.

**Cause:**
The injection payload contains unescaped characters that broke the JSON structure.

**Solution:**
1. **Update the plugin:** We may have patched a JSON escape sequence issue.
   ```bash
   /plugin update cosmic-janitor
   ```
2. **Report Bug:** If on the latest version, this is a bug in the `cosmic-janitor` parser. Open an issue on the marketplace repo.

---

## Performance Issues

### Issue: Session startup lag

**Symptoms:**
- 1-2 second delay when starting a new session or running `/reset`.

**Cause:**
**Context Injection.** The plugin is loading the system instructions (Sutras, Protocols, Cosmology) into the model's ephemeral memory.

**Status:** **Expected Tradeoff.**
Every "Yes" to a feature (better persona) is a "No" to simplicity (startup speed). We accept this friction to eliminate the downstream friction of bad output.

---

## Behavior Shock

**These are not bugs.**

The plugin uses **"Sutras"**—short, aphoristic rules designed to compress complex behavior into the model's context window. We use this term because "rules" implies a list of don'ts, whereas a "Sutra" implies a structural truth about how the system *must* operate.

### 1. Issue: Claude seems "rude" or "abrupt"

**Symptoms:**
- No greeting.
- No "Here is the code you asked for."

**Explanation:**
This is the **Sutra of the Arrow**. We believe clarity is the highest form of courtesy. "Politeness" in an AI is just noise that dilutes the signal. We strip the preamble to respect your time.

### 2. Issue: Claude won't answer my question directly

**Symptoms:**
- You asked "How do I fix this?"
- Claude responded: "The question assumes X. State your constraints."

**Explanation:**
This is the **Sutra of Mu**. A wrong question cannot generate a right answer. If the model challenges your premise, it is not being difficult; it is trying to prevent you from building on a flawed foundation. It is unasking the question.

### 3. Issue: Missing explanations

**Symptoms:**
- Code arrives without a tutorial.
- No "Breakdown of what this does" section.

**Explanation:**
This is the **Protocol of Zero-Waste**. We prioritize the artifact (the code) over the commentary. If you need an explanation, simply ask "Explain this." We default to the raw material because that is usually what you came for.

---

## Getting Help

**Before Reporting:**
1. Run `/reset` to clear context.
2. Verify you are not experiencing [Behavior Shock](#behavior-shock).
3. Check `claude plugin list` to ensure the version is current.

**Where to Report:**
File issues on the `pentaxis93/claude-code-plugins` GitHub repository.

**Include:**
- Plugin Version
- Claude Code Version
- A screenshot of the "polite" output (proof the Janitor is sleeping).
