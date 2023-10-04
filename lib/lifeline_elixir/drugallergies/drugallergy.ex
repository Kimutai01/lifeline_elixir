defmodule LifelineElixir.Drugallergies.Drugallergy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "drugallergies" do
    field :name, :string
    belongs_to :patient, LifelineElixir.Patients.Patient

    timestamps()
  end

  @doc false
  def changeset(drugallergy, attrs) do
    drugallergy
    |> cast(attrs, [:name, :patient_id])
    |> validate_required([:name, :patient_id])
  end
end
