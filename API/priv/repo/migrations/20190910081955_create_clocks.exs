defmodule Worktime.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :time, :string, null: false
      add :status, :boolean, null: false, default: true
      add :users_id, references(:users)

      timestamps()
    end
  end
end
