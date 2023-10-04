defmodule LifelineElixir.Foodallergies.Foodallergy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foodallergies" do
    field :name, :string
    belongs_to :patient, LifelineElixir.Patients.Patient

    timestamps()
  end

  @doc false
  def changeset(foodallergy, attrs) do
    foodallergy
    |> cast(attrs, [:name, :patient_id])
    |> validate_required([:name, :patient_id])
  end
end
