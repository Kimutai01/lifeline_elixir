defmodule LifelineElixirWeb.DrugallergyLive.FormComponent do
  use LifelineElixirWeb, :live_component

  alias LifelineElixir.Drugallergies

  @impl true
  def update(%{drugallergy: drugallergy} = assigns, socket) do
    changeset = Drugallergies.change_drugallergy(drugallergy)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"drugallergy" => drugallergy_params}, socket) do
    changeset =
      socket.assigns.drugallergy
      |> Drugallergies.change_drugallergy(drugallergy_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"drugallergy" => drugallergy_params}, socket) do
    save_drugallergy(socket, socket.assigns.action, drugallergy_params)
  end

  defp save_drugallergy(socket, :edit_allergy, drugallergy_params) do
    IO.inspect(drugallergy_params)
    case Drugallergies.update_drugallergy(socket.assigns.drugallergy, drugallergy_params) do
      {:ok, _drugallergy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Drugallergy updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_drugallergy(socket, :add_allergy, drugallergy_params) do
    IO.inspect(drugallergy_params)
    case Drugallergies.create_drugallergy(drugallergy_params) do
      {:ok, _drugallergy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Drugallergy created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
