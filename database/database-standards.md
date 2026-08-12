# Database Standards

## Purpose

This document defines the database standards used throughout the ChoreQuest project.

These standards ensure consistency, maintainability, scalability, and portability across PostgreSQL, Microsoft SQL Server, Azure SQL Database, Microsoft Dataverse, and SharePoint Online (where appropriate).

---

# Database Platform

Primary Development Database

- PostgreSQL

Development Environment

- Supabase

Administration Tool

- DBeaver

---

# Naming Convention

Database objects use:

- snake_case
- lowercase letters only

Examples

Table

```text
household
point_transaction
reward_redemption
```

Column

```text
household_id
created_at
updated_at
```

---

# Primary Keys

Every table uses:

- UUID
- NOT NULL

Example

```text
household_id UUID PRIMARY KEY
```

---

# Foreign Keys

Foreign key names follow:

```text
<referenced_table>_id
```

Examples

```text
household_id
parent_user_id
child_user_id
reward_id
```

---

# Audit Columns

Every table contains:

- created_at
- created_by
- updated_at
- updated_by

These fields provide a complete audit trail.

---

# Soft Delete

Records are never physically deleted.

Instead, use:

- is_deleted BOOLEAN
- deleted_at TIMESTAMP

---

# Date and Time

All timestamps use UTC.

Timestamp fields use:

- TIMESTAMP WITH TIME ZONE

---

# Constraints

Use constraints wherever possible.

Examples

- NOT NULL
- UNIQUE
- CHECK
- FOREIGN KEY

---

# Indexing

Indexes will be added for:

- Foreign Keys
- Frequently searched columns
- Reporting queries

---

# Database Design Principles

- Normalised tables
- Avoid duplicated data
- Strong referential integrity
- Clear business relationships
- Portable schema
- Enterprise-ready design


# Sprint 1 & 2 Summary
For ChoreQuest, I designed a normalized PostgreSQL relational database covering households, users, chores, assignments, rewards and transactions. I used UUID primary keys, foreign keys, CHECK constraints and UNIQUE constraints to enforce data integrity at the database layer.

I then moved the database into a Supabase CLI workflow so the schema could be version controlled through migrations rather than manually maintained in the dashboard. I separated the database design documentation from the executable migration history and added reproducible seed data for local development.

One key design decision was the points system. Instead of storing only a user's current balance, I implemented a transaction ledger so every point movement—such as completing a chore, receiving a bonus or redeeming a reward—is auditable. We verified that Irham earned 80 points, redeemed 75, and therefore has a calculated balance of 5.

Finally, I created SQL verification scripts and used `supabase db reset` and `supabase db diff` to prove that the database can be recreated consistently and that there is no unexpected schema drift. The whole database workflow is committed to Git and released as v1.1.0.
