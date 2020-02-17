defmodule Culinary.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :contact_number, :integer
      add :address, :string

      timestamps()
    end

    create unique_index(:customers, [:name])
  end
end
