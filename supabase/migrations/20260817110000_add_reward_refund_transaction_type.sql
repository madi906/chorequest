/*
====================================================
Migration:
20260817110000_add_reward_refund_transaction_type.sql

Purpose:
Allow rejected reward redemptions to refund points
through the point transaction ledger.

Adds:
REWARD_REFUND
====================================================
*/

ALTER TABLE point_transaction
DROP CONSTRAINT IF EXISTS chk_transaction_type;

ALTER TABLE point_transaction
ADD CONSTRAINT chk_transaction_type
CHECK (
    transaction_type IN (
        'ASSIGNMENT',
        'REWARD_REDEMPTION',
        'REWARD_REFUND',
        'BONUS',
        'PENALTY',
        'MANUAL_ADJUSTMENT'
    )
);