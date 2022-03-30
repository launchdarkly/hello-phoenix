defmodule HelloPhoenixWeb.HelloLaunchdarklyLive do
  use HelloPhoenixWeb, :live_view
#  use Phoenix.LiveView

  def render(assigns) do
    case assigns.alternate do
      true ->
        ~H"""
          <div class="phx-hero">
          <h2>Hello <%= @user %>, from LaunchDarkly!</h2>
          <p>Welcome to the NEW cool page, enabled by LaunchDarkly!</p>
          </div>
        """
      false ->
        ~H"""
          <div class="phx-hero">
          <h2>Hello <%= @user %>, from LaunchDarkly!</h2>
          </div>
        """
    end

  end

  def mount(%{"user" => user}, _params, socket) do
    if connected?(socket), do: Process.send_after(self(), {:update, user}, 30000)

    alternate = :ldclient.variation("alternate.page", %{:key => user}, false)
    {:ok, assign(socket, %{:alternate => alternate, :user => user})}
  end

  def handle_info({:update, user}, socket) do
    Process.send_after(self(), {:update, user}, 30000)
    alternate = :ldclient.variation("alternate.page", %{:key => user}, false)
    {:noreply, assign(socket, %{:alternate => alternate, :user => user})}
  end
end