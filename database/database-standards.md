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