defmodule Worktime.Auth.Roles do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :label, :string
    field :status, :integer
    has_many :users, Worktime.Auth.Users, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:label, :status])
    |> validate_required([:label, :status])
  end
end
