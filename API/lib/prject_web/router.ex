defmodule WorktimeWeb.Router do
  use WorktimeWeb, :router

  pipeline :api do
	  plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", WorktimeWeb do
    pipe_through :api
    resources "/users", UsersController, except: [:new, :edit, :show, :update]
      options "/users", UsersController, :options
      get "/users/by_id", UsersController, :show
      get "/users/sign_in", UsersController, :emailandpassword
      get "/users/search_user", UsersController, :bynameorlastname
      options "/users/sign_up", UsersController, :options
      post "/users/sign_up", UsersController, :create
      options "/users/update", UsersController, :options
      put "/users/update", UsersController, :update
      options "/users/promote", UsersController, :options
      put "/users/promote", UsersController, :promote
    resources "/roles", RolesController, only: [:create, :show, :delete]
    resources "/workingtimes", WorkingtimesController, only: [:update, :delete]
      get "/workingtimes/:userID", WorkingtimesController, :workingtimesgetall
      get "/workingtimes/:userID/:workingtimeID", WorkingtimesController, :workingtimesID
      options "/workingtimes", WorkingtimesController, :options
      post "/workingtimes", WorkingtimesController, :postworkingtimes
    resources "/clocks", ClocksController, only: [:show]
      options "/clocks", ClocksController, :options
      post "/clocks", ClocksController, :clockspostid
    resources "/teams", TeamsController, only: [:create, :index, :show, :delete]
      options "/teams", TeamsController, :options
      options "/teams/add_user", TeamsController, :options
      put "/teams/add_user", TeamsController, :addusertoteam
      options "/teams/suppr_user", TeamsController, :options
      put "/teams/suppr_user", TeamsController, :suppruserofteam
      options "/teams/change_user", TeamsController, :options
      put "/teams/change_user", TeamsController, :changeuserofteam
      options "/teams/change_manager", TeamsController, :options
      put "/teams/change_manager", TeamsController, :changemanagerofteam
  end
end
