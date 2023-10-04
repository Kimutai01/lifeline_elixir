defmodule LifelineElixir.Nextofkins.Nextofkin do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nextofkins" do
    field :name, :string
    field :phone, :string
    field :relationship, :string
    belongs_to :patient, LifelineElixir.Patients.Patient

    timestamps()
  end

  @doc false
  def changeset(nextofkin, attrs) do
    nextofkin
    |> cast(attrs, [:name, :phone, :relationship])
    |> validate_required([:name, :phone, :relationship])
  end
end
