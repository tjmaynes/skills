#!/usr/bin/env bash
set -euo pipefail

TARGET_DIRS=("${HOME}/.agents/skills")

if command -v claude >/dev/null 2>&1; then
    TARGET_DIRS+=("${HOME}/.claude/skills")
else
    echo "⏭️  Claude Code is not installed; skipping ~/.claude/skills."
fi

for TARGET_DIR in "${TARGET_DIRS[@]}"; do
    mkdir -p "$TARGET_DIR"
    echo "📦 Stowing skills to $TARGET_DIR..."
    stow --target="$TARGET_DIR" --restow skills
    echo "📋 Available skills in $TARGET_DIR:"
    ls -1 "$TARGET_DIR" | sed 's/^/   /'
    echo ""
done

echo "✅ Skills synchronized successfully!"
