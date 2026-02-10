# Phase Artifacts

What each Fellowship phase produces, where artifacts live, and how phases connect.

---

## Artifact Map

| Phase       | Command               | Primary Artifacts                           | Location                        |
| ----------- | --------------------- | ------------------------------------------- | ------------------------------- |
| Spec & Plan | `/spec-and-plan`      | Technical spec, tracking issues, Spec PR    | Specs directory, issue tracker  |
| Build       | `/build-full-stack`   | Code PRs (per repo), updated issues         | Target repo branches, GitHub PRs|
| QA & Polish | `/qa-and-polish`      | Proof comments, clean PRs, CI green         | GitHub PR comments              |
| Code Review | `/code-review`        | Review comments, addressed feedback         | GitHub PR comments              |
| Deploy      | `/deploy-and-release` | RC PRs, release notes, deployment artifacts | GitHub, issue tracker           |

---

## Phase Flow

```text
/spec-and-plan
    Output: Spec + Tracking Issues
    Human checkpoint: Code owners review spec
        |
        v
/build-full-stack
    Input: Spec + Issues
    Output: PRs per repo (CI passing)
    Human checkpoint: Code owners review PRs
        |
        v
/qa-and-polish
    Input: PR URLs
    Output: Verified, clean, review-ready PRs
    Human checkpoint: Final reviewer approval
        |
        v
/code-review (optional, can run anytime)
    Input: PR URLs
    Output: Self-review + addressed feedback
        |
        v
/deploy-and-release
    Input: Merged PRs
    Output: Production deployment
    Human checkpoint: QA approval, pipeline approval
```

---

## Spec Artifacts

Specs follow a structured layout (customize for your project):

```text
specs/{feature}/
├── README.md          # Overview, goals, links
├── backend.md         # API changes, services, entities, migrations
├── frontend.md        # Components, flows, state
├── specialist.md      # Domain-specific changes (if applicable)
├── user-stories.md    # User and admin stories
└── glossary.md        # Domain terms
```

Only create files for affected areas. Skip `specialist.md` if no domain-specific changes.

## Tracking Artifacts

| Phase       | Tracking Action                                               |
| ----------- | ------------------------------------------------------------- |
| Spec & Plan | Create issues (linked to spec, assigned, in current milestone)|
| Build       | Transition issues: NEW → In progress → Review Ready           |
| QA & Polish | Mark review-ready, notify reviewers                           |
| Deploy      | Create QA issue for RC, update on completion                  |

## Scratchpad Artifacts

During execution, Gandalf maintains `{feature}-scratchpad.md` in the working directory. This is ephemeral -- deleted when the phase completes. Not committed to any repo.

## PR Conventions

| Field       | Format                                           |
| ----------- | ------------------------------------------------ |
| Branch      | `feature/XXXX-short-description`                 |
| Title       | `[XXXX] Description`                             |
| Body        | Links to tracking issues, summary of changes     |
| Reviewers   | Code owners for the affected repo                |
| Base branch | Your project's default branch (main or develop)  |
