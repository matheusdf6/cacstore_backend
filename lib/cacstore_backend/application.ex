defmodule Cacstore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Cacstore.Repo,
      # Start the Telemetry supervisor
      CacstoreWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cacstore.PubSub},
      # Start the Endpoint (http/https)
      CacstoreWeb.Endpoint,
      # Start Cart Registration Service
      Cacstore.Data.CartRegistry
      # Start a worker by calling: Cacstore.Worker.start_link(arg)
      # {Cacstore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cacstore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CacstoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
