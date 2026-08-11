/*
====================================================
File: seed.sql

Purpose:
Development seed data for ChoreQuest.

Environment:
Local Supabase development only.

====================================================
*/

-- ====================================================
-- Household
-- ====================================================

INSERT INTO household (
    household_id,
    household_name,
    household_description,
    is_active,
    created_at
)
VALUES (
    '11111111-1111-1111-1111-111111111111',
    'Hadi Family',
    'Development household for ChoreQuest testing.',
    TRUE,
    NOW()
);

-- ====================================================
-- App Users
-- ====================================================

INSERT INTO app_user (
    app_user_id,
    household_id,
    app_user_name,
    user_role,
    is_active,
    created_at
)
VALUES
(
    '21111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    'Papa',
    'PARENT',
    TRUE,
    NOW()
),
(
    '22222222-2222-2222-2222-222222222222',
    '11111111-1111-1111-1111-111111111111',
    'Mama',
    'PARENT',
    TRUE,
    NOW()
),
(
    '23333333-3333-3333-3333-333333333333',
    '11111111-1111-1111-1111-111111111111',
    'Izhar',
    'CHILD',
    TRUE,
    NOW()
),
(
    '24444444-4444-4444-4444-444444444444',
    '11111111-1111-1111-1111-111111111111',
    'Irham',
    'CHILD',
    TRUE,
    NOW()
),
(
    '25555555-5555-5555-5555-555555555555',
    '11111111-1111-1111-1111-111111111111',
    'Inara',
    'CHILD',
    TRUE,
    NOW()
);

-- ====================================================
-- Chore Categories
-- ====================================================

INSERT INTO chore_category (
    chore_category_id,
    household_id,
    chore_category_name,
    is_active,
    created_at
)
VALUES
(
    '31111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    'Cleaning',
    TRUE,
    NOW()
),
(
    '32222222-2222-2222-2222-222222222222',
    '11111111-1111-1111-1111-111111111111',
    'Homework',
    TRUE,
    NOW()
),
(
    '33333333-3333-3333-3333-333333333333',
    '11111111-1111-1111-1111-111111111111',
    'Outdoor',
    TRUE,
    NOW()
),
(
    '34444444-4444-4444-4444-444444444444',
    '11111111-1111-1111-1111-111111111111',
    'Personal',
    TRUE,
    NOW()
),
(
    '35555555-5555-5555-5555-555555555555',
    '11111111-1111-1111-1111-111111111111',
    'Family',
    TRUE,
    NOW()
);

-- ====================================================
-- Chores
-- ====================================================

INSERT INTO chore (
    chore_id,
    chore_category_id,
    chore_name,
    chore_description,
    difficulty,
    default_points,
    estimated_duration_minutes,
    is_active,
    created_at
)
VALUES
(
    '41111111-1111-1111-1111-111111111111',
    '31111111-1111-1111-1111-111111111111',
    'Wash dishes',
    'Wash and put away the dishes after a meal.',
    'EASY',
    10,
    15,
    TRUE,
    NOW()
),
(
    '42222222-2222-2222-2222-222222222222',
    '32222222-2222-2222-2222-222222222222',
    'Complete homework',
    'Complete assigned school homework.',
    'MEDIUM',
    15,
    45,
    TRUE,
    NOW()
),
(
    '43333333-3333-3333-3333-333333333333',
    '31111111-1111-1111-1111-111111111111',
    'Sweep and mop floor',
    'Sweep and mop the designated floor area.',
    'MEDIUM',
    20,
    30,
    TRUE,
    NOW()
),
(
    '44444444-4444-4444-4444-444444444444',
    '34444444-4444-4444-4444-444444444444',
    'Clean bedroom',
    'Tidy the bedroom, arrange belongings, and keep the floor clean.',
    'MEDIUM',
    25,
    30,
    TRUE,
    NOW()
),
(
    '45555555-5555-5555-5555-555555555555',
    '32222222-2222-2222-2222-222222222222',
    'Read for 30 minutes',
    'Read a book or approved educational material for 30 minutes.',
    'EASY',
    10,
    30,
    TRUE,
    NOW()
),
(
    '46666666-6666-6666-6666-666666666666',
    '33333333-3333-3333-3333-333333333333',
    'Water plants',
    'Water the household plants and garden.',
    'EASY',
    10,
    15,
    TRUE,
    NOW()
),
(
    '47777777-7777-7777-7777-777777777777',
    '35555555-5555-5555-5555-555555555555',
    'Take out rubbish',
    'Collect household rubbish and place it in the appropriate bin.',
    'EASY',
    10,
    10,
    TRUE,
    NOW()
),
(
    '48888888-8888-8888-8888-888888888888',
    '35555555-5555-5555-5555-555555555555',
    'Help with grocery shopping',
    'Help a parent with grocery shopping and carrying items.',
    'HARD',
    30,
    60,
    TRUE,
    NOW()
);

