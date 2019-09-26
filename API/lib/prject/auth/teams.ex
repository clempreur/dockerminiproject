defmodule Worktime.Auth.Teams do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :manager_id, :integer
    many_to_many :users, Worktime.Auth.Users, join_through: "teamshasusers", on_replace: :delete, defaults: [users: []]

    timestamps()
  end

  @doc false
  def changeset(teams, attrs) do
    teams
    |> cast(attrs, [:name, :manager_id])
    |> validate_required([:name])
  end
end
