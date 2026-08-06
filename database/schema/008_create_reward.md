# Table: reward

## Purpose

Stores reusable rewards that household members can redeem using accumulated points.

Rewards are household-specific and act as a catalog of available rewards.

Actual redemption history is stored in the reward_redemption table.

---

## Columns

| Column | Description |
|---------|-------------|
| reward_id | Unique identifier (UUID). |
| household_id | References the household that owns the reward. |
| reward_name | Name of the reward. |
| reward_type | Reward category. |
| point_cost | Number of points required to redeem the reward. |
| reward_description | Description of the reward. |
| available_quantity | Number of available rewards. NULL indicates unlimited quantity. |
| display_order | Display order in the application. |
| is_active | Indicates whether the reward is currently available. |
| created_at | Record creation timestamp. |
| created_by | User who created the record. |
| updated_at | Record update timestamp. |
| updated_by | User who updated the record. |
| deleted_at | Soft delete timestamp. |
| deleted_by | User who performed the deletion. |
| is_deleted | Soft delete flag. |

---

## Relationships

- Many rewards belong to one household.
- One reward can be redeemed many times.

---

## Business Rules

- Reward names must be unique within a household.
- Point cost must be greater than zero.
- Rewards may be temporarily disabled.
- Unlimited rewards have NULL available_quantity.
- Soft deleted rewards are hidden from users.

---

## Reward Types

| Code | Description |
|------|-------------|
| PHYSICAL | Physical item |
| PRIVILEGE | Special privilege |
| ACTIVITY | Family activity |
| MONEY | Cash reward |
| CUSTOM | Custom reward |

---

## Power Apps Considerations

- Display rewards in a Gallery sorted by display_order.
- Hide inactive rewards from children.
- Only parents can create, edit or deactivate rewards.
- Show point cost together with the user's current balance.
- Display different icons based on reward type.

---

## Future Enhancements

- Reward images
- Reward expiry date
- Seasonal rewards
- Limited-time promotions
- Reward categories with icons