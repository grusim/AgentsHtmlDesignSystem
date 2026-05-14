#!/usr/bin/env bash
# deploy.sh — install the agents-html-comms skill from this repo into
# ~/.claude/skills/ as a clean copy. Run after each edit during development.
#
# Usage:
#   ./deploy.sh              # user-scope install
#   ./deploy.sh --project P  # project-scope install into P/.claude/skills/
#
# Wipes the target directory first so removed files don't linger.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_ROOT/skills/agents-html-comms"

if [[ ! -d "$SRC" ]]; then
  echo "error: source not found at $SRC" >&2
  exit 1
fi

TARGET_BASE="${HOME}/.claude/skills"
if [[ "${1:-}" == "--project" ]]; then
  if [[ -z "${2:-}" ]]; then
    echo "error: --project requires a path" >&2
    exit 1
  fi
  TARGET_BASE="$2/.claude/skills"
fi

TARGET="$TARGET_BASE/agents-html-comms"

mkdir -p "$TARGET_BASE"

if [[ -L "$TARGET" ]]; then
  echo "removing stale symlink at $TARGET"
  rm "$TARGET"
elif [[ -e "$TARGET" ]]; then
  echo "removing existing $TARGET"
  rm -rf "$TARGET"
fi

cp -R "$SRC" "$TARGET"

echo "deployed agents-html-comms to $TARGET"

# Sanity check
if [[ -f "$TARGET/SKILL.md" ]]; then
  echo "SKILL.md present — install OK"
else
  echo "warning: SKILL.md missing in target" >&2
  exit 2
fi

# Remind about the design-system dep
if [[ ! -d "$HOME/.claude/skills/agents-html-design" ]]; then
  cat <<'EOF'

note: agents-html-design skill is not installed at ~/.claude/skills/agents-html-design
      this skill depends on it. install per its own INSTALL.md before use.
EOF
fi
