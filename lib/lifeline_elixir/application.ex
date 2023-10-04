defmodule LifelineElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LifelineElixir.Repo,
      # Start the Telemetry supervisor
      LifelineElixirWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LifelineElixir.PubSub},
      # Start the Endpoint (http/https)
      LifelineElixirWeb.Endpoint
      # Start a worker by calling: LifelineElixir.Worker.start_link(arg)
      # {LifelineElixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LifelineElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LifelineElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
