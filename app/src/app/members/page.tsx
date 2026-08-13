import { supabase } from "@/lib/supabase";

export default async function MembersPage() {
  const { data: users, error } = await supabase
    .from("app_user")
    .select("app_user_id, app_user_name, user_role")
    .order("app_user_name");

  if (error) {
    return (
      <section>
        <h1 className="text-3xl font-bold">Family Members</h1>
        <p className="mt-2 text-red-600">
          Unable to load family members.
        </p>
        <pre className="mt-4 rounded-lg bg-gray-100 p-4 text-sm">
          {error.message}
        </pre>
      </section>
    );
  }

  return (
    <section className="space-y-6">
      <header>
        <p className="text-sm font-medium text-gray-500">Family</p>
        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          Family Members
        </h1>
        <p className="mt-2 text-gray-600">
          View the members of your ChoreQuest household.
        </p>
      </header>

      <div className="overflow-hidden rounded-xl border bg-white">
        <ul className="divide-y">
          {users?.map((user) => (
            <li
              key={user.app_user_id}
              className="flex items-center justify-between px-6 py-4"
            >
              <span className="font-medium">{user.app_user_name}</span>

              <span className="rounded-full bg-gray-100 px-3 py-1 text-xs font-semibold uppercase">
                {user.user_role}
              </span>
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}
