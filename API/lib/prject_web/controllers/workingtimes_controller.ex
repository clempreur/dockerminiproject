defmodule WorktimeWeb.WorkingtimesController do
  use WorktimeWeb, :controller

  alias Worktime.Auth
  alias Worktime.Auth.Workingtimes

  action_fallback WorktimeWeb.FallbackController

  def workingtimesgetall(conn, %{"userID" => userID}) do
    workingtimes = Auth.get_workingtimesbyuser(userID)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def workingtimesID(conn, %{"userID" => userID, "workingtimeID" => workingtimeID}) do
    workingtimes = Auth.get_workingtimes!(userID, workingtimeID)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def postworkingtimes(conn, %{"workingtimes" => workingtimes_params}) do
    with {:ok, %Workingtimes{} = workingtimes} <- Auth.create_workingtimes(workingtimes_params) do
      conn
      |> put_status(:created)
      |> render("show.json", workingtimes: workingtimes)
    end
  end

  def update(conn, %{"id" => id, "workingtimes" => workingtimes_params}) do
    workingtimes = Auth.get_workingtimes!(id)

    with {:ok, %Workingtimes{} = workingtimes} <- Auth.update_workingtimes(workingtimes, workingtimes_params) do
      render(conn, "show.json", workingtimes: workingtimes)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtimes = Auth.get_workingtimes!(id)

    with {:ok, %Workingtimes{}} <- Auth.delete_workingtimes(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end
end
