defmodule LifelineElixir.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :national_id, :string, null: false, unique: true
      add :date_of_birth, :date, null: false
      add :telephone, :string, null: false
      add :blood_group, :string, null: false
      add :age, :integer, null: false
      add :gender, :string, null: false
      add :picture, :string, null: false
      add :weight, :string, null: false
      add :diabetic, :boolean, default: false, null: false
      add :hypertensive, :boolean, default: false, null: false
      add :asthmatic, :boolean, default: false, null: false
      add :user_id , references(:users,  on_delete: :delete_all)

      timestamps()
    end
    create unique_index(:patients, [:national_id])


  end
end
