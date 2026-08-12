import { supabase } from "@/lib/supabase";

export default async function Home() {
  const { data, error } = await supabase
    .from("household")
    .select("household_id, household_name")
    .limit(10);

  if (error) {
    return (
      <main>
        <h1>ChoreQuest</h1>
        <p>Supabase connection failed.</p>
        <pre>{error.message}</pre>
      </main>
    );
  }

  return (
    <main>
      <h1>ChoreQuest</h1>
      <p>Supabase connection successful.</p>

      <h2>Households</h2>

      <pre>{JSON.stringify(data, null, 2)}</pre>
    </main>
  );
}

  
