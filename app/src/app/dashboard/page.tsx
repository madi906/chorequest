import { supabase } from "@/lib/supabase";

const assignmentStatuses = [
  { code: "PENDING", label: "Pending" },
  { code: "IN_PROGRESS", label: "In Progress" },
  { code: "COMPLETED", label: "Completed" },
  { code: "APPROVED", label: "Approved" },
];

export default async function DashboardPage() {
  const [
    familyMembersResult,
    activeChoresResult,
    rewardsResult,
    statusesResult,
    assignmentsResult,
    childrenResult,
    pointTransactionsResult,
  ] = await Promise.all([
    supabase
      .from("app_user")
      .select("app_user_id", { count: "exact", head: true })
      .eq("is_active", true)
      .eq("is_deleted", false),
    supabase
      .from("chore")
      .select("chore_id", { count: "exact", head: true })
      .eq("is_active", true)
      .eq("is_deleted", false),
    supabase
      .from("reward")
      .select("reward_id", { count: "exact", head: true })
      .eq("is_active", true)
      .eq("is_deleted", false),
    supabase
      .from("assignment_status")
      .select("assignment_status_id, status_code")
      .in(
        "status_code",
        assignmentStatuses.map((status) => status.code)
      ),
    supabase
      .from("assignment")
      .select("assignment_status_id")
      .eq("is_deleted", false),
    supabase
      .from("app_user")
      .select("app_user_id, app_user_name")
      .eq("is_active", true)
      .eq("is_deleted", false)
      .eq("user_role", "CHILD")
      .order("app_user_name"),
    supabase
      .from("point_transaction")
      .select("app_user_id, point_amount")
      .eq("is_deleted", false),
  ]);

  const errors = [
    familyMembersResult.error,
    activeChoresResult.error,
    rewardsResult.error,
    statusesResult.error,
    assignmentsResult.error,
    childrenResult.error,
    pointTransactionsResult.error,
  ].filter((error) => error !== null);

  const statusIdsByCode = new Map(
    (statusesResult.data ?? []).map((status) => [
      status.status_code,
      status.assignment_status_id,
    ])
  );

  const assignmentCounts = new Map<string, number>();

  for (const assignment of assignmentsResult.data ?? []) {
    assignmentCounts.set(
      assignment.assignment_status_id,
      (assignmentCounts.get(assignment.assignment_status_id) ?? 0) + 1
    );
  }

  const pointsByUserId = new Map<string, number>();

  for (const transaction of pointTransactionsResult.data ?? []) {
    pointsByUserId.set(
      transaction.app_user_id,
      (pointsByUserId.get(transaction.app_user_id) ?? 0) +
        transaction.point_amount
    );
  }

  return (
    <section className="space-y-10">
      <header>
        <p className="text-sm font-medium text-gray-500">Dashboard</p>
        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          Welcome to ChoreQuest
        </h1>
        <p className="mt-2 text-gray-600">
          Manage family chores, points, and rewards in one place.
        </p>
      </header>

      {errors.length > 0 ? (
        <div>
          <p className="text-red-600">Unable to load dashboard data.</p>
          <pre className="mt-4 rounded-lg bg-gray-100 p-4 text-sm">
            {errors.map((error) => error.message).join("\n")}
          </pre>
        </div>
      ) : (
        <>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            <div className="rounded-xl border bg-white p-6">
              <p className="text-sm font-medium text-gray-500">
                Family Members
              </p>
              <p className="mt-2 text-3xl font-bold">
                {familyMembersResult.count ?? 0}
              </p>
            </div>

            <div className="rounded-xl border bg-white p-6">
              <p className="text-sm font-medium text-gray-500">
                Active Chores
              </p>
              <p className="mt-2 text-3xl font-bold">
                {activeChoresResult.count ?? 0}
              </p>
            </div>

            <div className="rounded-xl border bg-white p-6">
              <p className="text-sm font-medium text-gray-500">
                Rewards Available
              </p>
              <p className="mt-2 text-3xl font-bold">
                {rewardsResult.count ?? 0}
              </p>
            </div>
          </div>

          <div className="space-y-4">
            <div>
              <h2 className="text-xl font-semibold">Assignment Overview</h2>
              <p className="mt-1 text-sm text-gray-500">
                Current assignments by status.
              </p>
            </div>

            <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
              {assignmentStatuses.map((status) => (
                <div
                  key={status.code}
                  className="rounded-xl border bg-white p-6"
                >
                  <p className="text-sm font-medium text-gray-500">
                    {status.label}
                  </p>
                  <p className="mt-2 text-3xl font-bold">
                    {assignmentCounts.get(
                      statusIdsByCode.get(status.code) ?? ""
                    ) ?? 0}
                  </p>
                </div>
              ))}
            </div>
          </div>

          <div className="space-y-4">
            <div>
              <h2 className="text-xl font-semibold">Children&apos;s Points</h2>
              <p className="mt-1 text-sm text-gray-500">
                Current point balances for active children.
              </p>
            </div>

            <div className="overflow-hidden rounded-xl border bg-white">
              {childrenResult.data?.length ? (
                <ul className="divide-y">
                  {childrenResult.data.map((child) => (
                    <li
                      key={child.app_user_id}
                      className="flex items-center justify-between px-6 py-4"
                    >
                      <span className="font-medium">{child.app_user_name}</span>
                      <span className="font-semibold">
                        {pointsByUserId.get(child.app_user_id) ?? 0} points
                      </span>
                    </li>
                  ))}
                </ul>
              ) : (
                <p className="px-6 py-4 text-sm text-gray-500">
                  No active children found.
                </p>
              )}
            </div>
          </div>
        </>
      )}
    </section>
  );
}
