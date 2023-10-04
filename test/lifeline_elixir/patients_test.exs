defmodule LifelineElixir.PatientsTest do
  use LifelineElixir.DataCase

  alias LifelineElixir.Patients

  describe "patients" do
    alias LifelineElixir.Patients.Patient

    import LifelineElixir.PatientsFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, national_id: nil, height: nil, age: nil, weight: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Patients.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Patients.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", national_id: "some national_id", height: "some height", age: 42, weight: "some weight"}

      assert {:ok, %Patient{} = patient} = Patients.create_patient(valid_attrs)
      assert patient.first_name == "some first_name"
      assert patient.last_name == "some last_name"
      assert patient.national_id == "some national_id"
      assert patient.height == "some height"
      assert patient.age == 42
      assert patient.weight == "some weight"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patients.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", national_id: "some updated national_id", height: "some updated height", age: 43, weight: "some updated weight"}

      assert {:ok, %Patient{} = patient} = Patients.update_patient(patient, update_attrs)
      assert patient.first_name == "some updated first_name"
      assert patient.last_name == "some updated last_name"
      assert patient.national_id == "some updated national_id"
      assert patient.height == "some updated height"
      assert patient.age == 43
      assert patient.weight == "some updated weight"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Patients.update_patient(patient, @invalid_attrs)
      assert patient == Patients.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Patients.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Patients.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Patients.change_patient(patient)
    end
  end
end
