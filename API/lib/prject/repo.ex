defmodule Worktime.Repo do
  use Ecto.Repo,
    otp_app: :prject,
    adapter: Ecto.Adapters.Postgres
end
