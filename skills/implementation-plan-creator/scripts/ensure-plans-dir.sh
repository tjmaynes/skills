#!/bin/bash

# ensure-plans-dir.sh
#
# Ensures the 'plans' directory exists in the project root.
# Safe to run multiple times - idempotent.
#
# Usage: ./scripts/ensure-plans-dir.sh

set -e

# Get the project root (assumes script is in project/scripts/ensure-plans-dir.sh)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Plans directory path
PLANS_DIR="$PROJECT_ROOT/plans"

# Create the directory if it doesn't exist
if [ ! -d "$PLANS_DIR" ]; then
    mkdir -p "$PLANS_DIR"
    echo "✓ Created plans directory at: $PLANS_DIR"
else
    echo "✓ Plans directory already exists at: $PLANS_DIR"
fi

exit 0
