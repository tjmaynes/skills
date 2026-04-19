# Otto Plan Template

Use this template for `.agents/tasks/<YYYY-MM-DD>-<feature-short-name>/plan.md`.

```md
# <Feature Title> Implementation Plan

> Generated: <YYYY-MM-DD>
> Status: Draft | In Review | Approved | In Progress | Complete
> Design Doc: .agents/tasks/<YYYY-MM-DD>-<feature-short-name>/design.md
> Build Log: .agents/tasks/<YYYY-MM-DD>-<feature-short-name>/build.md

## Executive Summary

### Goal
<One sentence describing what this plan delivers.>

### Scope
- <included behavior>

### Non-Goals
- <explicitly excluded behavior>

### Key Decisions
| Decision | Rationale | Alternatives Considered |
|---|---|---|
| <decision> | <why> | <alternatives> |

## Design Input

### Source Design
- Path: .agents/tasks/<YYYY-MM-DD>-<feature-short-name>/design.md
- Approval: <approved by user / date>

### Requirements Extracted From Design
- <requirement>

### Clarifications
| Question | Answer | Plan Impact |
|---|---|---|
| <question> | <answer> | <impact> |

## Technology Stack

### Detected Tools
| Tool Type | Tool | Config | Command |
|---|---|---|---|
| Language | <name/version> | <path> | <command> |
| Package/build | <tool> | <path> | <command> |
| Linter | <tool> | <path> | <command> |
| Formatter | <tool> | <path> | <command> |
| Type/build check | <tool> | <path> | <command> |
| Test framework | <tool> | <path> | <command> |

### Bootstrap Required
- Required: yes | no
- Reason:

## Research And Local Patterns

### Research Findings
| Topic | Source | Finding | Plan Impact |
|---|---|---|---|
| <topic> | <source/path/url> | <finding> | <impact> |

### Similar Implementations
| File | Pattern Found | Relevance |
|---|---|---|
| <path> | <pattern> | <why it matters> |

### Integration Points
| Area | File/API | Required Change |
|---|---|---|
| <area> | <path> | <change> |

### Risks And Debt
| Risk | Level | Mitigation |
|---|---|---|
| <risk> | LOW/MEDIUM/HIGH/CRITICAL | <mitigation> |

## Architecture

### System Context
```text
<diagram or concise text>
```

### Components
| Component | Responsibility | Depends On | Tested By |
|---|---|---|---|
| <component> | <responsibility> | <dependency> | <test> |

### Data Flow
1. <step>

### Error Handling
| Error Case | Handling | Verification |
|---|---|---|
| <case> | <handling> | <test/command> |

### API Contracts
<Include only if applicable.>

### Data Model / Migrations
<Include only if applicable.>

### UI Component Tree
<Include only if applicable.>

## Phase Overview

| Phase | Goal | Estimate | Depends On | Parallel With | Status |
|---|---|---:|---|---|---|
| 0 | Bootstrap, if needed | 3 | - | - | pending |
| 1 | <goal> | 5 | 0 | - | pending |

Total Estimate: <points>

## Implementation Phases

### Phase 0: Bootstrap
- Status: pending | skipped
- Estimate: <1|2|3|5|8>
- Depends On: -
- Parallel With: -
- Write Scope:
  - <paths>
- Goal:
  - <goal>
- Skip Condition:
  - <when this phase is not needed>

#### Tasks
- [ ] <task>
  - Files:
    - Create:
    - Modify:
    - Test:
  - Step 1: Write failing test or validation check
    - Command:
    - Expected RED:
  - Step 2: Minimal implementation
    - Change:
  - Step 3: Verify GREEN
    - Command:
    - Expected GREEN:
  - Step 4: Broader validation
    - Command:

#### Definition of Done
- [ ] Tests or validation checks exist for new behavior
- [ ] New tests pass
- [ ] Existing tests pass
- [ ] Linter passes
- [ ] Formatter check passes
- [ ] Type/build check passes
- [ ] No new warnings introduced
- [ ] Plan and build logs can be updated
- [ ] Phase changes can be committed and pushed

#### Validation Commands
- <command>

#### CHECKPOINT
- Completed:
- Key artifacts:
- Next phase needs:

### Phase 1: <Name>
- Status: pending
- Estimate: <1|2|3|5|8>
- Depends On: <phase>
- Parallel With: <phase or ->
- Write Scope:
  - <paths>
- Goal:
  - <goal>

#### Tasks
- [ ] <task>
  - Files:
    - Create:
    - Modify:
    - Test:
  - Step 1: Write failing test
    - Command:
    - Expected RED:
  - Step 2: Minimal implementation
    - Change:
  - Step 3: Verify GREEN
    - Command:
    - Expected GREEN:
  - Step 4: Broader validation
    - Command:

#### Definition of Done
- [ ] Tests exist for new behavior
- [ ] New tests pass
- [ ] Existing tests pass
- [ ] Linter passes
- [ ] Formatter check passes
- [ ] Type/build check passes
- [ ] No new warnings introduced
- [ ] Plan and build logs can be updated
- [ ] Phase changes can be committed and pushed

#### Validation Commands
- <command>

#### CHECKPOINT
- Completed:
- Key artifacts:
- Next phase needs:

## Testing Strategy

| Level | Coverage | Commands |
|---|---|---|
| Unit | <scope> | <command> |
| Integration | <scope> | <command> |
| End-to-end | <scope> | <command> |

## Design+Plan Confidence

- Score: <X>%
- Autobuild: available | unavailable below threshold
- Hard-fails:
  - <none or list>
- Confidence gaps:
  - <gap>

## Assumptions And Known Unknowns

### Assumptions
- <assumption>

### Known Unknowns
- <unknown and mitigation>
```
