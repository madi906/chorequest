-- ============================================================
-- ChoreQuest
-- Configure API permissions for dashboard read access
-- ============================================================

GRANT SELECT ON TABLE public.point_transaction TO anon;
GRANT SELECT ON TABLE public.reward TO anon;


-- Verification
SELECT
    grantee,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name IN ('point_transaction', 'reward')
  AND grantee = 'anon'
  AND privilege_type = 'SELECT'
ORDER BY table_name, privilege_type;
