# Table: chore

## Purpose

Stores reusable chore templates that can be assigned to household members.

Each chore belongs to a chore category and can be assigned multiple times.

---

## Columns

| Column | Description |
|---------|-------------|
| chore_id | Unique identifier (UUID). |
| chore_category_id | References the chore category. |
| chore_name | Name of the chore (e.g. Wash dishes, Vacuum living room, etc. |
| chore_description | Description for the chore. |
| chore_difficulty | Indicates difficulty level. |
| default_points | Default point in for the chore template. |
| estimated_duration_minutes | Estimated duration in minutes to complete the chore. |
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

- Many chores belong to one chore category.
- One chore can be assigned many times through the assignment table.

---

## Business Rules

- Chore names should be unique within the same household and category.
- Different households may use the same chore names.

---

## Example Data

| Chore | Category | Default Points |
|--------|----------|---------------:|
| Wash Dishes | Kitchen | 10 |
| Vacuum Living Room | Cleaning | 20 |
| Feed the Cat | Pets | 5 |

---

## Future Enhancements