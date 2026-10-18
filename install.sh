#!/bin/bash
# Copy this repo's skills into the Claude skills directory.
# Idempotent: existing skills are left alone unless --force is passed.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"
FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

[ -d "$SRC" ] || { echo "claude-skills: no skills/ directory next to install.sh" >&2; exit 1; }
mkdir -p "$DEST"

added=0; replaced=0; kept=0
for d in "$SRC"/*/; do
  name=$(basename "$d")
  if [ -e "$DEST/$name" ]; then
    if [ "$FORCE" = "1" ]; then
      rm -rf "$DEST/$name"; cp -r "$d" "$DEST/$name"; replaced=$((replaced+1))
    else
      kept=$((kept+1))
    fi
  else
    cp -r "$d" "$DEST/$name"; added=$((added+1))
  fi
done

echo "claude-skills: ${added} added, ${replaced} replaced, ${kept} already present -> ${DEST}"
