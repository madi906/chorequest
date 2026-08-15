import { supabase } from "@/lib/supabase";

export default async function ChoresPage() {
  const { data: chores, error } = await supabase
    .from("chore")
    .select(`
      chore_id,
      chore_name,
      chore_description,
      difficulty,
      default_points,
      estimated_duration_minutes,
      chore_category (
        chore_category_name
      )
    `)
    .eq("is_deleted", false)
    .eq("is_active", true)
    .order("chore_name");

  if (error) {
    return (
      <section>
        <h1 className="text-3xl font-bold">Chores</h1>
        <p className="mt-2 text-red-600">
          Unable to load chores.
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
        <p className="text-sm font-medium text-gray-500">Chore Management</p>
        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          Chores
        </h1>
        <p className="mt-2 text-gray-600">
          View and manage the chores available to your household.
        </p>
      </header>

      <div className="grid gap-4 md:grid-cols-2">
        {chores?.map((chore) => (
          <article
            key={chore.chore_id}
            className="rounded-xl border bg-white p-6 shadow-sm"
          >
            <div className="flex items-start justify-between gap-4">
              <div>
                <h2 className="text-lg font-semibold">
                  {chore.chore_name}
                </h2>

                <p className="mt-1 text-sm text-gray-500">
                  {chore.chore_category?.[0]?.chore_category_name}
                </p>
              </div>

              <span className="rounded-full bg-gray-100 px-3 py-1 text-xs font-semibold uppercase">
                {chore.difficulty}
              </span>
            </div>

            <p className="mt-4 text-sm text-gray-600">
              {chore.chore_description}
            </p>

            <div className="mt-5 flex items-center gap-4 text-sm">
              <span className="font-semibold">
                ⭐ {chore.default_points} points
              </span>

              {chore.estimated_duration_minutes && (
                <span className="text-gray-500">
                  ⏱ {chore.estimated_duration_minutes} min
                </span>
              )}
            </div>
          </article>
        ))}
      </div>
    </section>
  );
}
