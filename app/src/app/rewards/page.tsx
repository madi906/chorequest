import { supabase } from "@/lib/supabase";

type Reward = {
  reward_id: string;
  reward_name: string;
  reward_type: string;
  point_cost: number;
  reward_description: string | null;
  available_quantity: number | null;
  display_order: number;
  is_active: boolean;
};

export default async function RewardsPage() {
  const { data, error } = await supabase
    .from("reward")
    .select(
      `
        reward_id,
        reward_name,
        reward_type,
        point_cost,
        reward_description,
        available_quantity,
        display_order,
        is_active
      `
    )
    .eq("is_deleted", false)
    .order("display_order");

  if (error) {
    return (
      <section>
        <h1 className="text-3xl font-bold">Rewards</h1>

        <p className="mt-2 text-red-600">
          Unable to load rewards.
        </p>

        <pre className="mt-4 rounded-lg bg-gray-100 p-4 text-sm">
          {error.message}
        </pre>
      </section>
    );
  }

  const rewards = (data ?? []) as Reward[];

  const activeRewards = rewards.filter(
    (reward) => reward.is_active
  );

  return (
    <section className="space-y-8">
      <header>
        <p className="text-sm font-medium text-gray-500">
          Family Rewards
        </p>

        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          Rewards
        </h1>

        <p className="mt-2 text-gray-600">
          Rewards that children can work towards using their
          earned points.
        </p>
      </header>

      {/* ============================================================
          Summary
          ============================================================ */}

      <div className="grid gap-4 sm:grid-cols-2">
        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">
            Rewards Available
          </p>

          <p className="mt-2 text-3xl font-bold">
            {activeRewards.length}
          </p>
        </div>

        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">
            Catalogue Items
          </p>

          <p className="mt-2 text-3xl font-bold">
            {rewards.length}
          </p>
        </div>
      </div>

      {/* ============================================================
          Reward Catalogue
          ============================================================ */}

      <section className="space-y-4">
        <div>
          <h2 className="text-xl font-semibold">
            Reward Catalogue
          </h2>

          <p className="mt-1 text-sm text-gray-500">
            Rewards configured for your ChoreQuest household.
          </p>
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          {rewards.map((reward) => (
            <article
              key={reward.reward_id}
              className="rounded-xl border bg-white p-6 shadow-sm"
            >
              <div className="flex flex-wrap items-start justify-between gap-3">
                <div>
                  <h3 className="text-lg font-semibold">
                    {reward.reward_name}
                  </h3>

                  <p className="mt-1 text-sm text-gray-500">
                    {reward.reward_type}
                  </p>
                </div>

                <span className="whitespace-nowrap rounded-full bg-gray-100 px-3 py-1 text-sm font-semibold">
                  ⭐ {reward.point_cost} points
                </span>
              </div>

              {reward.reward_description && (
                <p className="mt-4 text-sm text-gray-600">
                  {reward.reward_description}
                </p>
              )}

              <div className="mt-5 flex flex-wrap items-center gap-2 text-sm">
                <span
                  className={`rounded-full px-3 py-1 font-semibold ${
                    reward.is_active
                      ? "bg-green-100 text-green-700"
                      : "bg-gray-100 text-gray-500"
                  }`}
                >
                  {reward.is_active ? "Available" : "Inactive"}
                </span>

                <span className="rounded-full bg-gray-100 px-3 py-1 font-medium text-gray-600">
                  {reward.available_quantity === null
                    ? "Unlimited"
                    : `${reward.available_quantity} available`}
                </span>
              </div>
            </article>
          ))}
        </div>
      </section>
    </section>
  );
}