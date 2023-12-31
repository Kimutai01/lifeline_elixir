defmodule LifelineElixirWeb.PatientLive.Index do
  use LifelineElixirWeb, :live_view
  alias LifelineElixir.Accounts

  alias LifelineElixir.Patients
  alias LifelineElixir.Patients.Patient

  @impl true
  def mount(_params, session, socket) do
    IO.inspect(socket)
    current_user = Accounts.get_user_by_session_token(session["user_token"])

    # {:ok, assign(socket, :patients,  list_patients())}
    {:ok,
  socket
  |> assign(:patients, list_patients())
  |> assign(:current_user, current_user)
  |> assign(:patient_count, Patients.get_patients_for_doctor_count(current_user.id))
  |> assign(:asthma_patients, Patients.asthmatic_percentage())
  |> assign(:diabetic_patients, Patients.diabetic_percentage())
  |> assign(:hypertensive_patients, Patients.hypertensive_percentage())
  |>assign(:doctor_patients, Patients.get_patients_for_doctor(current_user.id))}

  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Patient")
    |> assign(:patient, Patients.get_patient!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Patient")
    |> assign(:patient, %Patient{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Patients")
    |> assign(:patient, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    patient = Patients.get_patient!(id)
    {:ok, _} = Patients.delete_patient(patient)

    {:noreply, assign(socket, :patients, list_patients())}
  end

  defp list_patients do
    Patients.list_patients()
  end
end
