---
name: otto
description: Unified agentic coding workflow that combines brainstorming, superplan, and superbuild into a single sequential pipeline. Use when starting any significant coding task — it explores intent and designs a solution (brainstorming), creates a detailed multi-phase implementation plan (superplan), and executes it phase-by-phase with strict TDD enforcement and quality gates (superbuild). Triggers on "build something new", "implement a feature", "otto this", or any request that needs full design-through-execution workflow.
metadata:
  version: 1.0.0
  author: asteroid-belt
  generated-at: 2025-04-19
compatibility: Works with any codebase. Internet access used for best practices research during superplan's RESEARCH phase (bypassed if CLAUDE.md/AGENTS.md provides complete tech stack).
---

# Otto: Brainstorm → Superplan → Superbuild

Otto is a unified, three-phase agentic coding pipeline that combines three proven skills into one seamless workflow:

1. **Brainstorming** — collaborative design exploration and spec creation
2. **Superplan** — detailed multi-phase implementation planning with poker estimates and TDD acceptance criteria
3. **Superbuild** — strict phase-by-phase execution with TDD enforcement, quality gates, and conventional commits

The output of each phase is a durable artifact (design doc → plan doc → build doc). Every phase's output feeds the next automatically.

---

## Core Workflow

```
OTTO PIPELINE

┌─────────────────────────────────────────────────────┐
│  PHASE 1: BRAINSTORM                                 │
│  Explore intent → Design → Approved design doc       │
│  Output: .agents/tasks/<YYYY-mm-dd>-<feature>/design.md
└──────────────────────┬──────────────────────────────┘
                       │ design doc
                       ▼
┌─────────────────────────────────────────────────────┐
│  PHASE 2: SUPERPLAN                                  │
│  INTAKE → DETECT → INTERVIEW → RESEARCH → EXPLORE   │
│  → ARCHITECT → PHASE → DETAIL → TEST → DOCUMENT     │
│  Output: .agents/tasks/<YYYY-mm-dd>-<feature>/plan.md
└──────────────────────┬──────────────────────────────┘
                       │ plan doc
                       ▼
┌─────────────────────────────────────────────────────┐
│  PHASE 3: SUPERBUILD                                 │
│  INGEST → READ → EXECUTE PHASE → ENFORCE DOD       │
│  → UPDATE PLAN → COMMIT → FUNCTIONAL TEST          │
│  Output: .agents/tasks/<YYYY-mm-dd>-<feature>/build.md
└─────────────────────────────────────────────────────┘
```

---

## Phase 1: Brainstorming

**Goal:** Turn a rough idea into a validated, approved design document.

### When Otto Starts
> "I'm using the **otto** skill — a unified pipeline that combines brainstorming, planning, and execution. We'll go through three phases: first I'll help you design the solution, then I'll create a detailed implementation plan, then I'll execute it phase-by-phase with full TDD enforcement. Let's start with **Phase 1: Brainstorming**."

### Step 1: Explore Project Context
Check the current project state (files, docs, recent commits). Understand the existing structure and patterns before asking design questions.

### Step 2: Assess Scope
If the request describes multiple independent subsystems (e.g., "build a platform with chat, file storage, billing, and analytics"), flag this immediately. Help the user decompose into sub-projects first — each sub-project gets its own otto run.

### Step 3: Offer Visual Companion (if applicable)
If the topic involves visual questions (mockups, layouts, UI decisions), offer the visual companion as its own message:
> "Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, and visual comparisons as we go. This feature is still new and can be token-intensive. Want to try it?"

Wait for response before continuing. Per-question decision — even if accepted, decide individually whether each question needs the browser.

### Step 4: Ask Clarifying Questions
Ask **one question at a time**. Prefer multiple choice when possible.

Required questions to cover:
- What is the purpose? Who is the user?
- What constraints exist (tech stack, deadlines, team size)?
- What does success look like? How will we know it's done?
- What is explicitly OUT of scope?
- What can be deferred to v2?

### Step 5: Propose 2-3 Approaches
Present approaches conversationally with trade-offs. Lead with your recommendation and explain why.

