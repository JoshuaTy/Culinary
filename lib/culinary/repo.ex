defmodule Culinary.Repo do
  use Ecto.Repo,
    otp_app: :culinary,
    adapter: Ecto.Adapters.Postgres
end
