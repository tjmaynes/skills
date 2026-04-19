#!/bin/bash
#
# validate-phase.sh - Validate Definition of Done for a phase.
#
# Usage: ./validate-phase.sh [--stack <js|py|go|rust>] [--skip-tests]

set -u

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

STACK=""
SKIP_TESTS=false
OVERALL_STATUS=0
RESULT_LINES=""

usage() {
    echo "Usage: ./validate-phase.sh [--stack <js|py|go|rust>] [--skip-tests]"
    echo ""
    echo "Options:"
    echo "  --stack <type>  Specify stack (js, py, go, rust). Auto-detected if not provided."
    echo "  --skip-tests    Skip test execution for phases without code changes."
    echo "  -h, --help      Show this help message."
}

while [ $# -gt 0 ]; do
    case "$1" in
        --stack)
            if [ $# -lt 2 ]; then
                echo "Missing value for --stack"
                exit 1
            fi
            STACK="$2"
            shift 2
            ;;
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

detect_stack() {
    if [ -f "package.json" ]; then
        echo "js"
    elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
        echo "py"
    elif [ -f "go.mod" ]; then
        echo "go"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    else
        echo "unknown"
    fi
}

append_result() {
    RESULT_LINES="${RESULT_LINES}$1:$2
"
}

run_shell_check() {
    name="$1"
    command="$2"

    echo ""
    printf "%bRunning: %s%b\n" "$YELLOW" "$name" "$NC"
    echo "Command: $command"
    echo "---"

    if /bin/sh -c "$command"; then
        append_result "$name" "PASS"
        printf "%bPASS%b %s\n" "$GREEN" "$NC" "$name"
    else
        append_result "$name" "FAIL"
        OVERALL_STATUS=1
        printf "%bFAIL%b %s\n" "$RED" "$NC" "$name"
    fi
}

run_js_checks() {
    run_shell_check "Linter" "npm run lint || npx eslint . --ext .ts,.tsx,.js,.jsx"
    run_shell_check "Formatter" "npm run format:check || npx prettier --check ."
    run_shell_check "Type Checker" "npm run typecheck || npx tsc --noEmit"
    if [ "$SKIP_TESTS" = false ]; then
        run_shell_check "Tests" "npm test"
    else
        append_result "Tests" "SKIPPED"
    fi
}

run_py_checks() {
    run_shell_check "Linter" "ruff check . || pylint src"
    run_shell_check "Formatter" "black --check ."
    run_shell_check "Type Checker" "mypy . || pyright"
    if [ "$SKIP_TESTS" = false ]; then
        run_shell_check "Tests" "pytest"
    else
        append_result "Tests" "SKIPPED"
    fi
}

run_go_checks() {
    run_shell_check "Linter" "golangci-lint run || go vet ./..."
    run_shell_check "Formatter" "test -z \"\$(gofmt -l .)\""
    run_shell_check "Type Checker" "go build ./..."
    if [ "$SKIP_TESTS" = false ]; then
        run_shell_check "Tests" "go test ./..."
    else
        append_result "Tests" "SKIPPED"
    fi
}

run_rust_checks() {
    run_shell_check "Linter" "cargo clippy -- -D warnings"
    run_shell_check "Formatter" "cargo fmt --check"
    run_shell_check "Type Checker" "cargo check"
    if [ "$SKIP_TESTS" = false ]; then
        run_shell_check "Tests" "cargo test"
    else
        append_result "Tests" "SKIPPED"
    fi
}

print_summary() {
    echo ""
    echo "=============================================="
    echo "VALIDATION SUMMARY"
    echo "=============================================="
    printf "%s" "$RESULT_LINES" | while IFS=: read -r name status; do
        [ -z "$name" ] && continue
        case "$status" in
            PASS)
                printf "  %bPASS%b %s\n" "$GREEN" "$NC" "$name"
                ;;
            FAIL)
                printf "  %bFAIL%b %s\n" "$RED" "$NC" "$name"
                ;;
            SKIPPED)
                printf "  %bSKIP%b %s\n" "$YELLOW" "$NC" "$name"
                ;;
            *)
                printf "  %bUNKNOWN%b %s\n" "$YELLOW" "$NC" "$name"
                ;;
        esac
    done

    echo ""
    if [ "$OVERALL_STATUS" -eq 0 ]; then
        printf "%bDEFINITION OF DONE: PASSED%b\n" "$GREEN" "$NC"
    else
        printf "%bDEFINITION OF DONE: FAILED%b\n" "$RED" "$NC"
        echo "Fix failing checks before proceeding."
    fi
}

if [ -z "$STACK" ]; then
    STACK="$(detect_stack)"
    printf "%bAuto-detected stack: %s%b\n" "$YELLOW" "$STACK" "$NC"
fi

echo "=============================================="
echo "DEFINITION OF DONE VALIDATION"
echo "Stack: $STACK"
echo "=============================================="

case "$STACK" in
    js)
        run_js_checks
        ;;
    py)
        run_py_checks
        ;;
    go)
        run_go_checks
        ;;
    rust)
        run_rust_checks
        ;;
    *)
        printf "%bUnknown or unsupported stack: %s%b\n" "$RED" "$STACK" "$NC"
        echo "Specify stack with --stack <js|py|go|rust> or run project-specific validation commands."
        exit 1
        ;;
esac

print_summary
exit "$OVERALL_STATUS"
