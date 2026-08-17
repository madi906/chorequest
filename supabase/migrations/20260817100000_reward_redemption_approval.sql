/*
====================================================
Migration:
20260817100000_reward_redemption_approval.sql

Purpose:
Implement parent approval/rejection workflow for
reward redemptions.

Workflow:

PENDING
   ├── APPROVE ──> APPROVED
   │
   └── REJECT ──> REJECTED
                    │
                    └── Refund points

Rules:
1. Only active PARENT users can approve/reject.
2. Parent must belong to the same household.
3. Only Pending redemptions can be processed.
4. Approval does not create another point transaction.
5. Rejection refunds the points previously deducted.
6. A redemption cannot be approved/rejected twice.
7. Operations are atomic.

====================================================
*/


/*
====================================================
Approve Reward Redemption
====================================================
*/

CREATE OR REPLACE FUNCTION approve_reward_redemption(
    p_redemption_id UUID,
    p_approved_by UUID,
    p_comment TEXT DEFAULT NULL
)
RETURNS TABLE (
    redemption_id UUID,
    redemption_reference_no VARCHAR(30),
    redemption_status VARCHAR(20),
    approved_by UUID,
    approved_at TIMESTAMPTZ
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_redemption reward_redemption%ROWTYPE;
    v_parent app_user%ROWTYPE;
    v_child app_user%ROWTYPE;
BEGIN

    /*
    ====================================================
    Validate approving parent
    ====================================================
    */

    SELECT au.*
    INTO v_parent
    FROM app_user AS au
    WHERE au.app_user_id = p_approved_by
      AND au.user_role = 'PARENT'
      AND au.is_active = TRUE
      AND au.is_deleted = FALSE
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Approving user is not an active parent.';
    END IF;


    /*
    ====================================================
    Lock redemption
    ====================================================
    */

    SELECT rr.*
    INTO v_redemption
    FROM reward_redemption AS rr
    WHERE rr.redemption_id = p_redemption_id
      AND rr.is_deleted = FALSE
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Reward redemption not found.';
    END IF;


    /*
    ====================================================
    Validate child
    ====================================================
    */

    SELECT au.*
    INTO v_child
    FROM app_user AS au
    WHERE au.app_user_id = v_redemption.redeemed_by
      AND au.is_active = TRUE
      AND au.is_deleted = FALSE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Redeeming child user not found or inactive.';
    END IF;


    /*
    ====================================================
    Validate household
    ====================================================
    */

    IF v_parent.household_id <> v_child.household_id THEN
        RAISE EXCEPTION
            'Parent and child must belong to the same household.';
    END IF;


    /*
    ====================================================
    Validate redemption status
    ====================================================
    */

    IF v_redemption.redemption_status <> 'Pending' THEN
        RAISE EXCEPTION
            'Only Pending redemptions can be approved. Current status: %.',
            v_redemption.redemption_status;
    END IF;


    /*
    ====================================================
    Approve redemption
    ====================================================
    */

    UPDATE reward_redemption
    SET
        redemption_status = 'Approved',
        approved_by = p_approved_by,
        approved_at = NOW(),
        comment = COALESCE(p_comment, comment),
        updated_at = NOW(),
        updated_by = p_approved_by
    WHERE reward_redemption.redemption_id =
          v_redemption.redemption_id;


    /*
    ====================================================
    Return result
    ====================================================
    */

    redemption_id := v_redemption.redemption_id;
    redemption_reference_no :=
        v_redemption.redemption_reference_no;
    redemption_status := 'Approved';
    approved_by := p_approved_by;
    approved_at := NOW();

    RETURN NEXT;

END;
$$;


/*
====================================================
Reject Reward Redemption
====================================================
*/

CREATE OR REPLACE FUNCTION reject_reward_redemption(
    p_redemption_id UUID,
    p_rejected_by UUID,
    p_comment TEXT DEFAULT NULL
)
RETURNS TABLE (
    redemption_id UUID,
    redemption_reference_no VARCHAR(30),
    redemption_status VARCHAR(20),
    refunded_points INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_redemption reward_redemption%ROWTYPE;
    v_parent app_user%ROWTYPE;
    v_child app_user%ROWTYPE;
BEGIN

    /*
    ====================================================
    Validate rejecting parent
    ====================================================
    */

    SELECT au.*
    INTO v_parent
    FROM app_user AS au
    WHERE au.app_user_id = p_rejected_by
      AND au.user_role = 'PARENT'
      AND au.is_active = TRUE
      AND au.is_deleted = FALSE
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Rejecting user is not an active parent.';
    END IF;


    /*
    ====================================================
    Lock redemption
    ====================================================
    */

    SELECT rr.*
    INTO v_redemption
    FROM reward_redemption AS rr
    WHERE rr.redemption_id = p_redemption_id
      AND rr.is_deleted = FALSE
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Reward redemption not found.';
    END IF;


    /*
    ====================================================
    Validate child
    ====================================================
    */

    SELECT au.*
    INTO v_child
    FROM app_user AS au
    WHERE au.app_user_id = v_redemption.redeemed_by
      AND au.is_active = TRUE
      AND au.is_deleted = FALSE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Redeeming child user not found or inactive.';
    END IF;


    /*
    ====================================================
    Validate household
    ====================================================
    */

    IF v_parent.household_id <> v_child.household_id THEN
        RAISE EXCEPTION
            'Parent and child must belong to the same household.';
    END IF;


    /*
    ====================================================
    Validate redemption status
    ====================================================
    */

    IF v_redemption.redemption_status <> 'Pending' THEN
        RAISE EXCEPTION
            'Only Pending redemptions can be rejected. Current status: %.',
            v_redemption.redemption_status;
    END IF;


    /*
    ====================================================
    Reject redemption
    ====================================================
    */

    UPDATE reward_redemption
    SET
        redemption_status = 'Rejected',
        comment = COALESCE(
            p_comment,
            'Reward redemption rejected.'
        ),
        updated_at = NOW(),
        updated_by = p_rejected_by
    WHERE reward_redemption.redemption_id =
          v_redemption.redemption_id;


    /*
    ====================================================
    Refund points

    The original redemption already created:

        -points_used

    Rejection therefore creates:

        +points_used
    ====================================================
    */

    INSERT INTO point_transaction (
        app_user_id,
        transaction_type,
        point_amount,
        transaction_at,
        transaction_description,
        created_at,
        created_by
    )
    VALUES (
        v_redemption.redeemed_by,
        'REWARD_REFUND',
        v_redemption.points_used,
        NOW(),
        'Refund for rejected reward redemption '
            || v_redemption.redemption_reference_no,
        NOW(),
        p_rejected_by
    );


    /*
    ====================================================
    Return result
    ====================================================
    */

    redemption_id := v_redemption.redemption_id;
    redemption_reference_no :=
        v_redemption.redemption_reference_no;
    redemption_status := 'Rejected';
    refunded_points := v_redemption.points_used;

    RETURN NEXT;

END;
$$;


/*
====================================================
Function permissions
====================================================
*/

GRANT EXECUTE ON FUNCTION approve_reward_redemption(
    UUID,
    UUID,
    TEXT
) TO anon, authenticated;

GRANT EXECUTE ON FUNCTION reject_reward_redemption(
    UUID,
    UUID,
    TEXT
) TO anon, authenticated;