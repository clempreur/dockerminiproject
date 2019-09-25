defmodule Worktime.Auth.Clocks do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :time, :string
    field :status, :boolean
    belongs_to :users,  Worktime.Auth.Users

    timestamps()
  end

  @doc false
  def changeset(clocks, attrs) do
    clocks
    |> cast(attrs, [:time, :status])
    |> validate_required([:time, :status])
  end
end
