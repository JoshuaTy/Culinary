defmodule Culinary.Transactions.Order do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "orders" do
    field :quantity, :integer, default: 1
    
    belongs_to :customer, Culinary.Accounts.Customer
    belongs_to :food, Culinary.Supplies.Food

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:quantity, :food_id])
    |> validate_required([:food_id, :quantity])
  end

  def order_query(query, order_id) do
    # from o in query, 
    # join: c in assoc(o, :customer), 
    # join: f in assoc(o, :food),
    # where: o.id == ^order_id,
    # select: %{
    #   order_id: o.id,
    #   inserted_at: o.inserted_at,
    #   quantity: f.quantity,
    #   foodName: f.name,
    #   customerName: c.name
    # }
    from o in query, 
    join: f in assoc(o, :food),
    where: o.id == ^order_id,
    preload: [food: f],
    select: [:id, :quantity, :inserted_at, food: [:id, :name]]
    
  end
end
