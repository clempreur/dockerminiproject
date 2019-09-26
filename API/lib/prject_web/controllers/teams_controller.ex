defmodule WorktimeWeb.TeamsController do
  use WorktimeWeb, :controller

  alias Worktime.Auth
  alias Worktime.Auth.Teams

  action_fallback WorktimeWeb.FallbackController

  def index(conn, _params) do
    teams = Auth.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def show(conn, %{"id" => id}) do
    teams = Auth.get_teams!(id)
    render(conn, "show.json", teams: teams)
  end

  def create(conn, %{"teams" => teams_params}) do
    with {:ok, %Teams{} = teams} <- Auth.create_teams(teams_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.teams_path(conn, :show, teams))
      |> render("show.json", teams: teams)
    end
  end

  def delete(conn, %{"id" => id}) do
    teams = Auth.get_teams!(id)

    with {:ok, %Teams{}} <- Auth.delete_teams(teams) do
      send_resp(conn, :no_content, "")
    end
  end

  def addusertoteam(conn, %{"id" => id, "users" => users}) do
    teams = Auth.get_teams!(id)

    with {:ok, %Teams{}} <- Auth.update_teams_add(teams, users) do
      render(conn, "teamsdetail.json", teams: teams)
    else message ->
      {:error, render(conn, "wrongteams.json", message)}
    end
  end

  def suppruserofteam(conn, %{"id" => id, "users" => users}) do
     Auth.update_teams_suppr(id, users)

    teams = Auth.get_teams!(id)
     render(conn, "teamsdetail.json", teams: teams)
  end

  def changeuserofteam(conn, %{"id" => id, "users" => users}) do
    teams = Auth.get_teams!(id)
    
    with {:ok, %Teams{}} <- Auth.change_teams_member(teams, users) do
      render(conn, "teamsdetail.json", teams: teams)
    else message ->
      {:error, render(conn, "wrongteams.json", message)}
    end
  end

  def changemanagerofteam(conn, %{"id" => id, "managerID" => managerID}) do
    teams = Auth.get_teams!(id)

    with {:ok, %Teams{}} <- Auth.change_teams_manager(teams, managerID) do
      render(conn, "teamsdetail.json", teams: teams)
    else message ->
      {:error, render(conn, "wrongteams.json", message)}
    end
  end
end