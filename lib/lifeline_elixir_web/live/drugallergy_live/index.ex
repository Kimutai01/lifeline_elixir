defmodule LifelineElixirWeb.DrugallergyLive.Index do
  use LifelineElixirWeb, :live_view

  alias LifelineElixir.Drugallergies
  alias LifelineElixir.Drugallergies.Drugallergy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :drugallergies, list_drugallergies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Drugallergy")
    |> assign(:drugallergy, Drugallergies.get_drugallergy!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Drugallergy")
    |> assign(:drugallergy, %Drugallergy{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Drugallergies")
    |> assign(:drugallergy, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    drugallergy = Drugallergies.get_drugallergy!(id)
    {:ok, _} = Drugallergies.delete_drugallergy(drugallergy)

    {:noreply, assign(socket, :drugallergies, list_drugallergies())}
  end

  defp list_drugallergies do
    Drugallergies.list_drugallergies()
  end
end
