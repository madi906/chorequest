/*
====================================================
Table: point_transaction

Purpose:
Stores the ledger of all point movements.

Sprint:
Sprint 1.7
====================================================
*/

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