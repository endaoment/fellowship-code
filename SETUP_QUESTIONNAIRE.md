# Fellowship Setup Questionnaire

> **How to use:** Fill out this questionnaire, then paste it to Gandalf in Cursor.
> Gandalf will read your answers and customize every agent's Domain Knowledge
> section to match your project. One prompt, full team calibration.
>
> **Copy everything below the line, fill in your answers, and send it as your first message.**

---

```
/setup-fellowship

## My Project

**Project name**: [e.g., "Acme Platform"]
**One-line description**: [e.g., "B2B SaaS for invoice automation"]

## Repositories

List every repo the Fellowship will work in. For each one, provide the
directory name, what it contains, and the tech stack.

| Directory       | Purpose           | Tech Stack                          |
| --------------- | ----------------- | ----------------------------------- |
| [e.g., backend] | [e.g., API server]| [e.g., Django 5.0, DRF, PostgreSQL] |
| [e.g., frontend]| [e.g., Web app]   | [e.g., Next.js 14, React, Tailwind] |
| [e.g., infra]   | [e.g., IaC]       | [e.g., Terraform, AWS]              |
| [add more rows as needed]                                               |

## Commands

For each repo, what are the key commands? (dev, build, test, lint, migrate)

**[repo-1 name]**:
- Dev: [e.g., npm run dev]
- Build: [e.g., npm run build]
- Test: [e.g., npm run test]
- Lint: [e.g., npm run lint]
- Other: [e.g., npm run migrate]

**[repo-2 name]**:
- Dev: [e.g., python manage.py runserver]
- Build: [e.g., python manage.py collectstatic]
- Test: [e.g., python manage.py test]
- Lint: [e.g., ruff check .]
- Other: [e.g., python manage.py migrate]

[Copy this block for each repo]

## Git Workflow

- **Default branch**: [e.g., main]
- **Feature branch format**: [e.g., feature/XXXX-description]
- **PR title format**: [e.g., [XXXX] Description]
- **Base branch for features**: [e.g., main, or develop for FE/BE]
- **Merge strategy**: [e.g., squash and merge]

## Project Management

- **Tool**: [e.g., GitHub Issues, Jira, Linear, Notion, none]
- **Issue ID format**: [e.g., PROJ-123, #123, IS-12345]
- **Status flow**: [e.g., To Do → In Progress → In Review → Done]
- **How to link issues to PRs**: [e.g., "Closes #123" in PR body]

## Architecture Highlights

Anything the team should know about your architecture:

- **Auth**: [e.g., JWT via Auth0, session-based, OAuth2]
- **Database**: [e.g., PostgreSQL with Prisma ORM]
- **State management (frontend)**: [e.g., Zustand, Redux, Jotai]
- **Data fetching (frontend)**: [e.g., React Query, SWR, fetch]
- **API style**: [e.g., REST, GraphQL, tRPC]
- **Key conventions**: [e.g., "All money amounts are integers in cents", "Feature flags via LaunchDarkly"]

## Domain Specialist (Pippin)

Does your project have a specialized domain that needs its own expert?

- **Domain**: [e.g., Smart Contracts, ML Pipelines, Mobile (React Native), Data Engineering, or "none"]
- **Tools/frameworks**: [e.g., Solidity + Foundry, PyTorch + MLflow, etc.]
- **Repo**: [e.g., contracts/, ml-pipelines/, or "same as backend"]
- **Special considerations**: [e.g., "Contracts handle real money -- security is paramount", "Models need GPU for training"]

If "none", Pippin will be kept as a generic specialist and can be customized later.

## CI/CD & Infrastructure

- **CI platform**: [e.g., GitHub Actions, CircleCI, GitLab CI]
- **Cloud provider**: [e.g., AWS, GCP, Azure, Vercel]
- **Deployment method**: [e.g., Vercel auto-deploy, kubectl apply, terraform apply]
- **Environments**: [e.g., dev → staging → production]

## Team Conventions

Anything else the Fellowship should respect:

- **Code owners**: [e.g., "CODEOWNERS file in each repo", or list names]
- **Review requirements**: [e.g., "1 approval required", "2 for backend"]
- **Sensitive areas**: [e.g., "Never auto-modify migrations", "Auth module needs senior review"]
- **Anything else**: [Free-form -- testing philosophy, documentation standards, etc.]
```
