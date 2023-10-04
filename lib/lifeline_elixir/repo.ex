defmodule LifelineElixir.Repo do
  use Ecto.Repo,
    otp_app: :lifeline_elixir,
    adapter: Ecto.Adapters.Postgres
end
