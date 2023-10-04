defmodule LifelineElixir.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :first_name, :string
      add :last_name, :string
      add :national_id, :string
      add :height, :string
      add :age, :integer
      add :weight, :string

      timestamps()
    end
  end
end
