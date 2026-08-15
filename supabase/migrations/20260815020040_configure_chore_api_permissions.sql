-- ============================================================
-- ChoreQuest
-- Sprint 3.6.1
-- Configure API permissions for chore catalogue
-- ============================================================

GRANT SELECT ON TABLE public.chore TO anon;
GRANT SELECT ON TABLE public.chore_category TO anon;

-- Verification
SELECT
    grantee,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name IN ('chore', 'chore_category')
  AND grantee = 'anon'
ORDER BY table_name, privilege_type;
