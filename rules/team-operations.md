# Team Operations

Active rule during any Fellowship team command execution. Governs error tolerance, failure handling, and coordination patterns.

## When This Rule Applies

This rule is active whenever a Fellowship phase command is running:
`/spec-and-plan`, `/build-full-stack`, `/qa-and-polish`, `/code-review`, `/deploy-and-release`

---

## Error Tolerance by Context

| Context               | Tolerance                                                                      | Rationale                                                  |
| --------------------- | ------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| Security-critical code| **Strict** — all tests must pass, no lint errors                               | Security errors are costly and hard to fix after deployment|
| Backend / API code    | **Phase-dependent** — strict during QA, moderate during build                  | API stability matters but can iterate                      |
| Frontend / UI code    | **Phase-dependent** — strict during QA, moderate during build                  | UI can iterate; visual bugs less critical than logic bugs  |
| Infrastructure / Ops  | **Moderate** — tests pass, lint clean, but accept infrastructure turbulence    | Infrastructure can usually be re-deployed quickly          |
| Specs / Documentation | **Loose** — content quality over formatting perfection                         | Specs are reviewed by humans anyway                        |

## Worker Failure Handling

1. **First failure**: Retry the same task with the same worker, adding the failure context to the prompt.
2. **Second failure**: Reassign to Aragorn (full-stack lead) with all prior context and failure reports.
3. **Third failure**: Escalate to the human. Post a summary of what was attempted and what failed.

## Scratchpad Conventions

- File name: `{feature-name}-scratchpad.md` in the working directory
- **Rewrite every cycle** — never append. The scratchpad is working memory, not a log.
- Maximum length: 100 lines. If longer, you're tracking too much — summarize.
- Delete the scratchpad when the phase completes.

## Issue Management

During team operations, update tracking issues as work progresses:

| Event                     | Status Transition               | Method   |
| ------------------------- | ------------------------------- | -------- |
| Work starts on an issue   | `NEW` → `In progress`          | PM agent |
| PR created for an issue   | `In progress` → `Review Ready` | PM agent |
| All PR comments addressed | Keep `Review Ready`             | (no change) |
| PR merged                 | `Review Ready` → `Done`        | PM agent |
| Work blocked              | Add blocker comment             | PM agent |

## Branch Naming

Workers must follow the project's branch naming conventions. Recommended defaults:

- Features: `feature/XXXX-short-description`
- Hotfixes: `hotfix/descriptive-name`
- Workers always branch from the repo's base branch (`main` or `develop`)

## PR Conventions

- Title format: `[XXXX] Description` (matching the tracking issue)
- Tag code owners as reviewers (see CLAUDE.md for repo-to-codeowner mapping)
- Include the issue link in the PR description
- Workers push branches; **Gandalf** creates PRs and tags reviewers

## Human Checkpoints

Gandalf must pause and wait for human input at these points:

- After spec review is requested (code owners must approve specs)
- Before merging any PR to a protected branch
- Before any production deployment
- When a task fails 3 consecutive times
- When Gandalf discovers a scope change that exceeds the original goal

## Communication

- Gandalf reports progress to the user in the main conversation
- Workers do not communicate with the user directly
- All notifications go through Gandalf
- Gandalf identifies itself with `[Gandalf]` prefix
- Workers identify themselves with `[Character Name]` prefix in their handoff reports
