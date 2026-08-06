# Table: reward_redemption

## Purpose

Stores reward redemption transactions performed by household members.

Each redemption records which reward was selected, which user redeemed it, how many points were used, and the approval workflow status.

Reward redemption acts as a historical record of point usage. The points used are stored as a snapshot value because the reward cost may change in the future.

---

## Columns

| Column | Description |
|---------|-------------|
| redemption_id | Unique identifier (UUID). |
| redemption_reference_no | Unique identifier for human readable code |
| reward_id | References the redeemed reward. |
| redemption_by | References the user who redeemed the reward. |
| points_used | Snapshot of points deducted during redemption. |
| redemption_at | Date and time when the redemption request was created. |
| redemption_status | Current workflow status of the redemption. |
| approved_by | User who approved or rejected the redemption. |
| approved_at | Date and time when the redemption was approved or rejected. |
| comment | Optional parent comment or approval note. |
| created_at | Record creation timestamp. |
| created_by | User who created the record. |
| updated_at | Record update timestamp. |
| updated_by | User who updated the record. |
| deleted_at | Soft delete timestamp. |
| deleted_by | User who performed the deletion. |
| is_deleted | Soft delete flag. |

---

## Relationships

- Many reward redemptions belong to one reward.
- Many reward redemptions belong to one app_user.
- One app_user can have many reward redemption records.
- Reward redemption ownership is inherited through the app_user and reward relationships.

---

## Business Rules

- A redemption must reference an existing reward.
- A redemption must reference an existing user.
- Points used must represent the reward cost at the time of redemption.
- Redemption status controls the approval workflow.
- Redemption reference number must be unique.
- Redemption reference numbers provide a human-readable identifier for users and reports.
- The UUID remains the primary technical identifier.

Example statuses:

| Status | Description |
|---------|-------------|
| Pending | Waiting for parent approval. |
| Approved | Redemption approved and points deducted. |
| Rejected | Redemption request rejected. |
| Cancelled | Redemption cancelled after creation. |

---

## Approval Workflow

The redemption lifecycle:

Pending

↓

Approved / Rejected

↓

Completed or Cancelled


Approval information is stored directly in the reward_redemption table because the current workflow only requires one approval decision.

A separate approval history table may be introduced in the future if multi-level approval is required.

---

## Soft Delete Strategy

Reward redemption records use soft delete instead of physical deletion.

Reason:

- Preserve historical point usage records.
- Maintain reporting accuracy.
- Keep audit history.
- Avoid breaking relationships with reward and user records.

Deleted records remain in the database but are excluded from active application views.

---

## Architecture Decisions

### Multi-Tenant Ownership

Reward redemption does not directly store household_id.

Ownership is derived through related entities:

household

↓

app_user

↓

reward_redemption


This avoids duplicated tenant references while maintaining data integrity.

---

### Snapshot Value Pattern

points_used is stored separately from reward.point_cost.

Reason:

Reward prices may change over time, but historical redemption records must preserve the original transaction value.

Example:

At redemption time:

LEGO = 200 points

Later:

LEGO = 300 points

Historical record remains:

LEGO redeemed for 200 points.