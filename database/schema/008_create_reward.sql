/*
====================================================
Table: reward

Purpose:
Stores household rewards.

Sprint:
Sprint 1.8
====================================================
*/

CREATE TABLE reward (

    reward_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    household_id UUID NOT NULL,

    reward_name VARCHAR(100) NOT NULL,

    reward_type VARCHAR(30) NOT NULL,

    point_cost INTEGER NOT NULL,

    reward_description TEXT,

    available_quantity INTEGER,

    display_order INTEGER NOT NULL DEFAULT 1,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_reward_household
        FOREIGN KEY (household_id)
        REFERENCES household(household_id),

    CONSTRAINT chk_reward_type
        CHECK (
            reward_type IN (
                'PHYSICAL',
                'PRIVILEGE',
                'ACTIVITY',
                'MONEY',
                'CUSTOM'
            )
        ),

    CONSTRAINT chk_point_cost
        CHECK (point_cost > 0),

    CONSTRAINT chk_available_quantity
        CHECK (
            available_quantity IS NULL
            OR available_quantity >= 0
        ),

    CONSTRAINT uq_reward_name_household
        UNIQUE (household_id, reward_name)

);