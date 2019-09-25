defmodule Worktime.Repo.Migrations.CreateTeamshasusers do
  use Ecto.Migration

  def change do
    create table(:teamshasusers) do
      add :users_id, references(:users)
      add :teams_id, references(:teams)
    end

    create unique_index(:teamshasusers, [:users_id, :teams_id])
  end
end
