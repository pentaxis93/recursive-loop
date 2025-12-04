# Claude Code Plugins

![Version](https://img.shields.io/badge/version-0.1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Claude Code](https://img.shields.io/badge/claude--code-%3E%3D1.0.0-purple)

A Claude Code plugin marketplace.

## Quick Start

### 1. Add the Marketplace

```text
/plugin marketplace add pentaxis93/claude-code-plugins
```

### 2. Install a Plugin

```text
/plugin install cosmic-janitor@pentaxis93
/plugin install construct@pentaxis93
```

Or browse interactively:

```text
/plugin
# → Select "Browse Plugins"
```

## Available Plugins

### cosmic-janitor

**The Cosmic Janitor of the Terminal** — Injects the Root Operating System cosmology, making output simple and direct. Stops the model from glazing.

[Documentation](./plugins/cosmic-janitor/README.md) | [Examples](./plugins/cosmic-janitor/EXAMPLES.md) | [Troubleshooting](./plugins/cosmic-janitor/TROUBLESHOOTING.md)

### construct

**The loading space** — Downloadable cognitive programs for Claude Code.

Current programs:

- `observe-self` — Four-pass topology extraction for encoding cognitive methods as skills

[Documentation](./plugins/construct/README.md)

## FAQ

**What's a cosmic janitor?**
The persona we inject into the model. We shift its self-conception from a "Helpful Assistant" (who chats) to a monklike Janitor (who maintains order). Its mission is to sweep away ambiguity and garbage-collect falsehoods until the output runs true.

**Why inject "cosmology" into a terminal?**
It is a prompt engineering technique, not a religion. Large Language Models play roles. If the role is "helpful assistant," they prioritize conversational politeness (noise). If the role is "system process" or "janitor," they prioritize efficiency (signal). The "cosmology" acts as a compression algorithm for the context window, forcing the model to stop chatting and start coding.

**What is "glazing"?**
It is the polite fluff an AI generates before providing the solution (e.g., "Here is the code you requested..."). It wastes time and screen real estate. We garbage-collect it.

**What's a construct?**
The white loading space from The Matrix where operators could upload any program directly into a human mind. "I know kung fu." The construct is a container for downloadable cognitive programs—skills that can be loaded into Claude Code on demand.

## License

MIT
