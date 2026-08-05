/*
====================================================
Table: household
Purpose:
Stores one family using ChoreQuest.

Relationships

- One household has many app_users
- One household has many chores
- One household has many rewards

====================================================
*/

-- Columns will be added in Step 5

/*
====================================================
Table: household
Purpose:
Stores information about each household (family).

Sprint:
Sprint 1.1

====================================================
*/

CREATE TABLE household (

    household_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    household_name VARCHAR(100) NOT NULL,

    household_description VARCHAR(500),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE

);