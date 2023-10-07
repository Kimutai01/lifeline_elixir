defmodule LifelineElixir.Patients.Patient do
  use Ecto.Schema

  import Ecto.Changeset

  schema "patients" do
    field :first_name, :string
    field :last_name, :string
    field :asthmatic, :boolean, default: false
    field :blood_group, :string
    field :date_of_birth, :date
    field :diabetic, :boolean, default: false
    field :gender, :string
    field :picture, :string
    field :national_id, :string
    field :age, :integer
    field :weight, :string
    field :telephone, :string
    field :hypertensive, :boolean, default: false

    belongs_to :user, LifelineElixir.Accounts.User
    has_many :drugallergies, LifelineElixir.Drugallergies.Drugallergy
    has_many :foodallergies, LifelineElixir.Foodallergies.Foodallergy
    has_many :nextofkins, LifelineElixir.Nextofkins.Nextofkin

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    IO.inspect(attrs)
    IO.inspect(patient)
    patient
    |> cast(attrs, [
      :first_name,
      :last_name,
      :national_id,
      :age,
      :weight,
      :blood_group,
      :user_id,
      :diabetic,
      :hypertensive,
      :asthmatic,
      :gender,
      :date_of_birth,
      :telephone,
      :picture,
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :national_id,
      :age,
      :weight,
      :user_id,
      :diabetic,
      :date_of_birth,
      :telephone,
      :hypertensive,
      :asthmatic,
      :picture,
    ])


  end

end
