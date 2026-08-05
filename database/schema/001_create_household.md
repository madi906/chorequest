# Table: household

## Purpose

Stores information about each household (family) using ChoreQuest.

A household is the top-level entity that owns users, chores, rewards, and other related records.

---

## Columns

| Column | Description |
|---------|-------------|
| household_id | Unique identifier (UUID). |
| household_name | Friendly name of the household. |
| household_description | Optional description of the household. |
| is_active | Indicates whether the household is active. |
| created_at | Date and time the record was created. |
| created_by | User who created the record. |
| updated_at | Date and time the record was last updated. |
| updated_by | User who last updated the record. |
| deleted_at | Date and time the record was deleted. |
| deleted_by | User who deleted the record. |
| is_deleted | Indicates whether the record has been soft deleted. |

---

## Relationships

- One household has many app users.
- One household has many chores.
- One household has many rewards.
- One household has many point transactions.