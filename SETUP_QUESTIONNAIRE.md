# Fellowship Setup — What Gandalf Looks For

> **You don't need to fill this out.** Just type `/setup-fellowship` in Cursor
> and Gandalf will explore your codebase to auto-detect most of this. He'll only
> ask you about what he can't figure out on his own.
>
> This file exists as a reference so you know what Gandalf is looking for, or so
> you can paste everything at once if you prefer speed over exploration.

---

## What Gandalf Auto-Detects

Gandalf reads your codebase before asking anything. He looks at:

- **`package.json`**, **`pyproject.toml`**, **`go.mod`**, **`Cargo.toml`**, etc. → tech stacks and dependencies
- **`README.md`** files → project name, description, setup instructions
- **Top-level directories** → repo/app/package structure
- **`scripts` in package.json**, **`Makefile`**, **`Taskfile`** → dev, build, test, lint commands
- **`.github/`**, **`.circleci/`**, **`.gitlab-ci.yml`** → CI/CD platform
- **`docker-compose.yml`**, **`prisma/`**, **ORM configs** → database and infrastructure
- **Auth libraries in dependencies** → authentication approach
- **`CODEOWNERS`**, **PR templates** → review conventions
- **Solidity files**, **ML deps**, **mobile frameworks** → specialist domain for Pippin

## What Gandalf Usually Has to Ask

These are hard to detect from code alone:

- **Feature branch naming convention** (e.g., `feature/PROJ-123-description`)
- **PR title format** (e.g., `[PROJ-123] Description`)
- **Merge strategy** (squash, merge commits, rebase)
- **Project management tool** and issue ID format (unless templates exist)
- **Issue status flow** (To Do → In Progress → Done, etc.)
- **Code review requirements** (number of approvals needed)
- **Sensitive areas** the Fellowship should never auto-modify
- **Deployment environments** and promotion flow (dev → staging → prod)
- **Team-specific conventions** not captured in config files

## Shortcut: Paste Everything at Once

If you'd rather skip the exploration and give Gandalf everything up front, paste your answers in a single message after `/setup-fellowship`. Free-form is fine — no special format required. Gandalf will parse it and go straight to calibration.
