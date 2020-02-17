defmodule Culinary.Transactions do
    import Ecto.Query

    alias Culinary.Repo
    alias Culinary.Transactions.Order
    alias Culinary.Accounts

    def get_order!(id) do
        Repo.get!(Order, id)
    end

    def list_orders do
        Repo.all(Order)
    end

    def change_order(%Order{} = order) do
        Order.changeset(order, %{})
    end

    def list_customer_orders(%Accounts.Customer{} = customer) do
        Order
        |> customer_order_query(customer)
        |> Repo.all()
    end

    def get_customer_order!(%Accounts.Customer{} = customer, id) do
        # Order
        # |> customer_order_query(customer)
        # |> Repo.get!(id)
        Order
        |> Order.order_query(id)
        |> Repo.one()
        |> IO.inspect()
    end

    defp customer_order_query(query, %Accounts.Customer{id: customer_id}) do
        from o in query, where: o.customer_id == ^customer_id
    end

    def create_order(%Accounts.Customer{} = customer, attrs \\ %{}) do
        %Order{}
        |> Order.changeset(attrs)
        |> Ecto.Changeset.put_assoc(:customer, customer)
        |> Repo.insert()
    end

end