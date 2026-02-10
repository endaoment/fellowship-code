# Team Handoff Protocol

Standard I/O contracts for all Fellowship workers. Every worker receives a mission prompt and returns a handoff report in this format.

---

## Worker Input (Mission Prompt)

Gandalf constructs this for each worker:

```markdown
You are {Character}, the {Role} of the Fellowship engineering team.
Read your full identity and constraints from: .claude/agents/{agent-file}.md

## Your Mission

{1-3 paragraphs describing the specific task}
{Clear, measurable completion criteria}

## Context

- Working directory: {repo path}
- Branch: {branch name or "create feature/XXXX-description from main"}
- Relevant files: {list of key files to read}
- Current state: {what's been done so far, dependencies}
- Spec: {link to spec if applicable}
- Issues: {issue URLs if applicable}

## Constraints

- {Phase-specific constraints from the skill}
- {Repo-specific constraints}
- {Task-specific constraints}

## Done When

- {Explicit criterion 1}
- {Explicit criterion 2}
- {Explicit criterion 3}

## Handoff

When complete, return your handoff report in the format below.
```

---

## Worker Output (Handoff Report)

Every worker returns this structured report to Gandalf:

```markdown
## Result

- **Action**: {What was done — 1 sentence}
- **Artifacts**: {Files changed, PRs created, tests written, branches pushed}
- **Status**: {complete | partial | blocked | failed}

## Context

- {Key findings during the task}
- {Patterns discovered or leveraged}
- {Decisions made and why}
- {Dependencies on other workers' output}

## Concerns

- {Anything unexpected or deviating from the plan}
- {Potential issues Gandalf should know about}
- {Technical debt introduced intentionally}

## Feedback

- {Suggestions for Gandalf}
- {Work that should happen next}
- {Other workers who need to coordinate}
- {Spec gaps or ambiguities discovered}
```

---

## Report Field Guidelines

### Status Values

| Status     | Meaning                             | Planner Action                                    |
| ---------- | ----------------------------------- | ------------------------------------------------- |
| `complete` | Task fully done, all criteria met   | Gandalf moves to next task                        |
| `partial`  | Some criteria met, others remain    | Gandalf spawns follow-up or different worker      |
| `blocked`  | Cannot proceed — missing dependency | Gandalf resolves dependency, then retries         |
| `failed`   | Task failed after best effort       | Gandalf retries once with Aragorn, then escalates |

### Artifacts Format

List artifacts with enough detail for Gandalf to verify:

```markdown
- **Artifacts**:
  - Modified: `src/services/feature.ts` (added new endpoint)
  - Created: `src/services/feature.spec.ts` (3 test cases)
  - Branch: `feature/1234-add-feature` pushed to origin
  - PR: https://github.com/{org}/{repo}/pull/1234
  - CI: passing / failing (link)
```

### Concerns Severity

Workers should flag concerns by severity:

- **Blocker**: "This cannot ship without fixing X" — planner must address before phase completes
- **Warning**: "This works but Y is fragile" — planner should consider addressing
- **Note**: "FYI, Z pattern exists here" — informational, no action needed

---

## Protocol Rules

1. **Workers never communicate with each other** — all coordination goes through Gandalf.
2. **Workers don't update project tracking** — Gandalf handles all tracking updates via the PM agent.
3. **Workers don't send notifications** — Gandalf handles communication.
4. **Workers create branches and push code** — but Gandalf creates PRs and tags reviewers.
5. **Reports must be honest** — if a task is partial or failed, say so. Gandalf will handle it.
