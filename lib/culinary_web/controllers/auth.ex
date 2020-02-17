defmodule CulinaryWeb.Auth do
    import Plug.Conn
    import Phoenix.Controller
    alias CulinaryWeb.Router.Helpers, as: Routes


    def init(opts), do: opts

    def call(conn, _opts) do
        customer_id = get_session(conn, :customer_id)
        customer = customer_id && Culinary.Accounts.get_customer(customer_id)
        assign(conn, :current_customer, customer)
    end

    def login(conn, customer) do
        conn
        |> assign(:current_customer, customer)
        |> put_session(:customer_id, customer.id)
        |> configure_session(renew: true)
    end

    def logout(conn) do
        configure_session(conn, drop: true)
    end

    def authenticate_customer(conn, _opts) do
        if conn.assigns.current_customer do
            conn
        else 
            conn
            |> put_flash(:error, "You must be logged in boi")
            |> redirect(to: Routes.page_path(conn, :index))
            |> halt()
        end
  end


end