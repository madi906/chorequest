/*
====================================================
Migration:
20260816100000_reward_redemption_transaction.sql

Purpose:
Implement atomic reward redemption.

The function:
1. Validates the child.
2. Validates the reward.
3. Calculates the current point balance.
4. Validates sufficient points.
5. Validates reward availability.
6. Generates a household-based redemption reference.
7. Creates reward_redemption.
8. Creates a negative point_transaction.
9. Decrements reward quantity when applicable.

Reference format:
HF-YYYYMMDD-NNNN

Example:
HF-20260816-0001
====================================================
*/

CREATE OR REPLACE FUNCTION redeem_reward(
    p_reward_id UUID,
    p_redeemed_by UUID,
    p_comment TEXT DEFAULT NULL
)
RETURNS TABLE (
    redemption_id UUID,
    redemption_reference_no VARCHAR(30),
    reward_id UUID,
    redeemed_by UUID,
    points_used INTEGER,
    redemption_status VARCHAR(20)
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_reward reward%ROWTYPE;
    v_child app_user%ROWTYPE;
    v_household household%ROWTYPE;

    v_point_balance INTEGER;
    v_reference_prefix VARCHAR(20);
    v_reference_no VARCHAR(30);
    v_sequence INTEGER;
    v_redemption_id UUID;
BEGIN

    /*
    ====================================================
    Validate child
    ====================================================
    */

    SELECT au.*
    INTO v_child
    FROM app_user AS au
    WHERE au.app_user_id = p_redeemed_by
      AND au.is_active = TRUE
      AND au.is_deleted = FALSE
      AND au.user_role = 'CHILD'
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Child user not found or inactive.';
    END IF;


    /*
    ====================================================
    Get household
    ====================================================
    */

    SELECT h.*
    INTO v_household
    FROM household AS h
    WHERE h.household_id = v_child.household_id
      AND h.is_active = TRUE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Household not found or inactive.';
    END IF;


    /*
    ====================================================
    Validate reward
    ====================================================
    */

    SELECT r.*
    INTO v_reward
    FROM reward AS r
    WHERE r.reward_id = p_reward_id
      AND r.household_id = v_child.household_id
      AND r.is_active = TRUE
      AND r.is_deleted = FALSE
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reward not found or inactive.';
    END IF;


    /*
    ====================================================
    Calculate current point balance
    ====================================================
    */

    SELECT COALESCE(SUM(pt.point_amount), 0)
    INTO v_point_balance
    FROM point_transaction AS pt
    WHERE pt.app_user_id = p_redeemed_by
      AND pt.is_deleted = FALSE;


    /*
    ====================================================
    Validate points
    ====================================================
    */

    IF v_point_balance < v_reward.point_cost THEN
        RAISE EXCEPTION
            'Insufficient points. Current balance: %, required: %.',
            v_point_balance,
            v_reward.point_cost;
    END IF;


    /*
    ====================================================
    Validate reward quantity
    ====================================================
    */

    IF v_reward.available_quantity IS NOT NULL
       AND v_reward.available_quantity <= 0 THEN

        RAISE EXCEPTION 'Reward is currently unavailable.';

    END IF;


    /*
    ====================================================
    Generate household reference prefix.

    Example:
    Hadi Family -> HF
    ====================================================
    */

    v_reference_prefix :=
        UPPER(
            LEFT(
                REGEXP_REPLACE(
                    v_household.household_name,
                    '^([[:alpha:]])[^[:space:]]*[[:space:]]+([[:alpha:]]).*',
                    '\1\2'
                ),
                2
            )
        );


    /*
    Fallback for single-word household names.
    */

    IF v_reference_prefix IS NULL
       OR LENGTH(v_reference_prefix) < 2 THEN

        v_reference_prefix :=
            UPPER(
                LEFT(
                    REGEXP_REPLACE(
                        v_household.household_name,
                        '[^[:alpha:]]',
                        '',
                        'g'
                    ),
                    2
                )
            );

    END IF;


    /*
    ====================================================
    Lock reference generation for this
    household/date combination.
    ====================================================
    */

    PERFORM pg_advisory_xact_lock(
        hashtextextended(
            v_household.household_id::TEXT
            || ':'
            || CURRENT_DATE::TEXT,
            0
        )
    );


    /*
    ====================================================
    Determine next daily sequence.
    ====================================================
    */

    SELECT
        COALESCE(
            MAX(
                CAST(
                    RIGHT(rr.redemption_reference_no, 4) AS INTEGER
                )
            ),
            0
        ) + 1
    INTO v_sequence
    FROM reward_redemption AS rr
    WHERE rr.redemption_reference_no LIKE
        v_reference_prefix
        || '-'
        || TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
        || '-%'
      AND rr.is_deleted = FALSE;


    /*
    ====================================================
    Build reference.

    Example:
    HF-20260816-0001
    ====================================================
    */

    v_reference_no :=
        v_reference_prefix
        || '-'
        || TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
        || '-'
        || LPAD(v_sequence::TEXT, 4, '0');


    /*
    ====================================================
    Create reward redemption.
    ====================================================
    */

    INSERT INTO reward_redemption (
        redemption_reference_no,
        reward_id,
        redeemed_by,
        points_used,
        redemption_at,
        redemption_status,
        comment,
        created_at
    )
    VALUES (
        v_reference_no,
        v_reward.reward_id,
        p_redeemed_by,
        v_reward.point_cost,
        NOW(),
        'Pending',
        p_comment,
        NOW()
    )
    RETURNING reward_redemption.redemption_id
    INTO v_redemption_id;


    /*
    ====================================================
    Create point ledger transaction.

    Redemption is represented as a negative transaction.
    ====================================================
    */

    INSERT INTO point_transaction (
        app_user_id,
        transaction_type,
        point_amount,
        transaction_at,
        transaction_description,
        created_at
    )
    VALUES (
        p_redeemed_by,
        'REWARD_REDEMPTION',
        -v_reward.point_cost,
        NOW(),
        'Reward redemption '
            || v_reference_no
            || ' - '
            || v_reward.reward_name,
        NOW()
    );


    /*
    ====================================================
    Reduce available quantity.

    Unlimited rewards remain NULL.
    ====================================================
    */

    IF v_reward.available_quantity IS NOT NULL THEN

        UPDATE reward AS r
        SET available_quantity = r.available_quantity - 1,
            updated_at = NOW()
        WHERE r.reward_id = v_reward.reward_id;

    END IF;


    /*
    ====================================================
    Return redemption information.
    ====================================================
    */

    redemption_id := v_redemption_id;
    redemption_reference_no := v_reference_no;
    reward_id := v_reward.reward_id;
    redeemed_by := p_redeemed_by;
    points_used := v_reward.point_cost;
    redemption_status := 'Pending';

    RETURN NEXT;

END;
$$;