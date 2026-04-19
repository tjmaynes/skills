# Otto Planning Protocol

Use this protocol for Stage 2 after `design.md` is approved.

The goal of planning is to produce a build-ready `plan.md` that another agent
can execute without relying on chat history.

## Planning Flow

Run these steps in order.

1. Intake approved design
2. Detect technology stack and quality tools
3. Interview only for missing information
4. Research current practices when needed
5. Explore codebase patterns and integration points
6. Assess refactor or bootstrap needs
7. Design implementation architecture
8. Break work into dependency-ordered phases
9. Detail code deltas and test-first tasks
10. Define quality gates and command evidence
11. Score Design+Plan Confidence
12. Write and review `plan.md`

## Step 1: Intake Approved Design

Read `design.md` and extract:

- Original user goal
- Accepted scope
- Explicit non-goals
- Architecture decisions
- Data flow
- Error handling
- Testing expectations
- Open questions

If the design is not approved, stop. Planning depends on an approved design.

## Step 2: Detect Stack And Tooling

Check repo docs before scanning:

- `AGENTS.md`
- `CLAUDE.md`
- `README.md`
- `Justfile`
- `Makefile`
- package/build config files
- CI config

Detection checklist:

- Primary language(s)
- Framework(s)
- Package/build tool
- Linter
- Formatter
- Type checker or compile command
- Test framework
- Coverage tool or threshold
- Deployment/runtime constraints

If quality tools are missing, include `Phase 0: Bootstrap` in the plan unless
the user explicitly rejects that setup.

## Step 3: Interview For Missing Information

Ask only questions needed to make the plan executable.

Prefer 3-5 targeted questions at a time when planning has several gaps. For a
small feature, ask fewer.

Core planning questions:

- What is the MVP and what can be deferred?
- What is explicitly out of scope?
- Are there performance, security, compliance, or accessibility requirements?
- What test coverage or validation is expected?
- Are there rollout, feature flag, migration, or rollback requirements?

Do not ask about areas that are irrelevant to the design. For example, do not
ask database questions for a UI-only task unless state persistence is involved.

Record each answer in `plan.md` with its implementation implication.

## Step 4: Research When Needed

Bypass external research when repo docs fully identify the stack and the task
uses established local patterns.

Research when:

- The stack is unknown or version-sensitive.
- The task touches security, authentication, data storage, infrastructure, or
  external APIs.
- The repo has no clear local precedent.
- The design depends on a library or framework behavior that may have changed.

Capture:

- Sources consulted
- Date of research
- Key findings
- Specific decisions affected by research
- Anti-patterns to avoid

## Step 5: Explore Codebase

Use parallel exploration when possible for independent questions.

Required exploration tracks:

- Pattern discovery: similar code, conventions, naming, tests.
- Integration points: files, APIs, commands, configuration, data models.
- Risk and debt scan: large files, unclear boundaries, brittle tests, missing
  quality tools, migration risks.

Output tables in `plan.md`:

- Similar implementations
- Integration points
- Technical debt or risks

Do not plan unrelated refactors. Include only refactors needed to complete the
approved design safely.

## Step 6: Refactor And Bootstrap Assessment

Classify affected code:

| Level | Meaning | Planning Action |
|---|---|---|
| LOW | Clean enough | Proceed |
| MEDIUM | Manageable local issues | Include targeted cleanup tasks |
| HIGH | Work is risky without refactor | Recommend refactor phase |
| CRITICAL | Existing design blocks feature safely | Pause for user decision |

Bootstrap phase triggers:

- No test runner for code changes
- No linter/formatter/type/build command
- Missing local dev or validation command needed for the feature
- Required dependency setup is absent

## Step 7: Architecture

The plan must explain how the implementation fits the existing system.

Include relevant sections:

- System context
- Component boundaries
- API contracts
- Data model or migrations
- UI component tree
- Data flow
- Error handling and recovery
- Security/privacy considerations
- Observability, logging, or analytics

For every new component, answer:

- What does it do?
- How is it used?
- What does it depend on?
- How will it be tested?

## Step 8: Phase Breakdown

Use Fibonacci estimates: `1, 2, 3, 5, 8, 13, 21`.

Target phase size: `3-8` points.

Split any phase estimated at `13+` unless there is a strong reason not to.

Each phase must have:

- Goal
- Status
- Estimate
- Dependencies
- Parallel With field
- Write scope
- Tasks
- Definition of Done
- Validation commands
- Checkpoint notes

Parallel phase rule:

- Mark phases parallel only when they have disjoint write scopes and no runtime
  dependency on each other.
- If write scopes overlap, keep them sequential.

## Step 9: Task Detail

Every code-changing task must include:

- Exact files to create, modify, or delete
- Test file path
- Failing test intent
- Exact test command
- Expected failing output or failure reason
- Minimal implementation description or code delta
- Passing test command
- Broader validation command

Do not use placeholders such as `TBD`, `TODO`, `implement logic`, or
`rest of file`.

For existing files, include enough context for safe editing:

- Function/class/module name
- Nearby integration point
- Expected behavior change
- Any compatibility constraints

## Step 10: Testing And Quality Gates

Use the testing pyramid as a planning default:

- Unit tests for logic and utilities
- Integration tests for API/data/service boundaries
- End-to-end tests only for critical user journeys

Each phase Definition of Done must include:

- Tests exist for new behavior
- New tests pass
- Existing tests pass
- Linter passes
- Formatter check passes
- Type/build check passes
- No new warnings introduced
- Plan and build logs can be updated by Build
- Phase changes can be committed and pushed

List exact validation commands. Prefer repository-native commands over generic
commands.

## Step 11: Design+Plan Confidence

Read `CONFIDENCE-RUBRIC.md` and score Design+Plan Confidence after drafting the
plan.

If `<95%`:

- State that Autobuild is unavailable below threshold.
- List the confidence gaps.
- Keep the plan in gated mode.

If `>=95%` and no hard-fails:

- Ask exactly: `Confidence is X%. Do you want to run in autobuild mode?`

## Step 12: Plan Review

Before asking for approval, review `plan.md` for:

- Unresolved placeholders
- Missing commands
- Missing tests
- Ambiguous tasks
- Overlarge phases
- Missing dependencies
- Unsafe parallelization
- Uncommittable or untestable tasks
- Plan/build handoff gaps

If issues exist, fix the plan before user review.

## Plan Completion Output

After writing `plan.md`, summarize:

- Plan path
- Phase count and total estimate
- Parallel phase groups
- Bootstrap/refactor phases, if any
- Design+Plan Confidence
- Autobuild availability
- Known risks

Then ask the user to review and approve the plan.

Do not start the branch/commit/push gate until the user approves `plan.md`.
