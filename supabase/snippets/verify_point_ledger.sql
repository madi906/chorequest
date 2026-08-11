SELECT
    pt.point_transaction_id,
    au.app_user_name,
    pt.transaction_type,
    pt.point_amount,
    pt.transaction_description,
    pt.transaction_at
FROM point_transaction pt
JOIN app_user au
    ON au.app_user_id = pt.app_user_id
ORDER BY pt.transaction_at;

SELECT
    au.app_user_name,
    COALESCE(SUM(pt.point_amount), 0) AS current_points
FROM app_user au
LEFT JOIN point_transaction pt
    ON pt.app_user_id = au.app_user_id
    AND pt.is_deleted = FALSE
GROUP BY au.app_user_id, au.app_user_name
ORDER BY au.app_user_name;