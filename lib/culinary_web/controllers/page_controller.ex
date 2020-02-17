defmodule CulinaryWeb.PageController do
  use CulinaryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
