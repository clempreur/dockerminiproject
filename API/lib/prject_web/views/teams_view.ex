defmodule WorktimeWeb.TeamsView do
  use WorktimeWeb, :view
  alias WorktimeWeb.TeamsView
  alias Worktime.Repo

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamsView, "teams.json")}
  end

  def render("show.json", %{teams: teams}) do
    %{data: render_one(teams, TeamsView, "teams.json")}
  end

  def render("teams.json", %{teams: teams}) do
    %{id: teams.id, name: teams.name}
  end

  def render("teamsdetail.json", %{teams: teams}) do
    teams = Repo.preload(teams, [:users])
    list = Enum.map(teams.users, fn u ->
      %{id: u.id, email: u.email, name: u.firstname}
    end)
    %{id: teams.id, name: teams.name, users: list}
  end

  def render("wrongteams.json", res) do
    %{error: Map.get(res, "rep")}
  end
end
