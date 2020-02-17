defmodule Culinary.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :customer_id, references(:customers, on_delete: :nothing)
      add :food_id, references(:foods, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:customer_id])
    create index(:orders, [:food_id])
  end
end
