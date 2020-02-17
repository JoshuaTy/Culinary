defmodule Culinary.Supplies.Food do
    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query

    schema "foods" do
        field :name, :string

        timestamps()
    end    

    def changeset(food, attrs) do
        food
        |> cast(attrs, [:name])
        |> validate_required([:name])
        |> validate_length(:name, min: 3, max: 60)
        |> unique_constraint(:name)
    end

    def for_select_options(query) do
        from f in query
    end
end