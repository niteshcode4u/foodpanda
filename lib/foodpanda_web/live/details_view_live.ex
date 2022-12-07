defmodule FoodpandaWeb.DetailsViewLive do
  use FoodpandaWeb, :live_view

  @impl Phoenix.LiveView
  @spec mount(map(), any, Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(%{"entry_id" => entry_id}, _session, socket) do
    if connected?(socket), do: FoodpandaWeb.Endpoint.subscribe("live")

    {:ok, update_assigns(socket, entry_id)}
  end

  defp update_assigns(socket, entry_id) do
    recipe =
      Foodpanda.get_list_of_recipe()
      |> Enum.filter(fn recipe -> recipe.entry_id == entry_id end)
      |> List.first()

    assign(socket, recipe: recipe)
  end

  @impl Phoenix.LiveView
  @spec handle_event(<<_::32>>, any, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("back", _params, socket) do
    {:noreply, redirect(socket, to: "/")}
  end
end
