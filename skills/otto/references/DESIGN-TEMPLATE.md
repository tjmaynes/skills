# Otto Design Template

Use this template for `.agents/tasks/<YYYY-MM-DD>-<feature-short-name>/design.md`.

```md
# <Feature Title> Design

> Generated: <YYYY-MM-DD>
> Status: Draft | In Review | Approved
> Feature Short Name: <feature-short-name>

## Goal

<One sentence describing the outcome.>

## Background

<Relevant project context, user request, and existing behavior.>

## Success Criteria

- [ ] <measurable outcome>

## Scope

- <included behavior>

## Non-Goals

- <explicitly excluded behavior>

## Users / Consumers

- <who uses or depends on this>

## Chosen Approach

<Recommended approach and why it fits this repository.>

## Alternatives Considered

| Approach | Benefit | Tradeoff | Decision |
|---|---|---|---|
| <approach> | <benefit> | <tradeoff> | chosen/rejected |

## Architecture

<How the change fits into the existing system.>

## Components And Boundaries

| Component | Responsibility | Interface | Dependencies |
|---|---|---|---|
| <component> | <responsibility> | <how used> | <depends on> |

## Data Flow

1. <step>

## Error Handling

| Error Case | Handling | User/System Outcome |
|---|---|---|
| <case> | <handling> | <outcome> |

## Testing Strategy

| Area | Test Type | What It Proves |
|---|---|---|
| <area> | unit/integration/e2e/manual | <proof> |

## Risks And Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| <risk> | <impact> | <mitigation> |

## Open Questions

- <question or none>

## Planning Inputs

- Expected phases:
- Known dependencies:
- Validation commands already known:
- Areas likely to need exploration:
```
