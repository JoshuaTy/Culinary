defmodule Culinary.TestHelpers do
    
    alias Culinary.{
        Accounts,
        Transactions,
        Supplies
    }

    def user_fixture(attrs \\ %{}) do
        {:ok, customer} = 
            attrs
            |> Enum.into(%{
                name: "Some User",
                username: "user#{System.unique_integer([:positive])}",
                password: attrs[:password] || "supersecret"
            })
            |> Accounts.create_customer()
        customer
    end

    def video_fixture(%Accounts.Customer{} = customer, attrs \\ %{}) do
        attrs = 
            Enum.into(attrs, %{
               quantity: 1,
            })

        {:ok, order} = Transactions.create_order(customer, attrs)
        order
    end

    def food_fixture(attrs \\ %{}) do
        {:ok, food} = 
            attrs 
            |> Enum.into(%{name: "Pie"})
            |> Supplies.create_food()
        food
    end

end