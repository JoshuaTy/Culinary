defmodule Culinary.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  def change do
    create table(:foods) do
      add :name, :string
      add :quantity, :integer, default: 1

      timestamps()
    end 
    create unique_index(:foods, [:name])
  end
end
