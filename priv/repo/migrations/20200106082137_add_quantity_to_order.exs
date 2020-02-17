defmodule Culinary.Repo.Migrations.AddQuantityToOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :quantity, :integer, default: 1
    end
  end
end
