defmodule Culinary.Supplies do
    alias Culinary.Repo
    alias Culinary.Supplies.Food

    def get_food(id) do
        Repo.get(Food, id)
    end

    def get_food!(id) do
        Repo.get!(Food, id)
    end

    def list_foods do
        Repo.all(Food)
    end
    
    def create_food(attrs \\ %{}) do
        %Food{}
        |> Food.changeset(attrs)
        |> Repo.insert()
    end

    def change_food(%Food{} = food) do
        Food.changeset(food, %{})
    end

    def get_name_id do
        Food
        |> Food.for_select_options()
        |> Repo.all()
    end

    def update_food(%Food{} = food, attrs \\ %{}) do
        food
        |> Food.changeset(attrs)
        |> Repo.update()
    end

    def delete_food(%Food{} = food) do
        Repo.delete(food)
    end

end