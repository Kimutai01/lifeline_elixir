defmodule LifelineElixir.Repo.Migrations.CreateDrugallergies do
  use Ecto.Migration

  def change do
    create table(:drugallergies) do
      add :name, :string, null: false

      add :patient_id, references(:patients, on_delete: :delete_all)

      timestamps()
    end
  end
end
