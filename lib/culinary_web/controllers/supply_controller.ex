defmodule CulinaryWeb.SupplyController do
    use CulinaryWeb, :controller

    alias Culinary.Supplies
    alias Culinary.Supplies.Food
    def index(conn, _params) do
        supplies = Supplies.list_foods()
        render(conn, "index.html", supplies: supplies)
    end

    def new(conn, _params) do
        changeset = Supplies.change_supply(%Food{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"food" => food_params}) do
        case Supplies.create_food(food_params) do
            {:ok, food} -> 
            conn
            |> put_flash(:info, "Food Successfully created")
            |> redirect(to: Routes.supply_path(conn, :show, food))
        
            {:error, %Ecto.Changeset{} = changeset } ->
                render(conn, "new.html", changeset: changeset)

        end
    end

    def show(conn, %{"id" => id}) do
        supply = Supplies.get_food!(id)
        render(conn, "show.html", supply: supply) 
    end
end