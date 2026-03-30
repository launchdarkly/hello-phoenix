defmodule HelloPhoenixWeb.CoreComponents do
  @moduledoc """
  Provides core UI components.
  """
  use Phoenix.Component
  use Gettext, backend: HelloPhoenixWeb.Gettext

  @doc """
  Renders flash notices.
  """
  attr :flash, :map, required: true

  def flash_group(assigns) do
    ~H"""
    <.flash kind={:info} flash={@flash} />
    <.flash kind={:error} flash={@flash} />
    """
  end

  @doc """
  Renders a single flash message.
  """
  attr :kind, :atom, required: true
  attr :flash, :map, required: true

  def flash(assigns) do
    ~H"""
    <p :if={msg = Phoenix.Flash.get(@flash, @kind)}
      class={"alert alert-#{if @kind == :info, do: "info", else: "danger"}"}
      role="alert"
      phx-click="lv:clear-flash"
      phx-value-key={@kind}>
      <%= msg %>
    </p>
    """
  end
end
