#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage: scripts/install.sh <codex|claude|copilot|agents> [skill-root]

Examples:
  scripts/install.sh codex
  scripts/install.sh claude
  scripts/install.sh agents "$PWD/.agents/skills"
EOF
}

if (( $# < 1 || $# > 2 )); then
  usage
  exit 64
fi

host=$1
explicit_root=${2:-}
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(cd -- "${script_dir}/.." && pwd)
source_dir="${repo_root}/sports-api-skill"

case "$host" in
  codex|claude|copilot|agents) ;;
  *)
    usage
    exit 64
    ;;
esac

if [[ -n "$explicit_root" ]]; then
  skill_root=$explicit_root
else
  case "$host" in
    codex) skill_root="${CODEX_HOME:-$HOME/.codex}/skills" ;;
    claude) skill_root="$HOME/.claude/skills" ;;
    copilot) skill_root="$HOME/.copilot/skills" ;;
    agents) skill_root="$HOME/.agents/skills" ;;
  esac
fi

destination="${skill_root%/}/sports-api-skill"

if [[ -e "$destination" ]]; then
  printf 'Error: destination already exists: %s\n' "$destination" >&2
  printf 'Back it up or remove it explicitly before reinstalling.\n' >&2
  exit 73
fi

mkdir -p "$skill_root"
cp -R "$source_dir" "$destination"

printf 'Installed sports-api-skill to %s\n' "$destination"
printf 'Start a new agent session or refresh the host skill index if required.\n'
