/*
====================================================
Table: assignment_status

Purpose:
Stores workflow statuses for assignments.

Sprint:
Sprint 1.5
====================================================
*/

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