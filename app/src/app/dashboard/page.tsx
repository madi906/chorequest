export default function DashboardPage() {
  return (
    <section className="space-y-8">
      <header>
        <p className="text-sm font-medium text-gray-500">Dashboard</p>
        <h1 className="mt-1 text-3xl font-bold tracking-tight">
          Welcome to ChoreQuest
        </h1>
        <p className="mt-2 text-gray-600">
          Manage family chores, points, and rewards in one place.
        </p>
      </header>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">Family Members</p>
          <p className="mt-2 text-3xl font-bold">5</p>
        </div>

        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">Active Chores</p>
          <p className="mt-2 text-3xl font-bold">0</p>
        </div>

        <div className="rounded-xl border bg-white p-6">
          <p className="text-sm font-medium text-gray-500">Rewards Available</p>
          <p className="mt-2 text-3xl font-bold">0</p>
        </div>
      </div>
    </section>
  );
}
