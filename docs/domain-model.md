# ChoreQuest Domain Model

## Vision

ChoreQuest helps families build positive habits by managing household chores, tracking points, and encouraging responsibility through gamification.

---

## MVP Scope

The first version includes:

- Household
- Parent
- Child
- Chore
- Chore Assignment
- Point Tracking

Future versions may include:

- Rewards
- Badges
- Notifications
- School Mode
- AI Assistant

---

## Core Business Objects

- Household
- User
- Role
- Child
- Parent
- Chore
- Chore Category
- Assignment
- Assignment History
- Point Transaction
- Reward
- Reward Redemption
- Badge
- Notification
- Audit Log

## Business Process

### Parent

1. Create household
2. Invite family members
3. Create chore templates
4. Assign chores
5. Review completed chores
6. Approve or reject submissions
7. Award points
8. Monitor family progress

---

### Child

1. View assigned chores
2. Complete a chore
3. Submit for approval
4. Receive points after approval
5. View personal score
6. Redeem rewards (future)

---

### System

- Track all assignments
- Track all point transactions
- Maintain audit history
- Calculate leaderboard

---

## Domain Relationships

- One Household has many Users.
- One User belongs to one Household.
- One Parent can assign many Chores.
- One Child can receive many Assignments.
- One Chore can be assigned many times.
- One Assignment belongs to one Child.
- One Assignment generates zero or more Point Transactions.
- One Child can earn many Point Transactions.
- One Child can redeem many Rewards.

---
Version: 0.6
Status: Draft
Last Updated: August 2026
Owner: Akmal Hadi

---

## Core Entities

| Entity | Description |
|----------|-------------|
| Household | Represents a family using the application. |
| App User | Represents a parent or child within a household. |
| Chore Category | Groups similar chores together. |
| Chore | Defines a reusable household task. |
| Assignment | Assigns a chore to a child and tracks its progress. |
| Point Transaction | Records every point earned or deducted. |
| Reward | Defines rewards that children can redeem. |
| Reward Redemption | Records reward redemption requests and approvals. |
| Audit Log | Records important system events for traceability. |

## Future Entities

| Entity | Description |
|----------|-------------|
| Attachment | Stores photos or supporting files for completed chores. |

---
Version: 1.0
Status: Draft
Remark: Added core entities / table with description
Last Updated: August 2026
Owner: Akmal Hadi