# Example: Integrating Fellowship Code with Your Project

This example shows how to set up the Fellowship for a typical full-stack web application with a monorepo containing frontend, backend, and infrastructure.

---

## Step 1: Clone the Fellowship

```bash
# From your project root
git clone https://github.com/endaoment/fellowship-code.git fellowship

# Or add as a submodule
git submodule add https://github.com/endaoment/fellowship-code.git fellowship
```

## Step 2: Set Up Your Claude Directory

```bash
# Create the claude directory if it doesn't exist
mkdir -p .claude/{agents,skills,rules,docs}

# Install the Fellowship
cd fellowship
./setup.sh --claude-dir=../.claude
```

## Step 3: Create Your CLAUDE.md

The Fellowship agents read `CLAUDE.md` at your workspace root for project context. Here's an example:

````markdown
# CLAUDE.md

## Repository Structure

| Directory  | Purpose         | Tech Stack                  |
| ---------- | --------------- | --------------------------- |
| `frontend` | Web Application | Next.js 14, React, Tailwind |
| `backend`  | API Server      | Django 5.0, DRF, PostgreSQL |
| `infra`    | Infrastructure  | Terraform, AWS CDK          |
| `docs`     | Documentation   | Docusaurus                  |

## Common Commands

### Frontend (`frontend/`)

\```bash
npm run dev # Dev server on :3000
npm run build # Production build
npm run test # Vitest
npm run lint # ESLint + Prettier
\```

### Backend (`backend/`)

\```bash
python manage.py runserver # Dev server on :8000
python manage.py test # Django tests
ruff check . # Lint
python manage.py migrate # Run migrations
\```

### Infrastructure (`infra/`)

\```bash
terraform plan # Preview changes
terraform apply # Apply changes
\```

## Key Conventions

- Branch naming: `feature/XXXX-description` from `main`
- PR title format: `[XXXX] Description`
- All PRs require CI green before merge
- Frontend and backend deploy independently

## Available Agents

| Agent   | Purpose                                        |
| ------- | ---------------------------------------------- |
| Gandalf | Orchestrator & Architect — plans and delegates |
| Aragorn | Lead Dev — hardest tasks, any repo             |
| Legolas | Frontend Dev — Next.js, React, Tailwind        |
| Gimli   | Backend Dev — Django, DRF, PostgreSQL          |
| Frodo   | Test Writer — pytest, Vitest, Playwright       |
| Samwise | QA Dev — verification, proof, polish           |
| Merry   | Ops Dev — Terraform, AWS, CI/CD                |
| Boromir | Code Reviewer — quality gates                  |
| Smeagol | PM — GitHub Issues tracking                    |

## Phase Commands

| Command             | Purpose                             |
| ------------------- | ----------------------------------- |
| /spec-and-plan      | Design architecture + create issues |
| /build-full-stack   | Implement across repos              |
| /qa-and-polish      | QA verification + review-ready PRs  |
| /code-review        | Bidirectional code review           |
| /deploy-and-release | Ship to production                  |
````

## Step 4: Customize Agent Domain Knowledge

Update each agent's Domain Knowledge section with your project specifics. For example, in `agents/gimli-the-backend-dev.md`:

````markdown
## Domain Knowledge

**Repo**: `backend` (Django monolith)

- **Framework**: Django 5.0 with Django REST Framework
- **Database**: PostgreSQL 16
- **Auth**: JWT via djangorestframework-simplejwt
- **Task Queue**: Celery with Redis
- **Structure**: Apps in `apps/`, shared utilities in `common/`

### Commands

\```bash
python manage.py runserver # Dev server
python manage.py test # Run tests
python manage.py makemigrations # Create migrations
python manage.py migrate # Apply migrations
ruff check . # Lint
\```

### Branch Convention

- Branch from `main`: `feature/XXXX-short-description`
- PR to `main`
````

## Step 5: Try It Out

```text
# In Cursor chat:
Ask Gandalf to explore the backend codebase and describe the
authentication architecture.

# Or rally the team:
/spec-and-plan Add a user notification preferences page where users
can configure email and push notification settings per category.
```

---

## Tips

- **Start small**: Try sending a single agent on a focused task before rallying the team.
- **Keep CLAUDE.md updated**: The agents rely on it for project context.
- **Customize gradually**: Start with the defaults, then update Domain Knowledge as you learn what works.
- **Use the scratchpad**: Gandalf's scratchpad is great for understanding what the team is doing.
