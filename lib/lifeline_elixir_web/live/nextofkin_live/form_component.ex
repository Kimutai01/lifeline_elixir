defmodule LifelineElixirWeb.NextofkinLive.FormComponent do
  use LifelineElixirWeb, :live_component

  alias LifelineElixir.Nextofkins

  @impl true
  def update(%{nextofkin: nextofkin} = assigns, socket) do
    changeset = Nextofkins.change_nextofkin(nextofkin)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"nextofkin" => nextofkin_params}, socket) do
    changeset =
      socket.assigns.nextofkin
      |> Nextofkins.change_nextofkin(nextofkin_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"nextofkin" => nextofkin_params}, socket) do
    save_nextofkin(socket, socket.assigns.action, nextofkin_params)
  end

  defp save_nextofkin(socket, :edit, nextofkin_params) do
    case Nextofkins.update_nextofkin(socket.assigns.nextofkin, nextofkin_params) do
      {:ok, _nextofkin} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nextofkin updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_nextofkin(socket, :add_next_of_kin, nextofkin_params) do
    case Nextofkins.create_nextofkin(nextofkin_params) do
      {:ok, _nextofkin} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nextofkin created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
