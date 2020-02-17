defmodule Culinary.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :name, :string
      add :address, :string

      timestamps()
    end

  end
end
