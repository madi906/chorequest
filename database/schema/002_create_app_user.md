# Table: app_user

## Purpose

Stores users of the ChoreQuest application.

A user belongs to one household and can be either a parent or a child.

---

## Columns

| Column | Description |
|---------|-------------|
| app_user_id | Unique identifier (UUID). |
| household_id | References the household the user belongs to. |
| app_user_name | User's display name. |
| app_user_email | User's email address. Must be unique. |
| app_user_phone | Optional contact number. |
| user_role | Parent or Child. |
| app_user_birthday | User's date of birth. |
| avatar_url | URL to the user's avatar image. |
| is_active | Indicates whether the user is active. |
| last_login_at | Last successful login timestamp. |
| created_at | Record creation timestamp. |
| created_by | User who created the record. |
| updated_at | Record update timestamp. |
| updated_by | User who updated the record. |
| deleted_at | Soft delete timestamp. |
| deleted_by | User who performed the deletion. |
| is_deleted | Soft delete flag. |

---

## Relationships

- Many app users belong to one household.