### Step 6: Present the Design
Scale each section to its complexity. Cover: architecture, components, data flow, error handling, testing. Get user approval after each section before moving on.

### Step 7: Write the Design Document
Save to `.agents/tasks/<YYYY-mm-dd>-<feature>/design.md` (user preferences override this path).

Include:
- **Goal** — one sentence
- **Architecture** — 2-3 sentences
- **Tech Stack** — key technologies
- **Components** — what is being built
- **Data Flow** — how data moves through the system
- **Error Handling** — how errors are caught and reported
- **Testing** — how each component is tested

Commit the design document to git.

### Step 8: Spec Self-Review
Look at the written spec with fresh eyes:
1. **Placeholder scan** — any "TBD", "TODO", vague requirements? Fix them.
2. **Internal consistency** — do sections contradict each other?
3. **Scope check** — is this focused enough for a single plan?
4. **Ambiguity check** — could any requirement be interpreted two ways? Pick one and make it explicit.

Fix issues inline. No re-review needed.

### Step 9: User Review Gate
> "Spec written and committed to `<path>`. Please review it and let me know if you'd like to make any changes before we start the implementation plan."

Wait for user response. If changes requested, make them and re-run the review loop. Only proceed once approved.

### Step 10: Transition to Superplan
> "Design approved. Transitioning to **Phase 2: Superplan** — I'll now create a detailed multi-phase implementation plan from your design doc."

---

## Phase 2: Superplan

**Goal:** Create a detailed, executable, multi-phase implementation plan with poker estimates, TDD acceptance criteria, and quality gates.

### Step 1: Intake
Read the design doc created in Phase 1. Extract requirements, architecture decisions, and tech stack.

### Step 2: Detect Tech Stack
Check `CLAUDE.md` or `AGENTS.md` for complete tech stack. If complete, **bypass** the RESEARCH phase. If not found or incomplete, proceed to Step 4 (Research).

### Step 3: Interview (if needed)
If the design doc didn't fully cover requirements, ask 3-5 clarifying questions:
1. What is the MVP? What can we defer to v2?
2. What is explicitly out of scope?
3. Are there performance or security requirements?
4. What test coverage is expected?

Wait for answers before proceeding.

### Step 4: Research (if needed)
If tech stack was not detected from CLAUDE.md/AGENTS.md, launch parallel web searches:
- `[language] [framework] best practices`
- `[framework] [vX.X] patterns`
- `[framework] security guidelines`

### Step 5: Explore Codebase
Launch 3 parallel explore agents:
1. **Pattern Discovery** — find similar implementations in the codebase
2. **Integration Points** — identify files that need modification
3. **Technical Debt Scan** — check for issues in affected areas

### Step 6: Refactor Assessment
Evaluate if refactoring should precede feature work:

| Level | Description | Action |
|---|---|---|
| LOW | Code is clean | Proceed to Architect |
| MEDIUM | Some smells | Note debt, ask user preference |
| HIGH | Significant issues | Recommend refactor phases |
| CRITICAL | Major rewrite needed | Propose Mikado/Strangler Fig |

If HIGH or CRITICAL, ask permission to add refactoring phases.

### Step 7: Architect
For each component, document:
- What new components are being added
- How they connect to existing components
- What is the data flow

Required outputs:
- System context diagram
- API design (if applicable) with all response codes
- Data model (if applicable) with migration scripts
- Component tree (if UI)

### Step 8: Phase Breakdown
Break work into phases that can be executed in parallel where possible.

**Phase Design Principles:**
1. **Independence** — phases executable without waiting for others
2. **Testability** — each phase independently testable
3. **Estimated Size** — target 3-8 poker points per phase
4. **Quality Gated** — each phase includes Definition of Done
5. **Context Managed** — each phase ends with a CHECKPOINT for compaction

**Poker Planning Estimates:**

| Size | Meaning | Example |
|---|---|---|
| 1 | Trivial | Config value, typo fix |
| 2 | Small | Single file, simple function |
| 3 | Medium | Multi-file, new component |
| 5 | Large | Feature module, API endpoint |
| 8 | X-Large | Complex feature with dependencies |
| 13 | Epic chunk | Major subsystem change |
| 21 | Too big | **Split into smaller tasks** |

