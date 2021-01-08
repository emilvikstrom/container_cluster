defmodule ContainerClusterNoWebpack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor, [topologies(), [name: ContainerClusterNoWebpack.ClusterSupervisor]]},
      # Start the Telemetry supervisor
      ContainerClusterNoWebpackWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ContainerClusterNoWebpack.PubSub},
      # Start the Endpoint (http/https)
      ContainerClusterNoWebpackWeb.Endpoint
      # Start a worker by calling: ContainerClusterNoWebpack.Worker.start_link(arg)
      # {ContainerClusterNoWebpack.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ContainerClusterNoWebpack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ContainerClusterNoWebpackWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def topologies(), do: Application.get_env(:libcluster, :topologies)
end
