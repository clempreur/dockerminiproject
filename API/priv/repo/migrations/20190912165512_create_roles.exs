defmodule Worktime.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :label, :string, null: false
      add :status, :integer, null: false

      timestamps()
    end

    alter table(:users) do
       add :roles_id, references(:roles)

       timestamps()
    end

  end
end
