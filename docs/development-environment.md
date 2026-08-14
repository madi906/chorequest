# ChoreQuest Development Environment

## Overview

ChoreQuest is developed using a local-first development workflow.

The application runs locally using Next.js, while the database and Supabase services run through the local Supabase stack.

```text
Browser
   │
   ▼
Next.js
localhost:3000
   │
   ▼
Supabase Local
127.0.0.1:54321
   │
   ▼
PostgreSQL 17
127.0.0.1:54322
```

## Development Machine

### Operating System

- macOS 26.6.1
- Apple Silicon (ARM64)

### Development Tools

| Tool | Version |
|---|---|
| Node.js | 22.23.2 |
| NVM | 0.40.6 |
| npm | 10.9.8 |
| Git | Apple Git 2.50.1 |
| Supabase CLI | 2.113.0 |
| Docker | 29.7.2 |
| VS Code | 1.133.0 |
| Next.js | 16.3.0 |
| React | 19.2.8 |
| TypeScript | 5.9.3 |
| Tailwind CSS | 4.3.3 |

## Repository Structure

```text
chorequest/
├── app/                  # Next.js application
├── database/             # Database documentation and standards
├── diagrams/             # Architecture and ERD diagrams
├── docs/                 # Project documentation
├── release-notes/        # Release documentation
└── supabase/
    ├── migrations/       # Database migrations
    ├── snippets/         # Database verification SQL
    ├── seed.sql          # Development seed data
    └── config.toml       # Local Supabase configuration
```

## Node.js

ChoreQuest uses Node.js 22.

The required version is defined in:

```text
.nvmrc
```

To activate the project version:

```bash
nvm use
```

Verify the active Node.js version:

```bash
node --version
```

Verify npm:

```bash
npm --version
```

## Local Supabase

ChoreQuest uses Supabase locally for development.

Supabase runs inside Docker containers.

### Start Local Supabase

From the repository root:

```bash
cd ~/Developer/chorequest
supabase start
```

### Check Supabase Status

```bash
supabase status
```

### Local Services

| Service | URL |
|---|---|
| Supabase API | http://127.0.0.1:54321 |
| Supabase Studio | http://127.0.0.1:54323 |
| Mailpit | http://127.0.0.1:54324 |
| PostgreSQL | 127.0.0.1:54322 |

### Stop Local Supabase

```bash
cd ~/Developer/chorequest
supabase stop
```

## Database

The local database uses PostgreSQL 17.

Database structure is managed through version-controlled migrations located in:

```text
supabase/migrations/
```

Seed data is stored in:

```text
supabase/seed.sql
```

Database verification SQL snippets are stored in:

```text
supabase/snippets/
```

Database configuration is stored in:

```text
supabase/config.toml
```

### Database Change Principle

Database changes should be implemented through version-controlled migration files rather than manual changes directly in the database.

This allows the database structure to be reproduced consistently across development and deployment environments.

## Next.js Application

The Next.js application is located in:

```text
app/
```

Enter the application directory:

```bash
cd ~/Developer/chorequest/app
```

### Install Dependencies

Install dependencies from `package.json`:

```bash
npm install
```

### Start Development Server

```bash
npm run dev
```

The development application is available at:

```text
http://localhost:3000
```

### Production Build

Create an optimized production build:

```bash
npm run build
```

### Production Server

Start the production build locally:

```bash
npm run start
```

## Environment Variables

Local development uses:

```text
app/.env.local
```

The local environment connects the Next.js application to the local Supabase instance.

The local Supabase API URL is:

```text
http://127.0.0.1:54321
```

Environment files containing credentials or keys must not be committed to Git.

The repository ignores environment files such as:

```text
.env
.env.local
.env*
```

### Security Principle

Never commit:

- Supabase secret keys
- Supabase service-role keys
- Database passwords
- API secrets
- Authentication secrets
- Other private credentials

Client-side environment variables must only contain values that are intentionally safe to expose to the browser.

## Git Workflow

Check the current repository status:

```bash
git status
```

Pull the latest changes:

