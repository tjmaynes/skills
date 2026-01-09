#!/bin/bash

set -e

# Script to create a new implementation plan file with dated naming and template
# Usage: ./scripts/create-plan.sh "feature name"
# Example: ./scripts/create-plan.sh "dark mode toggle"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PLANS_DIR="$PROJECT_ROOT/plans"

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

print_error() {
  echo -e "${RED}✗ Error: $1${NC}" >&2
}

print_success() {
  echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
  echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
  echo -e "${YELLOW}⚠ $1${NC}"
}

show_usage() {
  cat << 'EOF'
Usage: ./scripts/create-plan.sh "feature name"

Create a new implementation plan file with dated naming convention.

Arguments:
  "feature name"   Feature description (2-4 words, will be converted to lowercase-hyphenated)

Examples:
  ./scripts/create-plan.sh "dark mode toggle"
  ./scripts/create-plan.sh "email verification"
  ./scripts/create-plan.sh "user authentication flow"

Output:
  Creates: plans/YYYY-MM-DD-feature-short-name.md
  Example: plans/2026-01-09-dark-mode-toggle.md

The file will be created with the implementation plan template pre-filled
with all required sections ready for completion.
EOF
}

# ============================================================================
# INPUT VALIDATION
# ============================================================================

if [[ $# -eq 0 ]]; then
  print_error "No feature name provided"
  echo ""
  show_usage
  exit 1
fi

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
  show_usage
  exit 0
fi

FEATURE_INPUT="$1"

# Validate feature name is not empty and not too long
if [[ -z "$FEATURE_INPUT" ]]; then
  print_error "Feature name cannot be empty"
  exit 1
fi

if [[ ${#FEATURE_INPUT} -gt 60 ]]; then
  print_error "Feature name too long (max 60 characters)"
  exit 1
fi

# ============================================================================
# GENERATE FILENAME
# ============================================================================

# Get today's date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

# Convert feature name to lowercase and replace spaces/underscores with hyphens
FEATURE_SLUG=$(echo "$FEATURE_INPUT" | tr '[:upper:]' '[:lower:]' | sed 's/[[:space:]_]\+/-/g' | sed 's/[^a-z0-9-]//g')

# Ensure slug doesn't start or end with hyphens
FEATURE_SLUG=$(echo "$FEATURE_SLUG" | sed 's/^-*//;s/-*$//')

# Check if slug is valid (at least one character)
if [[ -z "$FEATURE_SLUG" ]]; then
  print_error "Could not generate valid filename from: $FEATURE_INPUT"
  exit 1
fi

# Build filename
FILENAME="${TODAY}-${FEATURE_SLUG}.md"
FILEPATH="$PLANS_DIR/$FILENAME"

# ============================================================================
# CREATE PLANS DIRECTORY
# ============================================================================

if [[ ! -d "$PLANS_DIR" ]]; then
  print_info "Creating plans directory..."
  mkdir -p "$PLANS_DIR"
  print_success "Plans directory created: $PLANS_DIR"
fi

# ============================================================================
# CHECK FOR EXISTING FILE
# ============================================================================

if [[ -f "$FILEPATH" ]]; then
  print_warning "File already exists: $FILEPATH"
  read -p "Overwrite? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_info "Aborted"
    exit 0
  fi
fi

# ============================================================================
# CREATE PLAN FILE WITH TEMPLATE
# ============================================================================

# Create the template content
TEMPLATE=$(cat << 'TEMPLATE_EOF'
# [Feature Title]

## Overview
[What the feature does and why it matters - 1-2 sentences]

## Requirements
- [Specific requirement 1]
- [Specific requirement 2]
- [Specific requirement 3]
- [Specific requirement 4]
- [Specific requirement 5]

## Non-Goals
- [What will NOT be built - justification]
- [What's deferred to future - why]
- [What's explicitly out of scope - rationale]

## Acceptance Criteria
- [ ] [Testable criterion 1]
- [ ] [Testable criterion 2]
- [ ] [Testable criterion 3]
- [ ] [Testable criterion 4]
- [ ] [Testable criterion 5]

## Effort
**Estimated Effort:** Small (1-2 days) | Medium (3-5 days) | Large (6+ days)

**Context:** [Any factors affecting the estimate - complexity, dependencies, constraints]

## Implementation

### Approach
[High-level strategy and technology choices]

### Implementation Steps

1. **[Step title]** - `path/to/file.ts`
   - What to do and why
   - Suggested code snippet based on existing codebase patterns:
   ```typescript
   // Example implementation
   ```

2. **[Step title]** - `path/to/file2.ts`
   - What to do and why
   - Suggested code snippet based on existing codebase patterns:
   ```typescript
   // Example implementation
   ```

## Risks
- Risk: [Description]
  Mitigation: [How to address]
- Risk: [Description]
  Mitigation: [How to address]

## Dependencies
- [Dependency name and version if applicable]
- [External service or approval required]
- [Team or infrastructure dependency]

## References
[Links to relevant documentation, issues, or related code]
TEMPLATE_EOF
)

# Write the template to file
echo "$TEMPLATE" > "$FILEPATH"

# ============================================================================
# PROVIDE FEEDBACK
# ============================================================================

print_success "Implementation plan created!"
echo ""
echo "📄 File: $FILEPATH"
echo "📝 Title: $FEATURE_INPUT"
echo ""
print_info "Next steps:"
echo "   1. Open the file and fill in all [bracketed] sections"
echo "   2. Replace [Feature Title] with your feature name"
echo "   3. Complete each section with specific details"
echo "   4. Use the examples in references/examples.md as a guide"
echo ""
print_info "Key sections to complete:"
echo "   • Overview: 1-2 sentences on what and why"
echo "   • Requirements: 3-5 specific capabilities"
echo "   • Non-Goals: What's intentionally excluded"
echo "   • Acceptance Criteria: Testable success conditions (use checkboxes)"
echo "   • Effort: Small/Medium/Large estimate"
echo "   • Implementation Steps: Numbered steps with file paths and code"
echo "   • Risks: Potential challenges with mitigations"
echo ""
echo "💡 Tip: Open the plan in your editor:"
echo "   $FILEPATH"
echo ""
