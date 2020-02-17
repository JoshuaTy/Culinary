defmodule Culinary.Partner.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :address, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:name, :address])
    |> validate_required([:name, :address])
  end
end
