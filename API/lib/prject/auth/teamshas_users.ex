defmodule Worktime.Auth.TeamshasUsers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teamshasusers" do

  end

  @doc false
  def changeset(teamshas_users, attrs) do
    teamshas_users
    |> cast(attrs, [])
    |> validate_required([])
  end
end
