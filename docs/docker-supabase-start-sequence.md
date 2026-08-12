# ChoreQuest - Docker / Supabase Local Start Sequence.

## Steps

1 - VS Code / Terminal ==> cd ~/chorequest
2 - Start Docker Desktop and wait until Docker is ready.
3 - VS Code / Terminal ==> supabase start

## Expected result

1 - supabase local development setup is running.
2 - and Studio: http://127.0.0.1:54323

## So your startup checklist should now be:

① Start Mac
       ↓
② Start Docker Desktop
       ↓
③ Wait for Docker to become ready
       ↓
④ cd ~/chorequest
       ↓
⑤ supabase start
       ↓
⑥ Open http://127.0.0.1:54323

## No supabase db reset.
## No manual docker start for all containers.

What supabase start does

Mac starts
   ↓
Docker Desktop starts
   ↓
supabase start
   ↓
Supabase containers start
   ↓
PostgreSQL + Studio + APIs + other services
   ↓
ChoreQuest development environment ready