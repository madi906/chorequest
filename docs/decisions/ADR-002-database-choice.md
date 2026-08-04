# ADR-002: Database Choice

## Status

Accepted

---

## Context

Microsoft Power Platform applications commonly use SharePoint Online Lists or Microsoft Dataverse as their primary data source.

While these services integrate well with Power Apps and Power Automate, they provide limited opportunities to demonstrate advanced relational database design, SQL development, and enterprise data modelling skills.

The objective of ChoreQuest is to showcase both Microsoft Power Platform expertise and professional database architecture suitable for enterprise applications.

---

## Decision

PostgreSQL will be used as the primary development database through Supabase.

The application layer will be implemented using Microsoft Power Apps and Microsoft Power Automate.

The database schema will follow ANSI SQL principles and standard relational modelling practices to ensure portability across multiple enterprise database platforms.

The solution is intentionally designed so that the data layer can be migrated with minimal redesign to:

- Microsoft Dataverse
- Azure SQL Database
- Microsoft SQL Server
- SharePoint Online Lists (where appropriate)

---

## Rationale

PostgreSQL was selected because it:

- Demonstrates professional SQL skills.
- Supports advanced relational database design.
- Enforces referential integrity.
- Encourages proper normalisation.
- Is widely used in enterprise environments.
- Is free for development.
- Integrates well with Supabase.
- Can be accessed from Microsoft Power Platform.

This approach allows the portfolio to demonstrate database skills beyond the capabilities of SharePoint Lists while remaining aligned with Microsoft technologies.

---

## Consequences

### Advantages

- Strong relational database design
- Enterprise-quality SQL skills
- Better interview portfolio
- Vendor-neutral data model
- Easier future migration
- Excellent learning platform

### Trade-offs

- Slightly more initial setup than SharePoint Online.
- Additional connector configuration when integrating with Power Apps.
- More responsibility for database administration.

These trade-offs are considered acceptable because the project prioritises learning, architectural quality, and long-term career development.

---

## Alternatives Considered

### SharePoint Online Lists

Pros

- Native Power Apps integration
- Minimal setup
- Excellent for simple applications

Cons

- Limited relational capabilities
- Difficult to demonstrate advanced database design

Decision

Not selected as the primary development database.

---

### Microsoft Dataverse

Pros

- Best integration with Microsoft Power Platform
- Enterprise security
- Rich business features

Cons

- Licensing cost
- Less suitable for demonstrating traditional SQL skills

Decision

Planned as a future migration target.

---

### Azure SQL Database

Pros

- Fully managed Microsoft SQL platform
- Enterprise ready
- Excellent Power Platform integration

Cons

- Ongoing cloud costs during development

Decision

Future production option.

---

## Review

This decision will be reviewed after Sprint 3, when Power Apps integration has been completed.

---
Version: 0.6
Status: Draft
Last Updated: August 2026
Owner: Akmal Hadi