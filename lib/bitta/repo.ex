defmodule Bitta.Repo do
  use Ecto.Repo,
    otp_app: :bitta,
    adapter: Ecto.Adapters.Postgres
end