-- ====================================================
-- Assignment Statuses
-- ====================================================

INSERT INTO assignment_status (
    assignment_status_id,
    status_code,
    status_name,
    display_order,
    is_terminal,
    is_active,
    created_at
)
VALUES
(
    '51111111-1111-1111-1111-111111111111',
    'PENDING',
    'Pending',
    1,
    FALSE,
    TRUE,
    NOW()
),
(
    '52222222-2222-2222-2222-222222222222',
    'IN_PROGRESS',
    'In Progress',
    2,
    FALSE,
    TRUE,
    NOW()
),
(
    '53333333-3333-3333-3333-333333333333',
    'COMPLETED',
    'Completed',
    3,
    FALSE,
    TRUE,
    NOW()
),
(
    '54444444-4444-4444-4444-444444444444',
    'APPROVED',
    'Approved',
    4,
    TRUE,
    TRUE,
    NOW()
),
(
    '55555555-5555-5555-5555-555555555555',
    'REJECTED',
    'Rejected',
    5,
    TRUE,
    TRUE,
    NOW()
),
(
    '56666666-6666-6666-6666-666666666666',
    'CANCELLED',
    'Cancelled',
    6,
    TRUE,
    TRUE,
    NOW()
);

-- ====================================================
-- Assignments
-- ====================================================

INSERT INTO assignment (
    assignment_id,
    chore_id,
    app_user_id,
    assignment_status_id,
    assigned_by,
    assigned_at,
    assigned_for_date,
    due_date,
    completed_at,
    approved_at,
    approved_by,
    default_points,
    awarded_points,
    parent_comment,
    child_comment,
    completion_percentage,
    created_at
)
VALUES
(
    '61111111-1111-1111-1111-111111111111',
    '41111111-1111-1111-1111-111111111111',
    '23333333-3333-3333-3333-333333333333',
    '51111111-1111-1111-1111-111111111111',
    '21111111-1111-1111-1111-111111111111',
    NOW(),
    CURRENT_DATE,
    NOW() + INTERVAL '1 day',
    NULL,
    NULL,
    NULL,
    10,
    NULL,
    NULL,
    NULL,
    0,
    NOW()
),
(
    '62222222-2222-2222-2222-222222222222',
    '42222222-2222-2222-2222-222222222222',
    '23333333-3333-3333-3333-333333333333',
    '53333333-3333-3333-3333-333333333333',
    '22222222-2222-2222-2222-222222222222',
    NOW(),
    CURRENT_DATE,
    NOW(),
    NOW(),
    NULL,
    NULL,
    15,
    15,
    NULL,
    'Homework completed.',
    100,
    NOW()
),
(
    '63333333-3333-3333-3333-333333333333',
    '43333333-3333-3333-3333-333333333333',
    '24444444-4444-4444-4444-444444444444',
    '52222222-2222-2222-2222-222222222222',
    '21111111-1111-1111-1111-111111111111',
    NOW(),
    CURRENT_DATE,
    NOW() + INTERVAL '1 day',
    NULL,
    NULL,
    NULL,
    20,
    NULL,
    NULL,
    'Started sweeping the floor.',
    50,
    NOW()
),
(
    '64444444-4444-4444-4444-444444444444',
    '46666666-6666-6666-6666-666666666666',
    '24444444-4444-4444-4444-444444444444',
    '54444444-4444-4444-4444-444444444444',
    '22222222-2222-2222-2222-222222222222',
    NOW(),
    CURRENT_DATE - 1,
    NOW(),
    CURRENT_DATE - INTERVAL '1 day',
    CURRENT_DATE - INTERVAL '1 day',
    '22222222-2222-2222-2222-222222222222',
    10,
    10,
    'Great job.',
    'Plants are watered.',
    100,
    NOW()
),
(
    '65555555-5555-5555-5555-555555555555',
    '44444444-4444-4444-4444-444444444444',
    '25555555-5555-5555-5555-555555555555',
    '51111111-1111-1111-1111-111111111111',
    '21111111-1111-1111-1111-111111111111',
    NOW(),
    CURRENT_DATE,
    NOW() + INTERVAL '1 day',
    NULL,
    NULL,
    NULL,
    25,
    NULL,
    NULL,
    NULL,
    0,
    NOW()
),
(
    '66666666-6666-6666-6666-666666666666',
    '47777777-7777-7777-7777-777777777777',
    '25555555-5555-5555-5555-555555555555',
    '53333333-3333-3333-3333-333333333333',
    '21111111-1111-1111-1111-111111111111',
    NOW(),
    CURRENT_DATE - 1,
    NOW(),
    CURRENT_DATE - INTERVAL '1 day',
    NULL,
    NULL,
    10,
    10,
    NULL,
    'Done!',
    100,
    NOW()
);

