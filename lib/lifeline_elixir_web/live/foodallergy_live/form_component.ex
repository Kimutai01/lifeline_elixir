defmodule LifelineElixirWeb.FoodallergyLive.FormComponent do
  use LifelineElixirWeb, :live_component

  alias LifelineElixir.Foodallergies

  @impl true
  def update(%{foodallergy: foodallergy} = assigns, socket) do
    changeset = Foodallergies.change_foodallergy(foodallergy)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"foodallergy" => foodallergy_params}, socket) do
    changeset =
      socket.assigns.foodallergy
      |> Foodallergies.change_foodallergy(foodallergy_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"foodallergy" => foodallergy_params}, socket) do
    save_foodallergy(socket, socket.assigns.action, foodallergy_params)
  end

  defp save_foodallergy(socket, :edit, foodallergy_params) do
    case Foodallergies.update_foodallergy(socket.assigns.foodallergy, foodallergy_params) do
      {:ok, _foodallergy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Foodallergy updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_foodallergy(socket, :add_food_allergy, foodallergy_params) do
    case Foodallergies.create_foodallergy(foodallergy_params) do
      {:ok, _foodallergy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Foodallergy created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
