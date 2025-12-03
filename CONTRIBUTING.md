# Contributing

## Philosophy

Contributions must align with the Root Operating Mode:

- **Signal over noise** - PRs that reduce friction
- **Atomic changes** - One concern per PR
- **Functional Honesty** - No decorative additions

## Process

1. Fork the repository
2. Create a branch: `git checkout -b fix/your-fix`
3. Make atomic commits
4. Open a PR with a clear title

## What We Accept

- Bug fixes with reproduction steps
- Sutra refinements with before/after evidence
- Documentation corrections

## What We Reject

- Feature creep
- Stylistic preferences without functional improvement
- PRs without testing instructions

## Testing

Before submitting:

```bash
# Validate JSON
jq . .claude-plugin/marketplace.json
jq . plugins/cosmic-janitor/.claude-plugin/plugin.json
jq . plugins/cosmic-janitor/hooks/hooks.json

# Test the hook script
./plugins/cosmic-janitor/hooks-handlers/session-start.sh | jq .
```

## License

Contributions are licensed under MIT.