### Step 9: Detail — TDD Micro-Structure Per Task
Each phase task uses a **5-step TDD micro-structure** (borrowed from writing-plans):

For each task in each phase:
1. **Write test** (spec) — show the actual test code
2. **Run test, verify failure** — show the exact command and expected failure output
3. **Write minimal implementation** — show the actual code
4. **Run test, verify pass** — show the exact command and expected pass output
5. **Commit** — conventional commit format

**No placeholders allowed.** Every step must show actual code, actual commands, actual expected outputs.

### Step 10: Document — Write Plan File
Write the plan to `.agents/tasks/<YYYY-mm-dd>-<feature>/plan.md`

Plan document must include:
- **Plan Status:** Execute this plan using `otto` skill (superbuild phase).
- **Design Doc Reference:** Link back to the originating design doc.
- **Phase list** with poker estimates, dependencies, and Definition of Done.
- **CHECKPOINT** at end of each phase: `- [ ] CHECKPOINT: Run /compact focus on: [Phase N] complete, [key artifacts], [Phase N+1] goals`
- **TDD Micro-Structure** for every task in every phase.

Commit the plan document.

### Step 11: Transition to Superbuild
> "Plan complete and saved to `.agents/tasks/<YYYY-mm-dd>-<feature>/plan.md`. Transitioning to **Phase 3: Superbuild** — I'll now execute each phase with strict TDD enforcement and quality gates."

---

## Phase 3: Superbuild

**Goal:** Execute the implementation plan phase-by-phase with strict TDD enforcement, quality gates, and conventional commit generation.

### Step 1: Ingest Plan
Confirm the plan document is present and readable. Parse all phases, estimates, and dependencies.

### Step 2: Read All Phases
Outline all phases with estimates and dependencies. Check context usage — if high, suggest compacting before continuing.

Present the phase map:
```
PLAN LOADED: <Feature Name>

[ ] Phase 1: <Name> | <Estimate> | <Dependencies>
[ ] Phase 2: <Name> | <Estimate> | <Dependencies>
...

Total: <N> phases | Total Est: <N> hrs
Ready to execute Phase 01
```

### Step 3: Critical Plan Review
Before executing, verify:
1. **Ambiguity** — are any tasks unclear?
2. **Missing dependencies** — are required tools/files/packages identified?
3. **Test gaps** — does each task have explicit acceptance criteria?
4. **Risky changes** — any destructive or breaking changes?

If concerns exist, pause and resolve before executing.

### Step 4: Execute Phase

For **each phase** (one at a time, no skipping):

#### Sequential Tasks
Execute one task at a time following the TDD micro-structure:
1. Write the failing test
2. Run test, **verify it fails** (mandatory — must see RED)
3. Write minimal implementation
4. Run test, **verify it passes** (mandatory — must see GREEN)
5. Stage and commit

**TDD Enforcement Rules:**

| Rule | Enforcement |
|---|---|
| Test before code | **STOP** if implementation exists without test |
| Verify RED | **STOP** if test passes immediately (testing existing behavior) |
| Minimal code | **STOP** if coding features beyond current task |
| Verify GREEN | **STOP** if test fails after implementation |
| No regressions | **STOP** if other tests start failing |

If test passes immediately → the test is wrong. Stop and fix.
If you cannot explain why the test failed → you don't understand the requirement. Stop and clarify.

#### Parallel Tasks
For phases marked "Parallel With", use sub-agents or parallel task calls. Each sub-agent must return: implementation details, DoD status (Lint/Test), proposed commit message.

**Sub-agent result verification — CRITICAL:**
DO NOT trust sub-agent claims without independent verification.
- Run `ls` to confirm files exist
- Run `cat` to verify content
- Verify plan file was updated
Only after independent verification, collect commit messages.

### Step 5: Enforce Definition of Done
EVERY phase must pass ALL quality gates before completion.

