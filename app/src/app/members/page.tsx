import { supabase } from "@/lib/supabase";

type Member = {
  app_user_id: string;
  app_user_name: string;
  user_role: string;
  is_active: boolean;
};

type PointTransaction = {
  app_user_id: string;
  point_amount: number;
};

export default async function MembersPage() {
  const [membersResult, pointTransactionsResult] = await Promise.all([
    supabase
      .from("app_user")
      .select("app_user_id, app_user_name, user_role, is_active")
      .eq("is_deleted", false)
      .order("app_user_name"),

    supabase
      .from("point_transaction")
      .select("app_user_id, point_amount")
      .eq("is_deleted", false),
  ]);

  const errors = [
    membersResult.error,
    pointTransactionsResult.error,
  ].filter((error) => error !== null);

  if (errors.length > 0) {
    return (
      <section>
        <h1 className="text-3xl font-bold">Family Members</h1>

        <p className="mt-2 text-red-600">
          Unable to load family member data.
        </p>

        <pre className="mt-4 rounded-lg bg-gray-100 p-4 text-sm">
          {errors.map((error) => error.message).join("\n")}
        </pre>
      </section>
    );
  }

  const members = (membersResult.data ?? []) as Member[];
  const pointTransactions =
    (pointTransactionsResult.data ?? []) as PointTransaction[];

  const pointsByUserId = new Map<string, number>();

  for (const transaction of pointTransactions) {
    pointsByUserId.set(
      transaction.app_user_id,
      (pointsByUserId.get(transaction.app_user_id) ?? 0) +
        transaction.point_amount
    );
  }

  const parentCount = members.filter(
    (member) => member.user_role === "PARENT"
  ).length;

  const childCount = members.filter(
    (member) => member.user_role === "CHILD"
  ).length;

  return (
    <section className="space-y-8">
      <header>
        <p className="text-sm font-medium text-gray-500">Family</p>

        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          Family Members
        </h1>

        <p className="mt-2 text-gray-600">
          View the members of your ChoreQuest household.
        </p>
      </header>

      {/* ============================================================
          Summary
          ============================================================ */}

      <div className="grid gap-4 sm:grid-cols-3">
        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">
            Family Members
          </p>

          <p className="mt-2 text-3xl font-bold">
            {members.length}
          </p>
        </div>

        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">
            Parents
          </p>

          <p className="mt-2 text-3xl font-bold">
            {parentCount}
          </p>
        </div>

        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">
            Children
          </p>

          <p className="mt-2 text-3xl font-bold">
            {childCount}
          </p>
        </div>
      </div>

      {/* ============================================================
          Members
          ============================================================ */}

      <section className="space-y-4">
        <div>
          <h2 className="text-xl font-semibold">
            Household Members
          </h2>

          <p className="mt-1 text-sm text-gray-500">
            Current members of your ChoreQuest household.
          </p>
        </div>

        <div className="overflow-hidden rounded-xl border bg-white">
          <ul className="divide-y">
            {members.map((member) => {
              const isChild = member.user_role === "CHILD";

              return (
                <li
                  key={member.app_user_id}
                  className="flex flex-col gap-3 px-6 py-4 sm:flex-row sm:items-center sm:justify-between"
                >
                  <div>
                    <p className="font-medium">
                      {member.app_user_name}
                    </p>

                    <div className="mt-1 flex items-center gap-2">
                      <span className="rounded-full bg-gray-100 px-3 py-1 text-xs font-semibold uppercase">
                        {member.user_role}
                      </span>

                      <span
                        className={`rounded-full px-3 py-1 text-xs font-semibold ${
                          member.is_active
                            ? "bg-green-100 text-green-700"
                            : "bg-gray-100 text-gray-500"
                        }`}
                      >
                        {member.is_active ? "Active" : "Inactive"}
                      </span>
                    </div>
                  </div>

                  <div className="text-left sm:text-right">
                    <p className="text-sm text-gray-500">
                      Points
                    </p>

                    <p className="font-semibold">
                      {isChild
                        ? `${pointsByUserId.get(
                            member.app_user_id
                          ) ?? 0} points`
                        : "—"}
                    </p>
                  </div>
                </li>
              );
            })}
          </ul>
        </div>
      </section>
    </section>
  );
}