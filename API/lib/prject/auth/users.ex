defmodule Worktime.Auth.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :lastname, :string
    field :firstname, :string
    field :password, :string
    field :timeByMonth, :integer
    field :roles_id, :integer
    has_many :clocks, Worktime.Auth.Clocks
    has_many :workingtimes, Worktime.Auth.Workingtimes
    many_to_many :teams, Worktime.Auth.Teams, join_through: "teamshasusers", on_replace: :delete, defaults: [teams: []]

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:lastname, :firstname, :password, :email, :timeByMonth, :roles_id])
    |> validate_required([:lastname, :firstname, :password, :email, :timeByMonth, :roles_id])
  end
end
