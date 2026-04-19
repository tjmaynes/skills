# Otto Build Protocol

Use this protocol for Stage 3 after `design.md` and `plan.md` are approved,
committed, and pushed.

## Build Modes

Otto has two build modes:

1. Automated build mode
2. Manual phase-by-phase mode

Automated build mode is the default when Build Confidence is `>=90%`.
Manual phase-by-phase mode is required when Build Confidence is `<90%`, when
validation fails, or when the plan contains ambiguity that blocks safe execution.

Autobuild is only offered from the Design+Plan Confidence gate. Build Confidence
does not decide whether Autobuild is offered; it decides whether execution is
ready enough to proceed automatically.

## Build Flow

Run these steps in order.

1. Ingest plan
2. Read phase map
3. Run critical plan review
4. Re-score Build Confidence
5. Execute phase or parallel phase group
6. Enforce Definition of Done with fresh evidence
7. Update `plan.md`
8. Append `build.md`
9. Commit phase changes
10. Push branch
11. Continue or pause based on mode and validation state

## Step 1: Ingest Plan

Confirm that `plan.md` exists and is readable.

Required plan properties:

- Feature title or objective
- Phase overview
- Dependencies between phases
- Task checklist per phase
- Definition of Done per phase
- Validation commands per phase
- Checkpoint notes for context preservation

If `plan.md` is missing or structurally incomplete, stop Build and repair the
plan before executing.

## Step 2: Read Phase Map

Before edits, summarize all phases:

```text
PLAN LOADED: <feature>

| Phase | Name | Estimate | Depends On | Parallel With | Status |
|-------|------|----------|------------|---------------|--------|
| 1 | <name> | <points> | - | - | pending |
| 2A | <name> | <points> | 1 | 2B | pending |
```

Identify:

- First executable phase
- Parallel phase groups
- Blocked phases
- Current status from `plan.md`
- Validation commands required by each phase

## Step 3: Critical Plan Review

Review before any code change.

Block execution if any answer is "no":

- Is every task specific enough to execute?
- Are dependencies, files, commands, and tools identified?
- Does each code-changing task include a test-first path?
- Does each phase have a Definition of Done?
- Are risky/destructive operations explicitly called out?
- Is rollback or remediation obvious for risky changes?

Failure output:

```text
BUILD PAUSED - PLAN REVIEW FAILED

Issue:
- <specific blocker>

Required resolution:
- <question or repair needed>
```

## Step 4: Build Confidence

Read `CONFIDENCE-RUBRIC.md` and compute Build Confidence before build kickoff
and before each phase.

If Build Confidence is `<90%`:

- Do not run automated phase execution.
- Switch to manual phase-by-phase mode.
- Explain which categories lowered confidence.
- Ask only the clarification needed for the next phase.

If Build Confidence is `>=90%`, proceed.

## Step 5: Execute Phase

Execute phases in dependency order. Do not skip ahead.

### Sequential Phases

For a single phase:

1. Mark the phase `in progress` in `plan.md`.
2. Execute one task at a time.
3. Follow test-first order for every code task.
4. Keep changes inside the phase scope.

### Parallel Phase Groups

For independent phases marked parallel:

1. Confirm write scopes do not overlap.
2. Launch parallel work only for independent scopes.
3. Assign each worker a disjoint responsibility.
4. Require each worker to report changed files, tests run, failures, and proposed commit message.
5. Independently verify all worker claims before marking any phase complete.

Sub-agent or worker reports are claims, not evidence.

## Step 6: Test-First Enforcement

Every code-changing task must follow this order:

1. Write or update the failing test.
2. Run the test and verify the failure.
3. Implement the smallest change that can pass the test.
4. Run the test and verify the pass.
5. Run broader phase validation.

Stop if:

- Implementation appears before a test for new behavior.
- The test passes before implementation.
- The failing test output is not understood.
- The implementation expands beyond the current task.
- Regression tests fail.

