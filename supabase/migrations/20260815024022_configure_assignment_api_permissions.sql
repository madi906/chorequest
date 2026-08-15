-- ============================================================
-- ChoreQuest
-- Sprint 3.6.3-A
-- Configure API permissions for assignment read model
-- ============================================================

GRANT SELECT ON TABLE public.assignment TO anon;
GRANT SELECT ON TABLE public.assignment_status TO anon;

-- Verification
SELECT
    grantee,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name IN ('assignment', 'assignment_status')
  AND grantee = 'anon'
ORDER BY table_name, privilege_type;
