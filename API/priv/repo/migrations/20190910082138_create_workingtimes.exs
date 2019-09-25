defmodule Worktime.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :string, null: false
      add :end, :string, null: false
      add :users_id, references(:users)

      timestamps()
    end
  end
end
