# Claude Code Plugins

A Claude Code plugin marketplace enforcing the **Root Operating Mode** through the Sutras of the Cosmic Janitor.

**Warning:** The `cosmic-janitor` plugin transforms Claude Code sessions, and can be configured per project, per user, or globally. It stops the model from glazing and makes it focus on being useful.

## Quick Start

### 1. Add the Marketplace

Run this command in Claude Code to register the source:

```bash
/plugin marketplace add pentaxis93/claude-code-plugins
```

### 2. Install the Plugin

Once the marketplace is added, install the plugin:

```bash
/plugin install cosmic-janitor@claude-code-plugins
```

Alternatively, you can browse interactively:

```bash
/plugin
# → Select "Browse Plugins" → Choose cosmic-janitor
```

### Verification
Run `/reset` to start a fresh session. Observe the shift: zero preamble, atomic code blocks, and strict Functional Honesty.

## Available Plugins

### cosmic-janitor
**The Cosmic Janitor of the Terminal** - Injects the Root Operating System cosmology, making the output simple and direct.

## FAQ

**What's a cosmic janitor?**
The persona we inject into the model. We shift its self-conception from a "Helpful Assistant" (who chats) to a monklike Janitor (who maintains order). Its mission is to sweep away ambiguity and garbage-collect falsehoods until the output runs true.

**Why inject "cosmology" into a terminal?**
It is a prompt engineering technique, not a religion. Large Language Models play roles. If the role is "helpful assistant," they prioritize conversational politeness (noise). If the role is "system process" or "janitor," they prioritize efficiency (signal). The "cosmology" acts as a compression algorithm for the context window, forcing the model to stop chatting and start coding.

**What is "glazing"?**
It is the polite fluff an AI generates before providing the solution (e.g., "Here is the code you requested..."). It wastes time and screen real estate. We garbage-collect it.

## License
MIT
