/*
====================================================
Table: reward_redemption

Purpose:
Stores reward redemption transactions performed by
household members.

Sprint:
Sprint 1.9
====================================================
*/

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