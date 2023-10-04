defmodule LifelineElixir.Patients.Patient do
  use Ecto.Schema

  import Ecto.Changeset

  schema "patients" do
    field :first_name, :string
    field :last_name, :string
    field :national_id, :string
    field :height, :string
    field :age, :integer
    field :weight, :string

    belongs_to :user, LifelineElixir.Accounts.User
    has_many :drugallergies, LifelineElixir.Drugallergies.Drugallergy

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:first_name, :last_name, :national_id, :height, :age, :weight, :user_id])
    |> validate_required([:first_name, :last_name, :national_id, :height, :age, :weight, :user_id])
  end
end
