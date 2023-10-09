defmodule LifelineElixir.Repo.Migrations.CreateFoodallergies do
  use Ecto.Migration

  def change do
    create table(:foodallergies) do
      add :name, :string, null: false

      add :patient_id, references(:patients, on_delete: :delete_all)

      timestamps()
    end
  end
end
