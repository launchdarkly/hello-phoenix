defmodule HelloPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # Start LaunchDarkly SDK client
    :ldclient.start_instance(
      String.to_charlist(Application.get_env(:hello_phoenix, :ld_sdk_key, "")),
      :default,
      %{
        :http_options => %{
          :tls_options => :ldclient_config.tls_basic_options()
        }
      }
    )

    children = [
      # Start the Telemetry supervisor
      HelloPhoenixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HelloPhoenix.PubSub},
      # Start the Endpoint (http/https)
      HelloPhoenixWeb.Endpoint
      # Start a worker by calling: HelloPhoenix.Worker.start_link(arg)
      # {HelloPhoenix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
