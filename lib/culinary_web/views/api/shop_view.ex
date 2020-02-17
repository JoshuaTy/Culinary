defmodule CulinaryWeb.Api.ShopView do
  use CulinaryWeb, :view
  alias CulinaryWeb.Api.ShopView

  #You can remove the data key from the map below

  def render("index.json", %{shops: shops}) do
    %{data: render_many(shops, ShopView, "shop.json")}
  end

  def render("show.json", %{shop: shop}) do
    render_one(shop, ShopView, "shop.json")
  end

  #Select fields you want 
  def render("shop.json", %{shop: shop}) do
    %{id: shop.id,
      name: shop.name,
      address: shop.address}
  end
end
