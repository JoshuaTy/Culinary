defmodule CulinaryWeb.TransactionView do
    use CulinaryWeb, :view

    def food_select_options(foods) do
        for %{name: name, id: id} <- foods, do: {name, id} 
    end

end