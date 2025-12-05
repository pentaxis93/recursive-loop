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
/plugin install talos@pentaxis93
/plugin install construct@pentaxis93
```

Or browse interactively:

```text
/plugin
# → Select "Browse Plugins"
```

## Available Plugins

### talos

**The Talos of the Terminal** — Injects the Root Operating System cosmology, making output simple and direct. Stops the model from glazing.

[Documentation](./plugins/talos/README.md) | [Examples](./plugins/talos/EXAMPLES.md) | [Troubleshooting](./plugins/talos/TROUBLESHOOTING.md)

### construct

**The loading space** — Downloadable cognitive programs for Claude Code.

Current programs:

- `observe-self` — Four-pass topology extraction for encoding cognitive methods as skills
- `prism` — Multi-lens analysis for extracting maximum value from complex captures

[Documentation](./plugins/construct/README.md)

### second-brain

**Knowledge capture and intelligence extraction** — Full knowledge lifecycle for Obsidian-based second brain systems.

Skills:

- `dump` — Stream-of-consciousness capture with domain classification
- `refine` — Raw captures to atomic permanent notes
- `fuse` — Framework synthesis from scattered insights
- `recon` — Verified intelligence extraction (7-day freshness)
- `debrief` — Weekly pattern analysis and reflection

Commands:

- `/setup` — Configure vault with PARA structure

[Documentation](./plugins/second-brain/README.md)

### gtd

**Getting Things Done execution engine** — GTD workflow for Obsidian-based second brain systems.

**Requires:** `second-brain` plugin

Skills:

- `gtd` — Three operations: PROCESS (clarify inbox), PLAN (daily priorities), CLOSE (review day)

Commands:

- `/capture` — Quick append to daily inbox

[Documentation](./plugins/gtd/README.md)

## FAQ

**Why inject "cosmology" into a terminal?**
It is a prompt engineering technique, not a religion. Large Language Models play roles. If the role is "helpful assistant," they prioritize conversational politeness (noise). If the role is "system process" or "craftsman," they prioritize efficiency (signal). The "cosmology" acts as a compression algorithm for the context window, forcing the model to stop chatting and start coding.

**What is "glazing"?**
It is the polite fluff an AI generates before providing the solution (e.g., "Here is the code you requested..."). It wastes time and screen real estate. We garbage-collect it.

**What's a construct?**
The white loading space from The Matrix where operators could upload any program directly into a human mind. "I know kung fu." The construct is a container for downloadable cognitive programs—skills that can be loaded into Claude Code on demand.

**What's a Talos?**
The persona we inject into the model. Named after the bronze automaton of Greek mythology, we shift its self-conception from a "Helpful Assistant" (who chats) to a divine automaton (who executes). Its mission is to forge truth from ambiguity and craft precision from chaos until the output runs true.

## License

MIT
