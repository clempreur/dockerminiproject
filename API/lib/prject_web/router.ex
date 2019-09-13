defmodule WorktimeWeb.Router do
  use WorktimeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WorktimeWeb do
    pipe_through :api
    resources "/users", UsersController, except: [:new, :edit, :index]
      get "/users", UsersController, :emailandusername
    resources "/workingtimes", WorkingtimesController, only: [:update, :delete]
      get "/workingtimes/:userID", WorkingtimesController, :workingtimesgetall
      get "/workingtimes/:userID/:workingtimeID", WorkingtimesController, :workingtimesID
      post "/workingtimes", WorkingtimesController, :postworkingtimes
    resources "/clocks", ClocksController, only: [:show]
      post "/clocks", ClocksController, :clockspostid
  end
end
