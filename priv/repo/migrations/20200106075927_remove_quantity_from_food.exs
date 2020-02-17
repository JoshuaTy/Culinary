defmodule Culinary.Repo.Migrations.RemoveQuantityFromFood do
  use Ecto.Migration

  def change do
    alter table(:foods)do
      remove :quantity
    end
  end
end
