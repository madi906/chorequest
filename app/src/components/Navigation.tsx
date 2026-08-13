import Link from "next/link";

const navigationItems = [
  { label: "Dashboard", href: "/dashboard" },
  { label: "Members", href: "/members" },
  { label: "Chores", href: "/chores" },
  { label: "Rewards", href: "/rewards" },
];

export default function Navigation() {
  return (
    <nav>
      <div className="mb-8">
        <Link href="/dashboard" className="text-2xl font-bold">
          ChoreQuest
        </Link>
        <p className="text-sm text-gray-500">Family rewards</p>
      </div>

      <ul className="space-y-2">
        {navigationItems.map((item) => (
          <li key={item.href}>
            <Link
              href={item.href}
              className="block rounded-lg px-4 py-2 text-sm font-medium hover:bg-gray-100"
            >
              {item.label}
            </Link>
          </li>
        ))}
      </ul>
    </nav>
  );
}