The Verification Gate (run for EVERY check):
1. **IDENTIFY** — which command proves this claim?
2. **RUN** — execute the command NOW
3. **READ** — parse output for errors/success
4. **VERIFY** — does output match the claim?
5. **THEN CLAIM** — only state success after steps 1-4

**Invalid evidence:**
- Previous run output from more than 2 minutes ago
- "I remember the tests passed earlier"
- "Probably works" / "should pass" / "seems fine"
- Sub-agent reports without independent verification

**Red Flag Language — HALT immediately:**
- "should pass" → RUN the check
- "probably works" → RUN the check
- "I believe it passed" → RUN the check

### Step 6: Update Plan
Mark completed tasks and phases in the plan file:
```
- [x] Phase 1: Setup | 15m | DONE
- [x] Task 1.1: Create config | 5m | DONE
```

### Step 7: Generate Commit Message
Generate a conventional commit for each completed task:
```
<type>: <short description>

<optional body with context>
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

Run `git commit` with the generated message. **Never run git without a message.**

### Step 8: Functional Test
Prove the implementation works to the user. Offer integration test scripts or manual verification steps.

### Step 9: Stop — Wait for User
After each phase completion:
> "Phase <N> complete. All quality gates passed. Commit(s) generated. Ready for your review — would you like me to continue to the next phase?"

**Wait for user response.** Only proceed with user approval.

Exception: If in **BUILD-ALL mode** (user explicitly requested continuous execution), parse the CHECKPOINT and auto-compact, then proceed to next phase.

### Step 10: Write Build Documentation
After each phase, append to `.agents/tasks/<YYYY-mm-dd>-<feature>/build.md`:
- Phase completed and timestamp
- Quality gate results (actual command output)
- Commit messages generated
- Any issues encountered and resolutions

---

### File Paths
All three generated files live together in one directory:
```
.agents/tasks/<YYYY-mm-dd>-<feature-short-name>/
├── design.md   # Phase 1 output
├── plan.md     # Phase 2 output
└── build.md   # Phase 3 output
```

Example:
```
.agents/tasks/2025-04-19-user-auth/
├── design.md
├── plan.md
└── build.md
```

User preferences for the base path override this default.

### CHECKPOINT Protocol
Every phase in the plan MUST end with:
```
- [ ] **CHECKPOINT:** Compact context before Phase N+1
```

CHECKPOINT enables:
- Context compaction between phases
- Seamless resume after breaks
- BUILD-ALL auto-compaction

### Context Management
- Before Phase 2 (Superplan): summarize Phase 1 outcome in 3-5 sentences
- Before Phase 3 (Superbuild): summarize Phase 1+2 outcome in 3-5 sentences
- Between phases in Superbuild: use CHECKPOINT for context compaction

### Otto Exit States

| State | Condition | Action |
|---|---|---|
| Design rejected | User rejects spec | Iterate on design, re-run Phase 1 |
| Plan rejected | User rejects plan | Iterate on plan, re-run Phase 2 |
| Plan concerns | Ambiguous tasks, missing deps | Pause, resolve, then proceed |
| Quality gate fail | Lint/test/format fails | Fix, re-run gate, don't skip |
| Phase complete | All tasks done, all gates pass | Stop, await user approval |
| Build complete | All phases done | Summarize, offer code review |

### What Otto Does NOT Do
- **Does not skip phases** — even "simple" tasks go through full pipeline
- **Does not bypass quality gates** — no TDD enforcement exceptions
- **Does not trust claims without evidence** — always verify independently
- **Does not write placeholder code** — no TODOs, TBDs, or vague steps
- **Does not proceed without user approval** — after design, after plan, after each phase

---

## Key Principles

- **YAGNI ruthlessly** — remove unnecessary features from all designs
- **One question at a time** — don't overwhelm with multiple questions
- **Multiple choice preferred** — easier for users to answer
- **Incremental validation** — present design, get approval, then proceed
- **TDD or nothing** — no implementation without failing tests first
- **Evidence over memory** — always run verification commands fresh
- **Complete artifacts** — every phase produces a durable, reviewable document
