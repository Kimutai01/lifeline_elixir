defmodule LifelineElixir.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :first_name, :string
      add :last_name, :string
      add :national_id, :string
      add :date_of_birth, :date
      add :telephone, :string
      add :blood_group, :string
      add :age, :integer
      add :gender, :string
      add :weight, :string
      add :diabetic, :boolean, default: false, null: false
      add :hypertensive, :boolean, default: false, null: false
      add :asthmatic, :boolean, default: false, null: false
      add :user_id , references(:users,  on_delete: :delete_all)

      timestamps()
    end
  end
end
