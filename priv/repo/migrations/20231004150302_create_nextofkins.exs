defmodule LifelineElixir.Repo.Migrations.CreateNextofkins do
  use Ecto.Migration

  def change do
    create table(:nextofkins) do
      add :name, :string, null: false
      add :phone, :string , null: false, unique: true
      add :relationship, :string , null: false

      add :patient_id, references(:patients, on_delete: :delete_all)

      timestamps()
    end
    create unique_index(:nextofkins, [:phone])
  end
end
