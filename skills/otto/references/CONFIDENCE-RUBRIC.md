# Otto Confidence Rubric

## Design+Plan Confidence

Use two layers:

1. Hard-fail gates
2. Rubric scoring (0-5 per category)

### Hard-Fail Gates

Any hard-fail prevents Autobuild eligibility (`<95%` cap):

- Requirements are materially ambiguous.
- Scope boundaries are missing.
- Dependencies/tooling readiness is unknown.
- Test strategy is missing or non-actionable.
- Risks are not identified with mitigation.

### Scoring Categories (0-5 each)

- Problem clarity
- Scope precision
- Architecture quality
- Integration feasibility
- Testability
- Risk readiness

### Score Anchors

- `0`: missing or actively contradictory
- `1`: mostly unknown; major assumptions remain
- `2`: partially known; important ambiguity remains
- `3`: workable; manageable open questions remain
- `4`: clear; only minor uncertainty remains
- `5`: explicit, validated, and actionable

Score conversion:

- `percentage = round((sum(scores) / 30) * 100)`

Decision:

- `>=95%` and no hard-fails: ask Autobuild prompt.
- `<95%`: state Autobuild unavailable below threshold.

## Build Confidence

Build Confidence is independent from Design+Plan Confidence.

### Scoring Categories (0-5 each)

- Branch/repo readiness
- Dependency/tooling health
- Phase clarity
- Validation command reliability
- Rollback/remediation readiness

### Score Anchors

- `0`: missing or unusable
- `1`: severe blocker likely
- `2`: known gaps require manual handling
- `3`: executable with caution
- `4`: ready with minor risk
- `5`: verified and ready

Score conversion:

- `percentage = round((sum(scores) / 25) * 100)`

Decision:

- `>=90%`: automated build execution allowed.
- `<90%`: fall back to manual phase-by-phase mode.
