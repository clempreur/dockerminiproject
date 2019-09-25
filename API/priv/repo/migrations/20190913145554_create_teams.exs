defmodule Worktime.Repo.Migrations.CreateTeams do
  use Ecto.Migration
  alias Worktime.Auth

  def change do
    Auth.creates_roles([%{"label" => "Manager", "status" => 1}, %{"label" => "Employe", "status" => 2}, %{"label" => "Administrator", "status" => 3}])
    Auth.create_users(%{"roles" => 3, "firstname" => "admin", "lastname" => "admin", "email" => "admin@gmail.com", "password" => "admin", "timeByMonth" => 0})

    create table(:teams) do
      add :name, :string, null: false

      timestamps()
    end

  end
end
