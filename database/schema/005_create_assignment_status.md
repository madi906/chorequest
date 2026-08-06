# Table: assignment_status

## Purpose

Stores the list of valid workflow statuses for chore assignments.

This table allows the workflow to be managed without modifying application code whenever new statuses are introduced.

Each assignment references one assignment status.

---

## Columns

| Column | Description |
|--------|-------------|
| assignment_status_id | Unique identifier (UUID). |
| status_code | Internal system code (e.g. ASSIGNED). |
| status_name | User-friendly display name. |
| display_order | Controls display order in the application. |
| is_terminal | Indicates whether this status completes the workflow. |
| is_active | Indicates whether the status can be used. |
| created_at | Record creation timestamp. |
| created_by | User who created the record. |
| updated_at | Record update timestamp. |
| updated_by | User who updated the record. |
| deleted_at | Soft delete timestamp. |
| deleted_by | User who performed the deletion. |
| is_deleted | Soft delete flag. |

---

## Relationships

One assignment status can be used by many assignments.

---

## Business Rules

- Status codes must be unique.
- Terminal statuses cannot transition to another status without administrative intervention.
- Inactive statuses cannot be assigned to new assignments.

---

## Default Statuses

| Code | Name | Terminal |
|------|------|-----------|
| ASSIGNED | Assigned | No |
| IN_PROGRESS | In Progress | No |
| COMPLETED | Completed | No |
| APPROVED | Approved | Yes |
| REJECTED | Rejected | Yes |
| REVISION_REQUIRED | Revision Required | No |
| CANCELLED | Cancelled | Yes |
| DNF | Did Not Finish | Yes |

---

## Future Enhancements

- Status colour
- Mobile icon
- Email template
- Push notification template