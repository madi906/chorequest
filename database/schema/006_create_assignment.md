# Table: assignment

## Purpose

Stores individual chore assignments.

Each assignment represents one chore assigned to one household member.

Assignments maintain a snapshot of the default points at the time of assignment while allowing the parent to award a different number of points during approval.

---

## Columns

| Column | Description |
|--------|-------------|
| assignment_id | Unique identifier (UUID). |
| chore_id | References the assigned chore. |
| app_user_id | References the assigned household member. |
| assignment_status_id | Current workflow status. |
| assigned_by | User who assigned the chore. |
| assigned_at | Assignment timestamp. |
| assigned_for_date | Planned completion date. |
| due_date | Due date. |
| completed_at | Completion timestamp. |
| approved_at | Approval timestamp. |
| approved_by | User who approved the assignment. |
| default_points | Snapshot of chore default points. |
| awarded_points | Final approved points. |
| awarded_points_reason | Reason when awarded points differ. |
| parent_comment | Parent feedback. |
| child_comment | Child comment. |
| proof_of_completion_url | Storage URL of uploaded evidence. |
| completion_percentage | Completion percentage (0-100). |
| created_at | Record creation timestamp. |
| created_by | User who created the record. |
| updated_at | Record update timestamp. |
| updated_by | User who updated the record. |
| deleted_at | Soft delete timestamp. |
| deleted_by | User who performed the deletion. |
| is_deleted | Soft delete flag. |

---

## Relationships

- Many assignments belong to one chore.
- Many assignments belong to one app user.
- Many assignments reference one assignment status.

---

## Business Rules

- One assignment belongs to one user.
- One assignment references one chore.
- Default points are copied from the chore when assigned.
- Awarded points may differ from default points.
- Assigned points must never modify historical assignments.
- Completion percentage must be between 0 and 100.
- Proof of completion is optional.

---

## Example Workflow

Assigned

↓

In Progress

↓

Completed

↓

Approved

---

## Future Enhancements

- Team assignments
- Recurring assignments
- QR verification
- GPS verification
- AI image verification