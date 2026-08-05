/*
====================================================
Table: chore

Purpose:
Stores reusable chore templates that can be assigned
to household members.

Sprint:
Sprint 1.4
====================================================
*/

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