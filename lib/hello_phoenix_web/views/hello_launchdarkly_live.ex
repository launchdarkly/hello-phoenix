defmodule HelloPhoenixWeb.HelloLaunchdarklyLive do
  use HelloPhoenixWeb, :live_view

  def render(assigns) do
    case assigns.alternate do
      true ->
        ~H"""
          <div class="phx-hero">
          <h2>Hello <%= @context_key %>, from LaunchDarkly!</h2>
          <p>Welcome to the NEW cool page, enabled by LaunchDarkly!</p>
          </div>
        """
      false ->
        ~H"""
          <div class="phx-hero">
          <h2>Hello <%= @context_key %>, from LaunchDarkly!</h2>
          </div>
        """
    end

  end

  def mount(%{"context_key" => context_key}, _params, socket) do
    if connected?(socket), do: Process.send_after(self(), {:update, context_key}, 30000)

    alternate = :ldclient.variation("alternate.page", :ldclient_context.new(context_key), false)
    {:ok, assign(socket, %{:alternate => alternate, :context_key => context_key})}
  end

  def handle_info({:update, context_key}, socket) do
    Process.send_after(self(), {:update, context_key}, 30000)
    alternate = :ldclient.variation("alternate.page", :ldclient_context.new(context_key), false)
    {:noreply, assign(socket, %{:alternate => alternate, :context_key => context_key})}
  end
end
