#!/usr/bin/env bash
# Devtools status line - shows model + pwd
# Reads JSON from stdin, outputs formatted status

read -r input
model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
cwd=$(echo "$input" | jq -r '.cwd // "."')

# ANSI colors
cyan='\033[36m'
dim='\033[2m'
reset='\033[0m'

printf "${cyan}%s${reset} ${dim}%s${reset}" "$model" "$cwd"
