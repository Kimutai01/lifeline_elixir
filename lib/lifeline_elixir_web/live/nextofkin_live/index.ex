defmodule LifelineElixirWeb.NextofkinLive.Index do
  use LifelineElixirWeb, :live_view

  alias LifelineElixir.Nextofkins
  alias LifelineElixir.Nextofkins.Nextofkin

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :nextofkins, list_nextofkins())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Nextofkin")
    |> assign(:nextofkin, Nextofkins.get_nextofkin!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Nextofkin")
    |> assign(:nextofkin, %Nextofkin{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Nextofkins")
    |> assign(:nextofkin, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    nextofkin = Nextofkins.get_nextofkin!(id)
    {:ok, _} = Nextofkins.delete_nextofkin(nextofkin)

    {:noreply, assign(socket, :nextofkins, list_nextofkins())}
  end

  defp list_nextofkins do
    Nextofkins.list_nextofkins()
  end
end
