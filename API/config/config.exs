# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :prject,
  namespace: Worktime,
  ecto_repos: [Worktime.Repo]

# Configures the endpoint
config :prject, WorktimeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tnJsTtCNIiFMVWrcfF8YjyFr2aarxA9kH8ltNMNFPX6QOi0GDuqIhv6WYP5u/1y0",
  render_errors: [view: WorktimeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Worktime.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
