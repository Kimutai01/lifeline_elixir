defmodule LifelineElixirWeb.PatientLive.FormComponent do
  use LifelineElixirWeb, :live_component

  alias LifelineElixir.Patients

  @impl true
  def update(%{patient: patient} = assigns, socket) do
    changeset = Patients.change_patient(patient)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .png .jpeg), max_entries: 1)}
  end

  @impl true
  def handle_event("validate", %{"patient" => patient_params}, socket) do
    changeset =
      socket.assigns.patient
      |> Patients.change_patient(patient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"patient" => patient_params}, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        dest = Path.join([:code.priv_dir(:lifeline_elixir), "static", "uploads", Path.basename(path)])

        # The `static/uploads` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain uploads to work,.
        File.cp!(path, dest)
        {:ok, "/uploads/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
    new_patient_params = Map.put(patient_params, "picture", List.first(uploaded_files))
    save_patient(socket, socket.assigns.action, new_patient_params)
  end

  defp save_patient(socket, :edit, patient_params) do
    IO.inspect(patient_params)
    case Patients.update_patient(socket.assigns.patient, patient_params) do
      {:ok, _patient} ->
        {:noreply,
         socket
         |> put_flash(:info, "Patient updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_patient(socket, :new, patient_params) do
    new_params =
      patient_params
      |> Map.put("user_id", socket.assigns.current_user.id)
    IO.inspect(new_params)
    case Patients.create_patient(new_params) do
      {:ok, _patient} ->
        {:noreply,
         socket
         |> put_flash(:info, "Patient created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
