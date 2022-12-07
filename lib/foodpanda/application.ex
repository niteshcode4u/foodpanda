defmodule Foodpanda.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Foodpanda.Repo,
      # Start the Telemetry supervisor
      FoodpandaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Foodpanda.PubSub},
      # Start the Endpoint (http/https)
      FoodpandaWeb.Endpoint
      # Start a worker by calling: Foodpanda.Worker.start_link(arg)
      # {Foodpanda.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foodpanda.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodpandaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