-- ====================================================
-- Additional Approved Assignments
-- ====================================================

INSERT INTO assignment (
    assignment_id,
    chore_id,
    app_user_id,
    assignment_status_id,
    assigned_by,
    assigned_at,
    assigned_for_date,
    due_date,
    completed_at,
    approved_at,
    approved_by,
    default_points,
    awarded_points,
    parent_comment,
    child_comment,
    completion_percentage,
    created_at
)
VALUES
(
    '67777777-7777-7777-7777-777777777777',
    '47777777-7777-7777-7777-777777777777',
    '24444444-4444-4444-4444-444444444444',
    '54444444-4444-4444-4444-444444444444',
    '21111111-1111-1111-1111-111111111111',
    CURRENT_DATE - INTERVAL '3 days',
    CURRENT_DATE - 3,
    CURRENT_DATE - INTERVAL '2 days',
    CURRENT_DATE - INTERVAL '3 days',
    CURRENT_DATE - INTERVAL '2 days',
    '21111111-1111-1111-1111-111111111111',
    10,
    10,
    'Good job.',
    'Rubbish taken out.',
    100,
    NOW()
),
(
    '68888888-8888-8888-8888-888888888888',
    '41111111-1111-1111-1111-111111111111',
    '24444444-4444-4444-4444-444444444444',
    '54444444-4444-4444-4444-444444444444',
    '22222222-2222-2222-2222-222222222222',
    CURRENT_DATE - INTERVAL '2 days',
    CURRENT_DATE - 2,
    CURRENT_DATE - INTERVAL '1 day',
    CURRENT_DATE - INTERVAL '2 days',
    CURRENT_DATE - INTERVAL '1 day',
    '22222222-2222-2222-2222-222222222222',
    10,
    10,
    'Well done.',
    'Dishes are done.',
    100,
    NOW()
),
(
    '69999999-9999-9999-9999-999999999999',
    '48888888-8888-8888-8888-888888888888',
    '24444444-4444-4444-4444-444444444444',
    '54444444-4444-4444-4444-444444444444',
    '21111111-1111-1111-1111-111111111111',
    CURRENT_DATE - INTERVAL '5 days',
    CURRENT_DATE - 5,
    CURRENT_DATE - INTERVAL '4 days',
    CURRENT_DATE - INTERVAL '5 days',
    CURRENT_DATE - INTERVAL '4 days',
    '21111111-1111-1111-1111-111111111111',
    30,
    30,
    'Great help with the groceries.',
    'I helped with the groceries.',
    100,
    NOW()
),
(
    '6aaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    '43333333-3333-3333-3333-333333333333',
    '24444444-4444-4444-4444-444444444444',
    '54444444-4444-4444-4444-444444444444',
    '22222222-2222-2222-2222-222222222222',
    CURRENT_DATE - INTERVAL '4 days',
    CURRENT_DATE - 4,
    CURRENT_DATE - INTERVAL '3 days',
    CURRENT_DATE - INTERVAL '4 days',
    CURRENT_DATE - INTERVAL '3 days',
    '22222222-2222-2222-2222-222222222222',
    20,
    20,
    'Floor looks great.',
    'Floor is clean.',
    100,
    NOW()
);

-- ====================================================
-- Point Transactions
-- ====================================================

INSERT INTO point_transaction (
    point_transaction_id,
    assignment_id,
    app_user_id,
    transaction_type,
    point_amount,
    transaction_at,
    transaction_description,
    created_at
)
VALUES
(
    '71111111-1111-1111-1111-111111111111',
    '64444444-4444-4444-4444-444444444444',
    '24444444-4444-4444-4444-444444444444',
    'ASSIGNMENT',
    10,
    CURRENT_DATE - INTERVAL '1 day',
    'Points awarded for completing and receiving approval for Water plants.',
    NOW()
);

-- ====================================================
-- Additional Point Transactions
-- ====================================================

