defmodule LifelineElixirWeb.FoodallergyLive.Index do
  use LifelineElixirWeb, :live_view

  alias LifelineElixir.Foodallergies
  alias LifelineElixir.Foodallergies.Foodallergy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :foodallergies, list_foodallergies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Foodallergy")
    |> assign(:foodallergy, Foodallergies.get_foodallergy!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Foodallergy")
    |> assign(:foodallergy, %Foodallergy{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Foodallergies")
    |> assign(:foodallergy, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    foodallergy = Foodallergies.get_foodallergy!(id)
    {:ok, _} = Foodallergies.delete_foodallergy(foodallergy)

    {:noreply, assign(socket, :foodallergies, list_foodallergies())}
  end

  defp list_foodallergies do
    Foodallergies.list_foodallergies()
  end
end
