defmodule FoodpandaWeb.ListViewLive do
  use FoodpandaWeb, :live_view

  @impl Phoenix.LiveView
  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    if connected?(socket), do: FoodpandaWeb.Endpoint.subscribe("live")

    {:ok, update_assigns(socket)}
  end

  defp update_assigns(socket) do
    assign(socket, recipes: Foodpanda.get_list_of_recipe())
  end

  @impl Phoenix.LiveView
  @spec handle_event(<<_::56>>, map, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("details", %{"entry_id" => entry_id}, socket) do
    {:noreply, redirect(socket, to: "/show/#{entry_id}")}
  end
end
