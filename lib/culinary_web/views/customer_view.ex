defmodule CulinaryWeb.CustomerView do
  use CulinaryWeb, :view
  alias CulinaryWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      name: customer.name,
      address: customer.address,
      contact_number: customer.contact_number
      }
  end

end
