import { supabase } from "@/lib/supabase";

export default async function TestChorePage() {
  const { data, error } = await supabase
    .from("chore")
    .select(`
      chore_id,
      chore_name,
      chore_category (
        chore_category_id,
        chore_category_name
      )
    `)
    .eq("is_deleted", false)
    .eq("is_active", true)
    .order("chore_name");

  return (
    <main className="p-8">
      <h1 className="mb-6 text-2xl font-bold">
        Chore Relationship Test
      </h1>

      {error && (
        <pre className="rounded-lg bg-red-100 p-4 text-sm">
          {error.message}
        </pre>
      )}

      <pre className="rounded-lg bg-gray-100 p-4 text-sm">
        {JSON.stringify(data, null, 2)}
      </pre>
    </main>
  );
}
