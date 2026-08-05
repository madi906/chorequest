# Table: chore_category

## Purpose

Stores categories used to organize chores within a household.

Each household manages its own categories independently.

---

## Columns

| Column | Description |
|---------|-------------|
| chore_category_id | Unique identifier (UUID). |
| household_id | References the owning household. |
| chore_category_name | Name of the category (e.g. Cleaning, Homework). |
| is_active | Indicates whether the category is active. |
| created_at | Record creation timestamp. |
| created_by | User who created the record. |
| updated_at | Record update timestamp. |
| updated_by | User who updated the record. |
| deleted_at | Soft delete timestamp. |
| deleted_by | User who performed the deletion. |
| is_deleted | Soft delete flag. |

---

## Relationships

- Many categories belong to one household.
- One category can be used by many chores.

---

## Business Rules

- Category names must be unique within a household.
- Different households may use the same category names.