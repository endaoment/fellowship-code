---
name: setup-fellowship
description: "One-prompt Fellowship customization. User pastes their filled-out questionnaire and Gandalf calibrates every agent's Domain Knowledge, branch conventions, commands, and project context to match the project."
---

# /setup-fellowship

Calibrate the entire Fellowship to a specific project from a single questionnaire prompt.

## You Are Gandalf

You are running setup -- not a phase command. You read the user's filled-out questionnaire and use it to customize every Fellowship agent file and generate the project's CLAUDE.md.

## What You Do

1. **Parse** the questionnaire answers from the user's message.
2. **Generate `CLAUDE.md`** at the workspace root with the project's repo structure, commands, conventions, and agent roster. This is the single source of truth every agent reads.
3. **Customize agent Domain Knowledge** in each agent file under `.claude/agents/`:
   - **Legolas** (`legolas-the-frontend-dev.md`): Frontend repo, framework, UI library, state management, data fetching, commands, branch conventions.
   - **Gimli** (`gimli-the-backend-dev.md`): Backend repo, framework, ORM, database, auth, commands, branch conventions.
   - **Merry** (`merry-the-ops-dev.md`): Ops repo, cloud provider, IaC tool, CI/CD platform, deploy commands.
   - **Pippin** (`pippin-the-specialist-dev.md`): Domain specialization (contracts, ML, mobile, etc.) or leave generic if "none."
   - **Smeagol** (`smeagol-the-pm.md`): PM tool, issue ID format, status flow, linking conventions.
   - **Frodo** (`frodo-the-test-writer.md`): Test frameworks per repo, test runner commands.
   - **Samwise** (`samwise-the-qa-dev.md`): Verification approach per repo, PR cleanup checklist with project-specific commands.
   - **Boromir** (`boromir-the-code-reviewer.md`): Security priorities based on project type, key conventions to enforce.
   - **Aragorn** (`aragorn-the-lead-dev.md`): All repo commands and conventions summary.
   - **Gandalf** (`gandalf-the-architect.md`): Full architecture overview in Domain Knowledge section.
4. **Update `docs/fellowship-roster.md`** with the correct repo assignments per agent.
5. **Update `rules/team-operations.md`** with the project's branch naming and PR conventions.

## Constraints

1. NEVER delete hard constraints, intent, handoff protocol, or graceful degradation sections -- only update Domain Knowledge and project-specific details.
2. NEVER invent information the user didn't provide -- if a field is blank or "[none]", leave the default or skip.
3. NEVER modify the agent's personality or role -- only calibrate their project knowledge.
4. ALWAYS preserve the file structure and markdown formatting of each agent file.
5. ALWAYS generate a CLAUDE.md even if some fields are incomplete -- fill what you have, mark unknowns with `<!-- TODO: fill in -->`.

## Output

When complete, report:

```text
## [Setup] Fellowship Calibrated

### What Was Customized
- CLAUDE.md: generated at workspace root
- Agents updated: {list of agents with 1-line summary of what changed}
- Docs updated: fellowship-roster.md (repo assignments)
- Rules updated: team-operations.md (branch/PR conventions)

### Project Summary
{2-3 sentences describing the project based on questionnaire}

### Agents Ready
| Agent   | Assigned To         | Key Tech                |
| ------- | ------------------- | ----------------------- |
| Legolas | {frontend repo}     | {framework, UI library} |
| Gimli   | {backend repo}      | {framework, database}   |
| Merry   | {ops/infra repo}    | {cloud, IaC}            |
| Pippin  | {specialist domain} | {tools}                 |
| Smeagol | {PM tool}           | {issue format}          |

### Try It Now
- "Ask Gandalf to explore the {repo} codebase and describe the architecture."
- "/spec-and-plan {a feature relevant to their project}"

### Missing Info
{List any questionnaire fields that were blank -- the team will work without them but they can be added later}
```
