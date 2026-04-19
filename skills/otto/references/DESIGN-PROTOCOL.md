# Otto Design Protocol

Use this protocol for Stage 1 before planning or implementation.

The goal of design is to turn a request into an approved `design.md` that is
specific enough to produce a build-ready plan.

## Design Hard Gate

Do not write code, scaffold files, change configuration, install dependencies,
or start planning until the design is approved.

This applies even when the task looks small. A short design is valid; skipping
design is not.

## Design Flow

Run these steps in order.

1. Explore project context
2. Assess scope and decomposition needs
3. Offer visual support only when visual decisions are likely
4. Ask clarifying questions one at a time
5. Propose 2-3 approaches with tradeoffs
6. Present design sections incrementally
7. Write `design.md`
8. Self-review the written design
9. Ask user to approve `design.md`
10. Transition to planning

## Step 1: Explore Project Context

Before asking detailed questions, inspect:

- Repository structure
- `README.md`, `AGENTS.md`, `CLAUDE.md`, and relevant docs
- Recent commits when useful
- Similar features or local conventions
- Existing scripts, test commands, and quality gates

Capture only context relevant to the requested work.

## Step 2: Assess Scope

Classify the request before deep questioning.

If it contains multiple independent subsystems, pause and decompose it:

- Identify each subsystem
- Explain dependencies between them
- Recommend the first sub-project
- Design only the first approved sub-project

Examples of too-large scope:

- A platform with auth, billing, analytics, file storage, and chat
- A full rewrite plus new features
- Multiple unrelated products in one request

Each sub-project should get its own `design.md`, `plan.md`, and `build.md`.

## Step 3: Visual Support Decision

Use text-only by default.

Offer visual support only when upcoming questions would be clearer with visual
artifacts such as:

- UI mockups
- Layout comparisons
- Architecture diagrams
- Flow diagrams

If visual support is not available or not needed, continue with text-only
design. Do not block design on visual tooling.

## Step 4: Clarifying Questions

Ask one question at a time.

Prefer multiple choice when it reduces friction. Use open-ended questions when
the decision space is not known.

Cover only what is needed:

- Purpose and target user
- Success criteria
- Scope and non-goals
- Constraints
- Existing patterns to preserve
- Risks and failure modes
- Testing expectations
- What can be deferred

Stop asking once the design is specific enough to propose approaches.

## Step 5: Propose Approaches

Present 2-3 viable approaches.

For each approach include:

- Summary
- Benefits
- Tradeoffs
- Risk
- Fit with existing codebase

Lead with the recommended approach and explain why.

Reject unnecessary scope. Prefer the smallest design that satisfies the goal and
keeps future extension possible without building future features now.

## Step 6: Present Design Incrementally

Present design in sections scaled to complexity.

Recommended sections:

- Problem and goal
- Scope and non-goals
- User or system workflow
- Architecture
- Components and boundaries
- Data flow
- Error handling
- Testing strategy
- Risks and mitigations

After each substantial section, ask whether it looks right before moving on.
If the user changes direction, revise the design before continuing.

## Step 7: Design For Isolation

Each proposed unit should have:

- One clear responsibility
- A small public interface
- Explicit dependencies
- A clear test strategy
- Internals that can change without breaking consumers

If an existing file or module is too broad for safe work, include targeted
boundary improvement in the design. Do not include unrelated refactoring.

## Step 8: Write `design.md`

Write the approved design to:

`.agents/tasks/<YYYY-MM-DD>-<feature-short-name>/design.md`

Use `DESIGN-TEMPLATE.md`.

The design must include:

- Goal
- Background/context
- Scope
- Non-goals
- Chosen approach
- Alternatives considered
- Architecture
- Components and boundaries
- Data flow
- Error handling
- Testing strategy
- Risks and mitigations
- Open questions, if any

## Step 9: Self-Review

Before asking user to approve the file, check:

- No placeholders such as `TBD`, `TODO`, or vague requirements
- No contradictions between sections
- Scope is small enough for one implementation plan
- Requirements cannot reasonably be read two ways
- Testing strategy can be translated into commands
- Planning inputs are present

Fix issues inline before user review.

## Step 10: User Review Gate

After writing and self-reviewing `design.md`, ask the user to review it before
planning.

Use this shape:

```text
Design written to <path>. Please review it and tell me if you want changes
before I create the implementation plan.
```

If the user requests changes, update `design.md` and repeat self-review.

Planning can start only after user approval.

## Design Completion Output

When the design is approved, summarize:

- Design path
- Chosen approach
- Major non-goals
- Key risks
- Planning inputs that are ready

Then move to Stage 2.
