defmodule LifelineElixirWeb.FoodallergyLive.Show do
  use LifelineElixirWeb, :live_view

  alias LifelineElixir.Foodallergies

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:foodallergy, Foodallergies.get_foodallergy!(id))}
  end

  defp page_title(:show), do: "Show Foodallergy"
  defp page_title(:edit), do: "Edit Foodallergy"
end
