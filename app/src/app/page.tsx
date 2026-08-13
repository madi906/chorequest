import { supabase } from "@/lib/supabase";

export default async function Home() {
  const { data: household, error: householdError } = await supabase
    .from("household")
    .select("household_id, household_name")
    .limit(1)
    .single();

  if (householdError) {
    return (
      <main>
        <h1>ChoreQuest</h1>
        <p>Unable to load household.</p>
        <pre>{householdError.message}</pre>
      </main>
    );
  }

  const { data: users, error: usersError } = await supabase
    .from("app_user")
    .select("app_user_id, app_user_name, user_role, is_active")
    .eq("household_id", household.household_id)
    .eq("is_active", true)
    .order("user_role")
    .order("app_user_name");

  if (usersError) {
    return (
      <main>
        <h1>ChoreQuest</h1>
        <p>Unable to load family members.</p>
        <pre>{usersError.message}</pre>
      </main>
    );
  }

  return (
    <main>
      <h1>{household.household_name}</h1>
      <p>Family members</p>

      <ul>
        {users?.map((user) => (
          <li key={user.app_user_id}>
            {user.app_user_name} — {user.user_role}
          </li>
        ))}
      </ul>
    </main>
  );
}

  
