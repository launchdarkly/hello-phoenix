defmodule HelloPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    start_ldclient(Application.get_env(:hello_phoenix, :ld_sdk_key))

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

  defp start_ldclient(sdk_key) when is_binary(sdk_key) and sdk_key != "" do
    :ldclient.start_instance(String.to_charlist(sdk_key), :default, %{
      :http_options => %{
        :tls_options => :ldclient_config.tls_basic_options()
      }
    })
  end

  defp start_ldclient(_sdk_key) do
    Logger.warning(
      "LD_SDK_KEY is not set, so the LaunchDarkly client is running offline; " <>
        "flag evaluations fall back to their default values."
    )

    :ldclient.start_instance(~c"", :default, %{:offline => true})
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
