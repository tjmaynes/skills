#!/usr/bin/env bash
set -euo pipefail

STOW_DIR="$(pwd)"
TARGET_DIRS=("${HOME}/.agents/skills")

for TARGET_DIR in "${TARGET_DIRS[@]}"; do
    mkdir -p "$TARGET_DIR"
    echo "📦 Stowing skills to $TARGET_DIR..."
    stow --target="$TARGET_DIR" --restow skills
    echo "📋 Available skills in $TARGET_DIR:"
    ls -1 "$TARGET_DIR" | sed 's/^/   /'
    echo ""
done

echo "✅ Skills synchronized successfully!"