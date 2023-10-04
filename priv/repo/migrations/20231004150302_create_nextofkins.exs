defmodule LifelineElixir.Repo.Migrations.CreateNextofkins do
  use Ecto.Migration

  def change do
    create table(:nextofkins) do
      add :name, :string
      add :phone, :string
      add :relationship, :string

      add :patient_id, references(:patients, on_delete: :delete_all)

      timestamps()
    end
  end
end