INSERT INTO point_transaction (
    point_transaction_id,
    assignment_id,
    app_user_id,
    transaction_type,
    point_amount,
    transaction_at,
    transaction_description,
    created_at
)
VALUES
(
    '72222222-2222-2222-2222-222222222222',
    '67777777-7777-7777-7777-777777777777',
    '24444444-4444-4444-4444-444444444444',
    'ASSIGNMENT',
    10,
    CURRENT_DATE - INTERVAL '2 days',
    'Points awarded for approved Take out rubbish assignment.',
    NOW()
),
(
    '73333333-3333-3333-3333-333333333333',
    '68888888-8888-8888-8888-888888888888',
    '24444444-4444-4444-4444-444444444444',
    'ASSIGNMENT',
    10,
    CURRENT_DATE - INTERVAL '1 day',
    'Points awarded for approved Wash dishes assignment.',
    NOW()
),
(
    '74444444-4444-4444-4444-444444444444',
    '69999999-9999-9999-9999-999999999999',
    '24444444-4444-4444-4444-444444444444',
    'ASSIGNMENT',
    30,
    CURRENT_DATE - INTERVAL '4 days',
    'Points awarded for approved Help with grocery shopping assignment.',
    NOW()
),
(
    '75555555-5555-5555-5555-555555555555',
    '6aaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    '24444444-4444-4444-4444-444444444444',
    'ASSIGNMENT',
    20,
    CURRENT_DATE - INTERVAL '3 days',
    'Points awarded for approved Sweep and mop floor assignment.',
    NOW()
);

-- ====================================================
-- Rewards
-- ====================================================

INSERT INTO reward (
    reward_id,
    household_id,
    reward_name,
    reward_type,
    point_cost,
    reward_description,
    available_quantity,
    display_order,
    is_active,
    created_at
)
VALUES
(
    '81111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    'LEGO set',
    'PHYSICAL',
    200,
    'A LEGO set selected by the parents.',
    2,
    1,
    TRUE,
    NOW()
),
(
    '82222222-2222-2222-2222-222222222222',
    '11111111-1111-1111-1111-111111111111',
    'Choose tonight''s movie',
    'PRIVILEGE',
    50,
    'Choose the movie the family watches tonight.',
    NULL,
    2,
    TRUE,
    NOW()
),
(
    '83333333-3333-3333-3333-333333333333',
    '11111111-1111-1111-1111-111111111111',
    'Family gaming session',
    'ACTIVITY',
    100,
    'Choose a family gaming activity.',
    NULL,
    3,
    TRUE,
    NOW()
),
(
    '84444444-4444-4444-4444-444444444444',
    '11111111-1111-1111-1111-111111111111',
    'RM5 pocket money',
    'MONEY',
    75,
    'Receive RM5 pocket money.',
    10,
    4,
    TRUE,
    NOW()
),
(
    '85555555-5555-5555-5555-555555555555',
    '11111111-1111-1111-1111-111111111111',
    'Skip one chore',
    'CUSTOM',
    150,
    'Skip one eligible chore with parent approval.',
    3,
    5,
    TRUE,
    NOW()
);

-- ====================================================
-- Reward Redemptions
-- ====================================================

INSERT INTO reward_redemption (
    redemption_id,
    redemption_reference_no,
    reward_id,
    redeemed_by,
    points_used,
    redemption_at,
    redemption_status,
    approved_by,
    approved_at,
    comment,
    created_at,
    created_by
)
VALUES
(
    '86666666-6666-6666-6666-666666666666',
    'RED-20260810-0001',
    '84444444-4444-4444-4444-444444444444',
    '24444444-4444-4444-4444-444444444444',
    75,
    NOW(),
    'Approved',
    '21111111-1111-1111-1111-111111111111',
    NOW(),
    'Approved - enjoy your pocket money.',
    NOW(),
    '21111111-1111-1111-1111-111111111111'
);

-- ====================================================
-- Reward Redemption Point Transaction
-- ====================================================

INSERT INTO point_transaction (
    point_transaction_id,
    app_user_id,
    transaction_type,
    point_amount,
    transaction_at,
    transaction_description,
    created_at,
    created_by
)
VALUES
(
    '76666666-6666-6666-6666-666666666666',
    '24444444-4444-4444-4444-444444444444',
    'REWARD_REDEMPTION',
    -75,
    NOW(),
    'Redeemed RM5 pocket money - RED-20260810-0001.',
    NOW(),
    '21111111-1111-1111-1111-111111111111'
);