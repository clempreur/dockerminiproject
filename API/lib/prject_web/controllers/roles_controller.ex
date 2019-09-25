defmodule WorktimeWeb.RolesController do
  use WorktimeWeb, :controller

  alias Worktime.Auth
  alias Worktime.Auth.Roles

  action_fallback WorktimeWeb.FallbackController

  def create(conn, %{"roles" => roles_params}) do
    with {:ok, %Roles{} = roles} <- Auth.create_roles(roles_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.roles_path(conn, :show, roles))
      |> render("show.json", roles: roles)
    end
  end

  def show(conn, %{"id" => id}) do
    roles = Auth.get_roles!(id)
    render(conn, "show.json", roles: roles)
  end

  def delete(conn, %{"id" => id}) do
    roles = Auth.get_roles!(id)

    with {:ok, %Roles{}} <- Auth.delete_roles(roles) do
      send_resp(conn, :no_content, "")
    end
  end
end
