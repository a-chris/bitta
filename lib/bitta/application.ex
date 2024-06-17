defmodule Bitta.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BittaWeb.Telemetry,
      Bitta.Repo,
      {DNSCluster, query: Application.get_env(:bitta, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bitta.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Bitta.Finch},
      # Start a worker by calling: Bitta.Worker.start_link(arg)
      # {Bitta.Worker, arg},
      # Start to serve requests, typically the last entry
      BittaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bitta.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BittaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
