# AI Agent Skills Guide
> Scope: Repository root (applies to every directory unless a nested AGENTS.md overrides it)

## Quick Facts
- **Primary languages:** Markdown, Bash
- **Package manager:** Homebrew via `Brewfile` (`stow`, `claude-code`, `codex`)
- **Task runner:** `just` (preferred). Deployment helpers live in `scripts/`
- **Skill bundles:** `agent-context-generator`, `bash-script-generator`, `implementation-plan-creator`
- **Key automation:** `tree --gitignore -a -L 3` for structure snapshots, GNU stow for skill deployment
- **CI/CD:** Not configured in-repo; rely on local validation before opening PRs

## Repository Tour
```text
.
├── AGENTS.md             # Project-wide context (this file)
├── Brewfile              # Homebrew bundle for stow, claude-code, codex
├── Justfile              # install/sync/unsync/status recipes
├── README.md             # Project overview and active skill catalog
├── scripts/              # Shell helpers for deploying skills
│   ├── sync.sh
│   ├── unsync.sh
│   └── status.sh
├── skills/               # Individual skill bundles (SKILL.md, references, scripts)
│   ├── agent-context-generator/
│   ├── bash-script-generator/
│   └── implementation-plan-creator/
```
- `.git/` and other VCS artifacts omitted for clarity.
- Skill bundles:
  - `skills/agent-context-generator/` — Generates project-level AGENTS.md context with tree snapshots and follow-up checklists.
  - `skills/bash-script-generator/` — Produces Bash 3.2 scripts with `check_requirements` guardrails and optional `shfmt` formatting.
  - `skills/implementation-plan-creator/` — Guides feature planning with multi-phase implementation plans.
- Regenerate this snapshot after structural changes with `tree --gitignore -a -L 3`.

## Tooling & Setup
- **System requirements:** macOS or Linux with Homebrew installed (`brew --version`).
- **Install dependencies:** `just install` (installs `stow`, `claude-code`, `codex`).
- **Skill deployment:** `just sync` symlinks `skills/` into `~/.claude/skills` and `~/.codex/skills` via GNU stow.
- **Secrets/config:** No secrets tracked here. Downstream skills should document their own environment variables.
- **CLI permissions:** `.claude/settings.local.json` enumerates whitelisted shell commands for Claude/Codex; extend it if new automation is required.
- **Tree utility:** Prefer `tree` ≥ 2.0 for `--gitignore`. If unavailable, install with `brew install tree` or prune ignored paths manually.

## Common Tasks
- `just install` — Install Homebrew dependencies from `Brewfile`.
- `just sync` — Symlink all skills into Claude/Codex directories (idempotent).
- `just unsync` — Remove stowed skills from local tool directories.
- `just status` — Display which skills are currently symlinked and their targets.
- `tree --gitignore -a -L 3` — Capture an up-to-date repository snapshot for documentation.
- `./scripts/sync.sh` / `unsync.sh` / `status.sh` — Invoke deployment helpers directly when custom targets or verbose output are needed.

## Testing & Quality Gates
- No automated tests bundled yet. Validate changes by:
  - Reviewing updated `SKILL.md` files for complete phases, decision points, and checklists.
  - Running `bash -n` and spot functional checks on any shell scripts.
  - Loading skills inside Claude Code or Codex (`/skill-name`) to confirm rendering and instructions.
- If you add linters, formatters, or packaging scripts, record the canonical commands here and in the README.

## Workflow Expectations
- Work on short-lived feature branches; rebase onto the latest main before opening PRs.
- Scope commits to a single skill or documentation change, using conventional commit prefixes (`feat`, `fix`, `docs`, etc.).
- Request review from the repository maintainer (`tjmaynes`) before merging.
- Ensure new skills include MIT license files, accurate metadata, and the established multi-phase structure.
- When conventions seem ambiguous, ask the maintainer:
  - “Who owns this directory or workflow?”
  - “Is there a preferred naming pattern for new skills?”
  - “Should this change trigger external documentation or tooling updates?”

## Documentation Duties
- Update `README.md` whenever:
  - New skills are added or existing ones materially change behavior.
  - Installation or deployment instructions evolve.
  - Dependencies in `Brewfile` change.
- Refresh this AGENTS guide whenever workflows, automation, or scope expectations shift; add nested AGENTS files for subdirectories with unique rules.
- Document any new automation commands both here and in the README’s Quick Start section.
- Maintain per-skill documentation inside each skill directory (e.g., `references/`, `scripts/`).
- Regenerate and embed a trimmed `tree --gitignore` snapshot whenever the repository layout changes.

## Finish the Task Checklist
- [ ] Update relevant docs (including `README.md`) when behavior or setup changes significantly.
- [ ] Regenerate the `tree --gitignore -a -L 3` snapshot if the structure changed.
- [ ] Summarize your work using a conventional commit message (`type: short summary`).

## Open Questions for Maintainers
- Should automated validation (linting or packaging) run before syncing skills? If yes, document the command here.
- Is there a preferred naming convention or metadata schema for new skills beyond the current examples?
- Are there environments beyond macOS/Linux that require official support steps or alternative tooling?
