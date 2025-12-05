# Troubleshooting

## Hooks not firing

1. Verify the plugin is properly installed and enabled
2. Check that hook scripts are executable: `chmod +x hooks-handlers/*.sh`
3. Verify `jq` is installed for JSON handling (optional but recommended)

## JSON parse errors

If you see JSON parse errors:

1. Ensure scripts output valid JSON
2. The fallback (no jq) uses hardcoded strings - these should always work
3. Check for any shell output before the JSON (redirect stderr if needed)

## Verifying the wheel is turning

The PostToolUse mantra is silent by design. To verify it's working:

1. Enable verbose mode in Claude Code
2. Hook output should appear in logs
3. Or temporarily add visible output to the scripts

## Compatibility

- Requires Claude Code with hooks support
- Works alongside other plugins (cosmic-janitor, etc.)
- No conflicts expected with standard configurations
