#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
DIRS=(agents skills rules hooks)

echo "Symlinking jean-claude-van-dev into ${CLAUDE_DIR}"

for dir in "${DIRS[@]}"; do
  src="${SCRIPT_DIR}/${dir}"
  dest="${CLAUDE_DIR}/${dir}"

  if [ ! -d "$src" ]; then
    echo "  skip: ${dir}/ (not found in plugin)"
    continue
  fi

  if [ -L "$dest" ]; then
    echo "  update: ${dir}/ (replacing existing symlink)"
    rm "$dest"
  elif [ -d "$dest" ]; then
    echo "  error: ${dest} already exists and is not a symlink"
    echo "         back it up or remove it, then re-run this script"
    exit 1
  fi

  ln -s "$src" "$dest"
  echo "  linked: ${dir}/ -> ${dest}"
done

echo "Done. Restart claude to pick up changes."
