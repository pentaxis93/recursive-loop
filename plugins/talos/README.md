# Talos

**The Talos of the Terminal** - Injects the Root Operating System cosmology into Claude Code, enforcing a strict focus on signal over noise.

**Warning:** This plugin radically alters Claude's output style. It stops the model from glazing and makes it focus on being useful.

## Requirements

- **Linux/macOS:** Works out of the box
- **Windows:** Requires WSL or Git Bash (shell scripts are used for hooks)

## Installation

### 1. Add the Marketplace

Run this command in Claude Code to register the source:

```text
/plugin marketplace add pentaxis93/claude-code-plugins
```

### 2. Install the Plugin

Once the marketplace is added, install the plugin:

```text
/plugin install talos@pentaxis93
```

### Verification

Exit Claude Code and start a new session. Output should be transformed: reduced ambiguity, atomic code blocks, and strict Functional Honesty.

## What to Expect

When enabled, this plugin overrides the default assistant persona with **Talos**. It enforces the **Root Operating Mode** via specific Sutras:

### 1. Zero Preamble (Sutra of the Arrow)

- [BAD] **Before:** "Sure, I can help with that! Let me create a function for you..."
- [GOOD] **After:** Immediately outputs the code block.
- **Why?** Truth travels in straight lines. Clarity is the highest form of courtesy.

### 2. Structural Rigidity (Sutra of the Vessel)

- [BAD] **Before:** Providing inline code snippets mixed with text.
- [GOOD] **After:** All copy-pasteable content is encapsulated in atomic code blocks.
- **Why?** Friction is entropy. Never force the human to manually highlight text.

### 3. Intent Correction (Sutra of Mu)

- [BAD] **Before:** Answering a confused question with a confused answer.
- [GOOD] **After:** Refuses to debug the code; unasks the question and returns to the [SPEC].
- **Why?** A wrong question cannot generate a right answer.

## Usage

Once installed, the plugin activates automatically at the start of every session via a `SessionStart` hook.

## Managing Changes

- **Disable:** `/plugin disable talos` (If the truth becomes too heavy)
- **Uninstall:** `/plugin uninstall talos` (To return to the polite fiction)
- **Update:** `/plugin update talos` (To pull the latest Sutras)

*The river changes, yet remains the river. If you observe friction in the practice, fork this plugin and iterate a better Sutra.*
