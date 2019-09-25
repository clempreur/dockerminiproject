defmodule WorktimeWeb.RolesView do
  use WorktimeWeb, :view
  alias WorktimeWeb.RolesView

  def render("index.json", %{roles: roles}) do
    %{data: render_many(roles, RolesView, "roles.json")}
  end

  def render("show.json", %{roles: roles}) do
    %{data: render_one(roles, RolesView, "roles.json")}
  end

  def render("roles.json", %{roles: roles}) do
    %{id: roles.id,
      label: roles.label,
      status: roles.status}
  end
end
