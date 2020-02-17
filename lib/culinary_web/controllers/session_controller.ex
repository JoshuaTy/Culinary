defmodule CulinaryWeb.SessionController do
    use CulinaryWeb, :controller

    def new(conn, _) do
        render(conn, "new.html")
    end

    def create(conn, %{"session" => %{"name" => name}}) do
        case Culinary.Accounts.authenticate_by_customer_name(name) do
            {:ok, customer} ->
                conn
                |> CulinaryWeb.Auth.login(customer)
                |> put_flash(:info, "Welcome back my nibba")
                |> redirect(to: Routes.customer_path(conn, :index))

            {:error, _reason} ->
                conn
                |> put_flash(:error, "Invalid credentials!")
                |> render("new.html")
        end
    end

    def delete(conn, _) do
        conn
        |> CulinaryWeb.Auth.logout()
        |> redirect(to: Routes.page_path(conn, :index))
    end

end