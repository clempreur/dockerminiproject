defmodule WorktimeWeb.UsersController do
  use WorktimeWeb, :controller

  alias Worktime.Auth
  alias Worktime.Auth.Users

  action_fallback WorktimeWeb.FallbackController

  def index(conn, %{}) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    users = Auth.get_users!(id)
    render(conn, "userteams.json", users: users)
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- Auth.create_users(users_params) do
      conn
      |> put_status(:created)
      |> render("show.json", users: users)
    else message ->
      {:error, render(conn, "wrongmail.json", message)}
    end
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Auth.get_users!(id)

    with {:ok, %Users{} = users} <- Auth.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    else message ->
      {:error, render(conn, "wrongmail.json", message)}
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Auth.get_users!(id)

    with {:ok, %Users{}} <- Auth.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end

  def emailandpassword(conn, %{"email" => email, "password" => password}) do
    users = Worktime.Auth.authenticate_user(email, password)
    render(conn, "index.json", users: users)
  end

  def bynameorlastname(conn, %{"nameSearch" => nameSearch}) do
    users = Worktime.Auth.authenticate_user(nameSearch)
    render(conn, "index.json", users: users)
  end

  def promote(conn, %{"id" => id, "role" => roleID}) do
    users = Auth.get_users!(id)

    {:ok, users} = Worktime.Auth.promote_users(users, roleID)
    render(conn, "show.json", users: users)
  end
end
