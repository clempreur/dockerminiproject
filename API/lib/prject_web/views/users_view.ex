defmodule WorktimeWeb.UsersView do
  use WorktimeWeb, :view
  alias WorktimeWeb.UsersView
  alias Worktime.Repo

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UsersView, "userteams.json")}
  end

  def render("show.json", %{users: users}) do
    %{data: render_one(users, UsersView, "userteams.json")}
  end

  def render("users.json", %{users: users}) do
    %{id: users.id, user: users.lastname, email: users.email}
  end

    def render("userteams.json", %{users: user}) do
      users = Repo.preload(user, [:teams])
      list = Enum.map(users.teams, fn t ->
        %{id: t.id, name: t.name}
      end)
      %{id: users.id, lastname: users.lastname,firstname: users.firstname ,role: users.roles_id,email: users.email,password: users.password, team: list}
    end
end
