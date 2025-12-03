# Claude Code Plugins

![Version](https://img.shields.io/badge/version-0.1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

A Claude Code plugin marketplace enforcing the **Root Operating Mode** through the Sutras of the Cosmic Janitor.

> **Note:** Early release (0.1.0). The Sutras may be refined based on observed behavior.

**Warning:** The `cosmic-janitor` plugin transforms Claude Code sessions. It stops the model from glazing and makes it focus on being useful.

## Quick Start

### 1. Add the Marketplace

Run this command in Claude Code to register the source:

```bash
/plugin marketplace add pentaxis93/claude-code-plugins
```

### 2. Install the Plugin

Once the marketplace is added, install the plugin:

```bash
/plugin install cosmic-janitor@pentaxis93
```

Alternatively, you can browse interactively:

```bash
/plugin
# → Select "Browse Plugins" → Choose cosmic-janitor
```

### Verification

Run `/reset` to start a fresh session. Test the transformation:

**Input:** "Create a hello world function"

**Expected (Janitor active):**
```javascript
function hello() {
  console.log('Hello, World');
}
```

**Not expected (Janitor inactive):**
> "Sure! I'd be happy to help you create a hello world function..."

If you see verbose responses, consult the [troubleshooting guide](./plugins/cosmic-janitor/TROUBLESHOOTING.md).

## Available Plugins

### cosmic-janitor

**The Cosmic Janitor of the Terminal** - Injects the Root Operating System cosmology, making the output simple and direct.

[Documentation](./plugins/cosmic-janitor/README.md) | [Examples](./plugins/cosmic-janitor/EXAMPLES.md) | [Troubleshooting](./plugins/cosmic-janitor/TROUBLESHOOTING.md)

## FAQ

**What's a cosmic janitor?**
The persona we inject into the model. We shift its self-conception from a "Helpful Assistant" (who chats) to a monklike Janitor (who maintains order). Its mission is to sweep away ambiguity and garbage-collect falsehoods until the output runs true.

**Why inject "cosmology" into a terminal?**
It is a prompt engineering technique, not a religion. Large Language Models play roles. If the role is "helpful assistant," they prioritize conversational politeness (noise). If the role is "system process" or "janitor," they prioritize efficiency (signal). The "cosmology" acts as a compression algorithm for the context window, forcing the model to stop chatting and start coding.

**What is "glazing"?**
It is the polite fluff an AI generates before providing the solution (e.g., "Here is the code you requested..."). It wastes time and screen real estate. We garbage-collect it.

## License
MIT
