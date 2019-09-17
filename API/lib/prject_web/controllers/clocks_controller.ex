defmodule WorktimeWeb.ClocksController do
  use WorktimeWeb, :controller

  alias Worktime.Auth
  alias Worktime.Auth.Clocks

  action_fallback WorktimeWeb.FallbackController
  def clockspostid(conn, %{"clocks" => clocks_params}) do
    with {:ok, %Clocks{} = clocks} <- Auth.create_clocks(clocks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
      |> render("show.json", clocks: clocks)
    end
  end

  def show(conn, %{"id" => id}) do
    clocks = Auth.get_users_clock(id)
    render(conn, "index.json", clocks: clocks)
  end
end
