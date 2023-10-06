defmodule LifelineElixir.Patients do
  @moduledoc """
  The Patients context.
  """

  import Ecto.Query, warn: false
  alias LifelineElixir.Repo

  alias LifelineElixir.Patients.Patient

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list_patients()
      [%Patient{}, ...]

  """
  def list_patients do
    Repo.all(Patient)
  end

  @doc """
  Gets a single patient.

  Raises `Ecto.NoResultsError` if the Patient does not exist.

  ## Examples

      iex> get_patient!(123)
      %Patient{}

      iex> get_patient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patient!(id), do: Repo.get!(Patient, id) |> Repo.preload(:drugallergies) |> Repo.preload(:foodallergies) |> Repo.preload(:nextofkins)

  @doc """
  Creates a patient.

  ## Examples

      iex> create_patient(%{field: value})
      {:ok, %Patient{}}

      iex> create_patient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patient(attrs \\ %{}) do
    %Patient{}
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patient.

  ## Examples

      iex> update_patient(patient, %{field: new_value})
      {:ok, %Patient{}}

      iex> update_patient(patient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patient(%Patient{} = patient, attrs) do
    patient
    |> Patient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patient.

  ## Examples

      iex> delete_patient(patient)
      {:ok, %Patient{}}

      iex> delete_patient(patient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patient(%Patient{} = patient) do
    Repo.delete(patient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patient changes.

  ## Examples

      iex> change_patient(patient)
      %Ecto.Changeset{data: %Patient{}}

  """
  def change_patient(%Patient{} = patient, attrs \\ %{}) do
    Patient.changeset(patient, attrs)
  end

  def total_patients do
    Repo.aggregate(Patient, :count, :id)
  end

  def asthmatic_percentage do
    total_patients = from(p in Patient, where: p.asthmatic == true, select: count(p.id)) |> Repo.one()
    all_patients = from(p in Patient, select: count(p.id)) |> Repo.one()

    case {total_patients, all_patients} do
      {nil, nil} ->
        0.0
      {0, _} ->
        0.0
      {_, 0} ->
        0.0
      {total, all} ->
        (total / all) * 100
    end
  end

  def diabetic_percentage do
    total_patients = from(p in Patient, where: p.diabetic == true, select: count(p.id)) |> Repo.one()
    all_patients = from(p in Patient, select: count(p.id)) |> Repo.one()

    case {total_patients, all_patients} do
      {nil, nil} ->
        0.0
      {0, _} ->
        0.0
      {_, 0} ->
        0.0
      {total, all} ->
        (total / all) * 100
    end
  end

  def get_patients_for_doctor(doctor_id) do
  from(p in Patient,
       where: p.user_id == ^doctor_id,
       select: p)
  |> Repo.all()
  end

  def get_patients_for_doctor_count(doctor_id) do
  from(p in Patient,
       where: p.user_id == ^doctor_id,
       select: count(p.id))
  |> Repo.one()
  end


  def hypertensive_percentage do
    total_patients = from(p in Patient, where: p.hypertensive == true, select: count(p.id)) |> Repo.one()
    all_patients = from(p in Patient, select: count(p.id)) |> Repo.one()

    case {total_patients, all_patients} do
      {nil, nil} ->
        0.0
      {0, _} ->
        0.0
      {_, 0} ->
        0.0
      {total, all} ->
        (total / all) * 100
    end
  end


end
