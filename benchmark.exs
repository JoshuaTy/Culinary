import Ecto.Query

alias Culinary.Repo
alias Culinary.Transactions.Order

order_id = 4

one_query = from o in Order, 
    join: f in assoc(o, :food),
    where: o.id == ^order_id,
    preload: [food: f],
    select: [:id, :inserted_at, food: [:id, :name, :quantity]]

 query_with_no_preload = from o in Order, 
    join: f in assoc(o, :food),
    where: o.id == ^order_id,
    select: %{
      order_id: o.id,
      inserted_at: o.inserted_at,
      food_id: f.id,
      quantity: f.quantity,
      foodName: f.name,
    }

Benchee.run(%{
  "Preload 1st query sync" => fn -> one_query |> Repo.all(in_parallel: false) end,
  "Preload 1st query async" => fn -> one_query |> Repo.all(in_parallel: true) end,
  "2nd query async" => fn -> query_with_no_preload |> Repo.all(in_parallel: true) end,
  "2nd query sync" => fn -> query_with_no_preload |> Repo.all(in_parallel: false) end
}, time: 10, memory_time: 2, warmup: 5)
