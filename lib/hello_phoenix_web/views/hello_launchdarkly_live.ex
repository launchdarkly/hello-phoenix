defmodule HelloPhoenixWeb.HelloLaunchdarklyLive do
  use HelloPhoenixWeb, :live_view
#  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    Alternate Enabled: <%= @alternate %>
    """
  end

  def mount(%{"user" => user}, _params, socket) do
    if connected?(socket), do: Process.send_after(self(), {:update, user}, 30000)

    alternate = :ldclient.variation("alternate.page", %{:key => user}, false)
    {:ok, assign(socket, :alternate, alternate)}
  end

  def handle_info({:update, user}, socket) do
    Process.send_after(self(), {:update, user}, 30000)
    alternate = :ldclient.variation("alternate.page", %{:key => user}, false)
    {:noreply, assign(socket, :alternate, alternate)}
  end
end