defmodule CulinaryWeb.TransactionController do
    use CulinaryWeb, :controller

    alias Culinary.Supplies 
    alias Culinary.Transactions
    alias Culinary.Transactions.Order

    plug :load_orders when action in [:new, :create]

    def action(conn, _) do
        args = [conn, conn.params, conn.assigns.current_customer]
        apply(__MODULE__, action_name(conn), args)
    end


    def new(conn, _params, _current_customer) do
        changeset = Transactions.change_order(%Order{})
        render(conn, "new.html", changeset: changeset)
    end

    def show(conn, %{"id" => id}, current_customer) do
        order = Transactions.get_customer_order!(current_customer, id)
        render(conn, "show.html", order: order)
    end

    def create(conn, %{"order" => order_params}, current_customer) do
        case Transactions.create_order(current_customer, order_params) do
            {:ok, order} ->
                conn
                |> put_flash(:info, "Order created successfully.")
                |> redirect(to: Routes.transaction_path(conn, :show, order))
                #|> redirect(to: Routes.transaction_path(conn, :index))
            
            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    def index(conn, _params, current_customer) do
        orders = Transactions.list_customer_orders(current_customer)
        render(conn, "index.html", orders: orders)
    end

    defp load_orders(conn, _) do
        assign(conn, :foods, Supplies.get_name_id())
    end

end