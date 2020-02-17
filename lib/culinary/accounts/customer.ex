defmodule Culinary.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :address, :string
    field :contact_number, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :contact_number, :address])
    |> validate_required([:name, :contact_number, :address])
    |> unique_constraint(:name)
  end
end
