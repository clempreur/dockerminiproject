defmodule Worktime.Auth.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    has_many :clocks, Worktime.Auth.Clocks
    has_many :workingtimes, Worktime.Auth.Workingtimes

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
  end
end
