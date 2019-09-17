defmodule WorktimeWeb.UsersController do
  use WorktimeWeb, :controller

  alias Worktime.Auth
  alias Worktime.Auth.Users

  action_fallback WorktimeWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- Auth.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Auth.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Auth.get_users!(id)

    with {:ok, %Users{} = users} <- Auth.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Auth.get_users!(id)

    with {:ok, %Users{}} <- Auth.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end

  def emailandusername(conn, %{"email" => email, "username" => username}) do
    users = Worktime.Auth.authenticate_user(email, username)
    render(conn, "index.json", users: users)
  end
end
