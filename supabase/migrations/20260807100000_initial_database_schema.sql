/*
====================================================
Migration:
Initial ChoreQuest Database Schema

Purpose:
Creates the complete database foundation.

Created:
2026-08-07
====================================================
*/


-- ==============================================
-- Extensions
-- ==============================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ==============================================
-- Table: household
-- Purpose:
-- Stores information about each household
-- ==============================================

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

-- ==============================================
-- Table: app_user
-- Purpose:
-- Stores users (parents and children)
-- belonging to a household.
-- ==============================================

CREATE TABLE app_user (

    app_user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    household_id UUID NOT NULL,

    app_user_name VARCHAR(100) NOT NULL,

    app_user_email VARCHAR(255) UNIQUE,

    app_user_phone VARCHAR(30),

    user_role VARCHAR(20) NOT NULL,

    app_user_birthday DATE,

    avatar_url VARCHAR(500),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    last_login_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT fk_app_user_household
        FOREIGN KEY (household_id)
        REFERENCES household(household_id)

);

-- ==============================================
-- Table: chore_category
-- Purpose:
-- Stores household-specific categories used to
-- organize chores.
-- ==============================================

CREATE TABLE chore_category (

    chore_category_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    household_id UUID NOT NULL,

    chore_category_name VARCHAR(100) NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT fk_chore_category_household
        FOREIGN KEY (household_id)
        REFERENCES household(household_id),


    CONSTRAINT uq_chore_category_name_per_household
        UNIQUE (household_id, chore_category_name)

);

-- ==============================================
-- Table: chore
-- Purpose:
-- Stores reusable chore templates that can be
-- assigned to household members.
-- ==============================================

CREATE TABLE chore (

    chore_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    chore_category_id UUID NOT NULL,

    chore_name VARCHAR(100) NOT NULL,

    chore_description TEXT,

    difficulty VARCHAR(20) NOT NULL,

    default_points INTEGER NOT NULL,

    estimated_duration_minutes INTEGER,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT fk_chore_category
        FOREIGN KEY (chore_category_id)
        REFERENCES chore_category(chore_category_id),


    CONSTRAINT chk_chore_difficulty
        CHECK (difficulty IN ('EASY', 'MEDIUM', 'HARD')),


    CONSTRAINT chk_default_points
        CHECK (default_points >= 0),


    CONSTRAINT chk_estimated_duration
        CHECK (
            estimated_duration_minutes IS NULL
            OR estimated_duration_minutes > 0
        )

);

-- ==============================================
-- Table: assignment_status
-- Purpose:
-- Stores workflow statuses for assignments.
-- ==============================================

CREATE TABLE assignment_status (

    assignment_status_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    status_code VARCHAR(50) NOT NULL,

    status_name VARCHAR(100) NOT NULL,

    display_order INTEGER NOT NULL,

    is_terminal BOOLEAN NOT NULL DEFAULT FALSE,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT uq_assignment_status_code
        UNIQUE (status_code),


    CONSTRAINT chk_display_order
        CHECK (display_order > 0)

);

-- ==============================================
-- Table: assignment
-- Purpose:
-- Stores individual chore assignments.
-- ==============================================

CREATE TABLE assignment (

    assignment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    chore_id UUID NOT NULL,

    app_user_id UUID NOT NULL,

    assignment_status_id UUID NOT NULL,

    assigned_by UUID NOT NULL,

    assigned_at TIMESTAMPTZ NOT NULL,

    assigned_for_date DATE,

    due_date TIMESTAMPTZ,

    completed_at TIMESTAMPTZ,

    approved_at TIMESTAMPTZ,

    approved_by UUID,

    default_points INTEGER NOT NULL,

    awarded_points INTEGER,

    awarded_points_reason TEXT,

    parent_comment TEXT,

    child_comment TEXT,

    proof_of_completion_url TEXT,

    completion_percentage INTEGER DEFAULT 0,

    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT fk_assignment_chore
        FOREIGN KEY (chore_id)
        REFERENCES chore(chore_id),


    CONSTRAINT fk_assignment_user
        FOREIGN KEY (app_user_id)
        REFERENCES app_user(app_user_id),


    CONSTRAINT fk_assignment_status
        FOREIGN KEY (assignment_status_id)
        REFERENCES assignment_status(assignment_status_id),


    CONSTRAINT fk_assignment_assigned_by
        FOREIGN KEY (assigned_by)
        REFERENCES app_user(app_user_id),


    CONSTRAINT fk_assignment_approved_by
        FOREIGN KEY (approved_by)
        REFERENCES app_user(app_user_id),


    CONSTRAINT chk_completion_percentage
        CHECK (
            completion_percentage BETWEEN 0 AND 100
        ),


    CONSTRAINT chk_default_points
        CHECK (default_points >= 0),


    CONSTRAINT chk_awarded_points
        CHECK (
            awarded_points IS NULL
            OR awarded_points >= 0
        )

);

-- ==============================================
-- Table: point_transaction
-- Purpose:
-- Stores the ledger of all point movements.
-- ==============================================

CREATE TABLE point_transaction (

    point_transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    assignment_id UUID,

    app_user_id UUID NOT NULL,

    transaction_type VARCHAR(30) NOT NULL,

    point_amount INTEGER NOT NULL,

    transaction_at TIMESTAMPTZ NOT NULL,

    transaction_description TEXT,


    created_at TIMESTAMPTZ NOT NULL,

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT fk_point_transaction_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES assignment(assignment_id),


    CONSTRAINT fk_point_transaction_user
        FOREIGN KEY (app_user_id)
        REFERENCES app_user(app_user_id),


    CONSTRAINT chk_transaction_type
        CHECK (
            transaction_type IN (
                'ASSIGNMENT',
                'REWARD_REDEMPTION',
                'BONUS',
                'PENALTY',
                'MANUAL_ADJUSTMENT'
            )
        )

);

-- ==============================================
-- Table: reward
-- Purpose:
-- Stores household rewards.
-- ==============================================

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

-- ==============================================
-- Table: reward_redemption
-- Purpose:
-- Stores reward redemption transactions performed
-- by household members.
-- ==============================================

CREATE TABLE reward_redemption (

    redemption_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    redemption_reference_no VARCHAR(30) NOT NULL,

    reward_id UUID NOT NULL,

    redeemed_by UUID NOT NULL,

    points_used INTEGER NOT NULL,

    redemption_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    redemption_status VARCHAR(20) NOT NULL DEFAULT 'Pending',

    approved_by UUID,

    approved_at TIMESTAMPTZ,

    comment TEXT,


    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    created_by UUID,

    updated_at TIMESTAMPTZ,

    updated_by UUID,

    deleted_at TIMESTAMPTZ,

    deleted_by UUID,

    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,


    CONSTRAINT uq_reward_redemption_reference_no
        UNIQUE (redemption_reference_no),


    CONSTRAINT fk_reward_redemption_reward
        FOREIGN KEY (reward_id)
        REFERENCES reward(reward_id),


    CONSTRAINT fk_reward_redemption_redeemed_by
        FOREIGN KEY (redeemed_by)
        REFERENCES app_user(app_user_id),


    CONSTRAINT fk_reward_redemption_approved_by
        FOREIGN KEY (approved_by)
        REFERENCES app_user(app_user_id),


    CONSTRAINT chk_reward_redemption_status
        CHECK (
            redemption_status IN
            (
                'Pending',
                'Approved',
                'Rejected',
                'Cancelled'
            )
        )

);