/*
====================================================
Table: assignment

Purpose:
Stores individual chore assignments.

Sprint:
Sprint 1.6
====================================================
*/

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