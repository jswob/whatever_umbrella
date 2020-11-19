defmodule Whatever.Repo do
  use Ecto.Repo,
    otp_app: :whatever,
    adapter: Ecto.Adapters.Postgres
end
