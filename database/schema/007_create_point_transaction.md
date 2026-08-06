# Table: point_transaction

## Purpose

Stores the ledger of all point movements for household members.

Each record represents one point transaction, either earning or spending points.

The current point balance is calculated by summing all active point transactions instead of storing a running balance.

---

## Columns

| Column | Description |
|---------|-------------|
| point_transaction_id | Unique identifier (UUID). |
| assignment_id | References the assignment that generated the transaction (nullable for manual adjustments). |
| app_user_id | References the household member. |
| transaction_type | Type of point transaction. |
| point_amount | Positive or negative point value. |
| transaction_at | Date and time the transaction occurred. |
| transaction_description | Description or reason for the transaction. |
| created_at | Record creation timestamp. |
| created_by | User who created the record. |
| updated_at | Record update timestamp. |
| updated_by | User who updated the record. |
| deleted_at | Soft delete timestamp. |
| deleted_by | User who performed the deletion. |
| is_deleted | Soft delete flag. |

---

## Relationships

- Many point transactions belong to one app user.
- Many point transactions may reference one assignment.

---

## Business Rules

- Point transactions may be positive or negative.
- Assignment-generated transactions must reference an assignment.
- Manual adjustments do not require an assignment.
- The user's current balance is calculated by summing point_amount.
- Soft-deleted transactions are excluded from balance calculations.

---

## Transaction Types

| Code              | Description                                |
|-------------------|--------------------------------------------|
| ASSIGNMENT        | Points earned from an approved assignment. |
| REWARD_REDEMPTION | Points deducted for redeeming a reward.    |
| BONUS             | Bonus points awarded by a parent.          |
| PENALTY           | Points deducted as a penalty.              |
| MANUAL_ADJUSTMENT | Manual correction or adjustment.           |

---

## Example Data

| User | Type              | Points | Description    |
|------|-------------------|--------|----------------|
| Adam | ASSIGNMENT.       | +20    | Wash dishes    |
| Adam | BONUS             | +5     | Helped sibling |
| Adam | REWARD_REDEMPTION | -50    | Redeemed LEGO  |

---

## Future Enhancements

- Expiration of points
- Point multipliers
- Promotional bonus campaigns
- Household-wide bonus events