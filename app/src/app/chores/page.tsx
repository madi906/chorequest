import { supabase } from "@/lib/supabase";

export default async function ChoresPage() {
  const { data: chores, error: choresError } = await supabase
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

  const { data: assignments, error: assignmentsError } = await supabase
    .from("assignment")
    .select(`
      assignment_id,
      assigned_for_date,
      due_date,
      default_points,
      awarded_points,
      completion_percentage,
      completed_at,
      approved_at,
      chore:fk_assignment_chore (
        chore_name,
        difficulty
      ),
      assigned_user:fk_assignment_user (
        app_user_id,
        app_user_name,
        user_role
      ),
      assignment_status:fk_assignment_status (
        status_code,
        status_name
      )
    `)
    .eq("is_deleted", false)
    .order("assigned_for_date", { ascending: false });

  if (choresError || assignmentsError) {
    return (
      <section>
        <h1 className="text-3xl font-bold">Chores</h1>

        <p className="mt-2 text-red-600">
          Unable to load chore management data.
        </p>

        {choresError && (
          <pre className="mt-4 rounded-lg bg-gray-100 p-4 text-sm">
            Chore error: {choresError.message}
          </pre>
        )}

        {assignmentsError && (
          <pre className="mt-4 rounded-lg bg-gray-100 p-4 text-sm">
            Assignment error: {assignmentsError.message}
          </pre>
        )}
      </section>
    );
  }

  return (
    <section className="space-y-10">
      <header>
        <p className="text-sm font-medium text-gray-500">
          Chore Management
        </p>

        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          Chores
        </h1>

        <p className="mt-2 text-gray-600">
          Manage the household chore catalogue and assignments.
        </p>
      </header>

      {/* ============================================================
          Current Assignments
          ============================================================ */}

      <section className="space-y-4">
        <div>
          <h2 className="text-xl font-semibold">
            Current Assignments
          </h2>

          <p className="mt-1 text-sm text-gray-500">
            Chores assigned to household members.
          </p>
        </div>

        <div className="overflow-hidden rounded-xl border bg-white">
          <div className="divide-y">
            {assignments?.map((assignment) => (
              <article
                key={assignment.assignment_id}
                className="p-5"
              >
                <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                  <div>
                    <h3 className="font-semibold">
                      {assignment.chore?.[0]?.chore_name}
                    </h3>

                    <p className="mt-1 text-sm text-gray-500">
                      Assigned to{" "}
                      <span className="font-medium text-gray-700">
                        {assignment.assigned_user?.[0]?.app_user_name}
                      </span>
                    </p>
                  </div>

                  <span className="w-fit rounded-full bg-gray-100 px-3 py-1 text-xs font-semibold uppercase">
                    {assignment.assignment_status?.[0]?.status_name}
                  </span>
                </div>

                <div className="mt-4 grid gap-3 text-sm sm:grid-cols-2 lg:grid-cols-4">
                  <div>
                    <p className="text-gray-500">Points</p>
                    <p className="font-semibold">
                      ⭐{" "}
                      {assignment.awarded_points ??
                        assignment.default_points}
                    </p>
                  </div>

                  <div>
                    <p className="text-gray-500">Completion</p>
                    <p className="font-semibold">
                      {assignment.completion_percentage}%
                    </p>
                  </div>

                  <div>
                    <p className="text-gray-500">Assigned for</p>
                    <p className="font-semibold">
                      {new Date(
                        assignment.assigned_for_date
                      ).toLocaleDateString()}
                    </p>
                  </div>

                  <div>
                    <p className="text-gray-500">Due</p>
                    <p className="font-semibold">
                      {assignment.due_date
                        ? new Date(
                            assignment.due_date
                          ).toLocaleString()
                        : "—"}
                    </p>
                  </div>
                </div>
              </article>
            ))}
          </div>
        </div>
      </section>

      {/* ============================================================
          Chore Catalogue
          ============================================================ */}

      <section className="space-y-4">
        <div>
          <h2 className="text-xl font-semibold">
            Chore Catalogue
          </h2>

          <p className="mt-1 text-sm text-gray-500">
            Reusable chores available for assignment.
          </p>
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          {chores?.map((chore) => (
            <article
              key={chore.chore_id}
              className="rounded-xl border bg-white p-6 shadow-sm"
            >
              <div className="flex items-start justify-between gap-4">
                <div>
                  <h3 className="text-lg font-semibold">
                    {chore.chore_name}
                  </h3>

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
    </section>
  );
}
