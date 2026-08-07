# Database

This folder contains all database-related assets for ChoreQuest.

## Structure

schema/
Contains all database schema creation scripts.

seed/
Contains sample data used for development and demonstrations.

migration/
Reserved for future database migration scripts.

## Database

PostgreSQL 17

Hosted on Supabase.

## Design Principles

- UUID primary keys
- Soft delete
- Audit columns
- Foreign key integrity
- Business rule constraints
- Ledger-based point accounting