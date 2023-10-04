defmodule LifelineElixirWeb.PatientLive.Show do
  alias LifelineElixir.Drugallergies.Drugallergy
  use LifelineElixirWeb, :live_view
  alias LifelineElixir.Drugallergies
  alias LifelineElixir.Patients
  alias LifelineElixir.Foodallergies.Foodallergy
  alias LifelineElixir.Foodallergies
  alias LifelineElixir.Nextofkins.Nextofkin

  @impl true
  def mount(params, _session, socket) do
    IO.inspect params
    drug_allergy = if params["allergy_id"] do
      Drugallergies.get_drugallergy!(params["allergy_id"])
    else
      %Drugallergy{}
    end

    food_allergy = if params["food_allergy_id"] do
      Foodallergies.get_foodallergy!(params["food_allergy_id"])
    else
      %Foodallergy{}
    end


    {:ok,
    socket
    |> assign(:drugallergy, drug_allergy)
    |> assign(:foodallergy, food_allergy)
    |> assign(:nextofkin, %Nextofkin{})}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    patient_id = String.to_integer(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:patient, Patients.get_patient!(id))
     |> assign(:patient_id, patient_id)}
  end

  @impl true
  def handle_event("delete",params,socket) do
    drug_allergy = Drugallergies.get_drugallergy!(params["id"])
    food_allergy = Foodallergies.get_foodallergy!(params["id"])
    {:ok, _} = Drugallergies.delete_drugallergy(drug_allergy)
    {:ok, _} = Foodallergies.delete_foodallergy(food_allergy)
    {:noreply,
    socket
      |> assign(:drugallergy, Drugallergies.list_drugallergies())
      |> assign(:patient, Patients.get_patient!(socket.assigns.patient_id))
      |> assign(:foodallergy, Foodallergies.list_foodallergies())}


  end



  defp page_title(:show), do: "Show Patient"
  defp page_title(:edit), do: "Edit Patient"
  defp page_title(:add_allergy), do: "Add Allergy"
  defp page_title(:edit_allergy), do: "Edit Allergy"
  defp page_title(:add_food_allergy), do: "Add Food Allergy"
  defp page_title(:edit_food_allergy), do: "Edit Food Allergy"
  defp page_title(:add_next_of_kin), do: "Add Next of Kin"
end
