defmodule CulinaryWeb.Api.ShopController do
  use CulinaryWeb, :controller

  alias Culinary.Partner
  alias Culinary.Partner.Shop

  action_fallback CulinaryWeb.FallbackController

  def index(conn, _params) do
    shops = Partner.list_shops()
    render(conn, "index.json", shops: shops)
  end

  def create(conn, %{"shop" => shop_params}) do
    with {:ok, %Shop{} = shop} <- Partner.create_shop(shop_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_shop_path(conn, :show, shop))
      |> render("show.json", shop: shop)
    end
  end

  def show(conn, %{"id" => id}) do
    shop = Partner.get_shop!(id)
    render(conn, "show.json", shop: shop)
  end

  def update(conn, %{"id" => id, "shop" => shop_params}) do
    shop = Partner.get_shop!(id)

    with {:ok, %Shop{} = shop} <- Partner.update_shop(shop, shop_params) do
      render(conn, "show.json", shop: shop)
    end
  end

  def delete(conn, %{"id" => id}) do
    shop = Partner.get_shop!(id)

    with {:ok, %Shop{}} <- Partner.delete_shop(shop) do
      send_resp(conn, :no_content, "")
    end
  end
end
