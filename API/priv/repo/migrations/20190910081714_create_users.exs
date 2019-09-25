defmodule Worktime.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :password, :string, null: false
      add :email, :string, null: false
      add :timeByMonth, :integer, null: false
    end
  end
end