```bash
git pull --rebase origin main
```

After making changes:

```bash
git status
```

Stage the required files:

```bash
git add .
```

Commit the changes:

```bash
git commit -m "description of change"
```

Push to GitHub:

```bash
git push origin main
```

## Typical Development Workflow

### 1. Start Docker

Make sure Docker Desktop is running.

Verify:

```bash
docker --version
```

### 2. Start Local Supabase

From the repository root:

```bash
cd ~/Developer/chorequest
supabase start
```

Verify the services:

```bash
supabase status
```

### 3. Start Next.js

Open another terminal window and run:

```bash
cd ~/Developer/chorequest/app
npm run dev
```

### 4. Open ChoreQuest

Open:

```text
http://localhost:3000
```

### 5. Verify Application Routes

The current application includes:

```text
/
 /dashboard
 /members
 /chores
 /rewards
```

### 6. Stop Development Environment

When finished, stop the Next.js development server with:

```text
Ctrl + C
```

Then stop Supabase:

```bash
cd ~/Developer/chorequest
supabase stop
```

## Verification Checklist

Before committing significant application or database changes:

### Git

```bash
git status
```

Confirm there are no unexpected files or changes.

### Node.js

```bash
node --version
npm --version
```

Confirm the expected Node.js environment is active.

### Supabase

```bash
supabase status
```

Confirm the local Supabase environment is running when database functionality is required.

### Application

```bash
cd ~/Developer/chorequest/app
npm run dev
```

Verify the application loads successfully at:

```text
http://localhost:3000
```

### Application Routes

Verify:

```text
/
 /dashboard
 /members
 /chores
 /rewards
```

### Production Build

Run:

```bash
npm run build
```

The build should complete successfully before major changes are pushed.

## Local-First Development Model

ChoreQuest follows a local-first development model.

The normal development workflow is:

```text
Developer
    │
    ▼
VS Code
    │
    ▼
Next.js Application
localhost:3000
    │
    ▼
Supabase Local
127.0.0.1:54321
    │
    ▼
PostgreSQL 17
```

The local Supabase environment is the primary development database.

The Supabase Cloud project is treated as a separate deployment environment.

Database changes should be represented by version-controlled migration files so the database can be reproduced consistently across environments.

## Development and Deployment Separation

The project maintains a clear separation between local development and cloud deployment.

```text
                 GitHub Repository
                        │
                        │
             Version-controlled code
                        │
             ┌──────────┴──────────┐
             │                     │
             ▼                     ▼
      Local Development       Cloud Deployment
             │                     │
             ▼                     ▼
     Supabase Local          Supabase Cloud
             │                     │
             ▼                     ▼
      PostgreSQL 17          Cloud PostgreSQL
```

The local environment is intended for:

- Development
- Testing
- Database experimentation
- Migration testing
- UI development
- Integration testing

The cloud environment is intended for:

- Deployment
- Demonstration
- Portfolio access
- Production-like testing

## Reproducibility

The ChoreQuest development environment should be reproducible from the GitHub repository.

The following project components are version controlled:

- Application source code
- Database migrations
- Database seed data
- Supabase configuration
- Architecture documentation
- Development documentation

Environment-specific secrets are intentionally excluded from Git.

This allows the project to be cloned onto another development machine without transferring private credentials through the repository.

## Current Development Baseline

The current verified development environment successfully supports:

- Git and GitHub repository access
- Next.js development server
- Local Supabase
- PostgreSQL 17
- Supabase database schema
- Supabase seed data
- Supabase API access
- ChoreQuest application routes
- Production Next.js build

The current production build completes successfully using:

```bash
npm run build
```

## Important Development Principle

ChoreQuest should continue to use a migration-first and local-first development approach.

When database changes are required:

1. Make the change through a migration.
2. Test the migration against the local Supabase database.
3. Verify the application against the local database.
4. Run the production build.
5. Commit the migration and application changes to Git.
6. Deploy the migration to Supabase Cloud when the change is ready.

This approach keeps the database, application code, and deployment process aligned and provides a foundation for future CI/CD automation.