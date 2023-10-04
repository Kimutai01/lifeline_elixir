defmodule LifelineElixir.PatientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LifelineElixir.Patients` context.
  """

  @doc """
  Generate a patient.
  """
  def patient_fixture(attrs \\ %{}) do
    {:ok, patient} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name",
        national_id: "some national_id",
        height: "some height",
        age: 42,
        weight: "some weight"
      })
      |> LifelineElixir.Patients.create_patient()

    patient
  end
end