If a phase cannot reasonably be test-first, the plan must explain why and must
define an alternate verification command before execution.

## Step 7: Definition of Done

A phase is not complete until every applicable item passes with fresh evidence.

Required checks:

- Tests exist for new behavior.
- New tests pass.
- Existing tests pass.
- Linter passes.
- Formatter check passes.
- Type checker or build command passes.
- No new warnings are introduced, when tools report warnings.
- `plan.md` has been updated for completed work.
- `build.md` has been appended with evidence.

Fresh evidence means the command was run during the current phase completion
step. Earlier output, memory, and worker claims do not count.

Use this verification loop for each claim:

1. Identify the command that proves the claim.
2. Run it.
3. Read the full output.
4. Confirm the output proves the claim.
5. Only then record the result.

Failure output:

```text
BUILD PAUSED - DEFINITION OF DONE FAILED

Phase: <phase>
Check: <tests|lint|format|types|build|plan update|build log>
Command: <command>
Result: failed

Relevant output:
<short failure excerpt>

Next action:
<specific fix or clarification needed>
```

## Step 8: Validation Commands

Prefer repository-native validation commands from `AGENTS.md`, `README.md`,
package scripts, Makefiles, Justfiles, or CI configuration.

Use `scripts/validate-phase.sh` when:

- The repository has no canonical validation command.
- The stack is one of `js`, `py`, `go`, or `rust`.
- The defaults are appropriate for the project.

Do not force the generic validator when the repository already defines better
commands.

## Step 9: Update Plan

After all quality gates pass and before committing:

1. Check off completed phase tasks.
2. Check off completed Definition of Done items.
3. Update phase status in the overview table.
4. Mark checkpoint complete if the phase is complete.
5. Verify the edited plan is internally consistent.

If plan updates fail, the phase is not complete.

## Step 10: Append Build Log

Append to `build.md` after each phase.

Required entry:

- Timestamp
- Phase name and status
- Build Confidence score
- Tasks completed
- Files changed
- Validation commands run
- Validation results
- Failures and resolutions
- Commit message
- Push result
- Next phase or stop reason

## Step 11: Commit And Push Phase

After `plan.md` and `build.md` are updated:

1. Review `git status --short`.
2. Stage only files owned by the completed phase plus `plan.md` and `build.md`.
3. Commit with a conventional commit message.
4. Push the branch.
5. Confirm remote branch update.

Do not stage unrelated user changes.

Commit message rules:

- Use `feat`, `fix`, `refactor`, `test`, `docs`, `build`, `ci`, or `chore`.
- Use imperative mood.
- Keep the subject under 72 characters.
- Avoid shell-unsafe characters when using `git commit -m`.

## Step 12: Execution Control

Automated build mode:

- Continue to the next eligible phase after successful validation, commit, and push.
- Pause on failed validation, ambiguity, missing dependency, merge conflict, or unsafe git state.
- Report the stop reason and exact next action.

Manual phase-by-phase mode:

- Stop after each phase.
- Provide phase summary and next recommended phase.
- Wait for explicit user instruction before continuing.

Context handling:

- Preserve progress in `plan.md` and `build.md`; do not rely on chat history.
- Use checkpoint notes to summarize what was completed and what comes next.

## Red Flags

Stop immediately if any of these appear:

- "should pass"
- "probably works"
- "seems fine"
- "I think it passed"
- "based on my changes"
- "the worker said it passed"
- "I ran this earlier"
- "this is too small to test"
- "I will update the plan later"
- "I will commit later"

Each phrase indicates missing evidence or skipped process.

## Completion Criteria

Build is complete when:

- Every phase is complete.
- Every Definition of Done item has fresh evidence.
- `plan.md` reflects final status.
- `build.md` contains a complete execution log.
- Phase commits are pushed.
- The user receives a final summary with risks and follow-up work.
