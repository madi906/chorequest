GRANT SELECT ON TABLE public.app_user TO anon;

SELECT
    grantee,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name = 'app_user'
  AND grantee = 'anon'
ORDER BY privilege_type;