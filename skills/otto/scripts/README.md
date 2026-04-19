# Otto Scripts

Automation scripts used by the Otto build stage.

## validate-phase.sh

Validates Definition of Done for a phase by running quality checks.

### Usage

```bash
./skills/otto/scripts/validate-phase.sh
./skills/otto/scripts/validate-phase.sh --stack js
./skills/otto/scripts/validate-phase.sh --stack py
./skills/otto/scripts/validate-phase.sh --stack go
./skills/otto/scripts/validate-phase.sh --stack rust
./skills/otto/scripts/validate-phase.sh --skip-tests
```

### Exit Codes

- `0`: all checks passed
- non-zero: one or more checks failed

### Notes

- Prefer explicit stack selection when auto-detection is uncertain.
- If this script fails, Otto must stop phase completion until issues are fixed.
- The script is written for Bash 3.2 compatibility on macOS and Linux.
- Use project-specific validation commands instead when the repository has canonical checks that differ from the defaults.
