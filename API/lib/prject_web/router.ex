defmodule WorktimeWeb.Router do
  use WorktimeWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*" #j'ai autoriser toutes adresses
    plug :accepts, ["json"]
  end

  scope "/api", WorktimeWeb do
    pipe_through :api
    resources "/users", UsersController, except: [:new, :edit, :show, :update]
      get "/users/by_id", UsersController, :show
      get "/users/sign_in", UsersController, :emailandpassword
      get "/users/search_user", UsersController, :bynameorlastname
      post "/users/sign_up", UsersController, :create
      put "/users/update/:id", UsersController, :update
    put "/users/promote", UsersController, :promote
    resources "/roles", RolesController, only: [:create, :show, :delete]
    resources "/workingtimes", WorkingtimesController, only: [:update, :delete]
      get "/workingtimes/:userID", WorkingtimesController, :workingtimesgetall
      get "/workingtimes/:userID/:workingtimeID", WorkingtimesController, :workingtimesID
      post "/workingtimes", WorkingtimesController, :postworkingtimes
    resources "/clocks", ClocksController, only: [:show]
      post "/clocks", ClocksController, :clockspostid
    resources "/teams", TeamsController, only: [:create, :index, :show, :delete]
      put "/teams/add_user", TeamsController, :addusertoteam
      put "/teams/suppr_user", TeamsController, :suppruserofteam
      put "/teams/change_user", TeamsController, :changeuserofteam

  end
end
