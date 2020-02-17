defmodule Culinary.FoodTests do
    use Culinary.DataCase, async: true

     alias Culinary.Supplies
     alias Culinary.Supplies.Food

    @valid_attrs %{name: "Pie"}
    @invalid_attrs %{name: nil}

     test "list_foods/0 returns all foods" do
        %Food{id: id1} = food_fixture()
        assert [%Food{id: id1}] = Supplies.list_foods()
        
     end

    test "get_food/1 returns the video with given id" do
        %Food{id: id} = food_fixture()
        assert %Food{id: ^id} = Supplies.get_food!(id)
    end

    test "create_video/2 with valid data creates a food" do
        assert {:ok, %Food{} = food} = 
            Supplies.create_food(@valid_attrs)

        assert food.name == "Pie"
    end

    test "create_food/2 with invalid data returns error changeset" do
        assert {:error, %Ecto.Changeset{}} = 
            Supplies.create_food(@invalid_attrs)
        
    end

    test "update_food/2 with valid data updates the food" do
        food = food_fixture()
        assert {:ok, food} = 
            Supplies.update_food(food, %{name: "updated name"})
        
        assert %Food{} = food
        assert food.name == "updated name"
    end

    test "update food/2 with invalid data that returns error changeset" do
        %Food{id: id} = food = food_fixture()
        
        assert {:error, %Ecto.Changeset{}} = 
            Supplies.update_food(food, @invalid_attrs)

        assert %Food{id: ^id} = Supplies.get_food!(id)
    end

    test "delete_food/1 deletes the food" do
        food = food_fixture()
        assert {:ok, %Food{}} = Supplies.delete_food(food)

        assert Supplies.list_foods() == []
    end

    test "change_food/1 returns a food changeset" do
        food  = food_fixture()
        assert %Ecto.Changeset{} = Supplies.change_food(food)
    end

end
