# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ex_project_management,
  ecto_repos: [ExProjectManagement.Repo]

# Configures the endpoint
config :ex_project_management, ExProjectManagementWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yyixVrOQ3Q43suMcBbTIt6HiGUMhzN1EBIH0R5sRfuyk5i924xTJ7XwLRfxMpKqJ",
  render_errors: [view: ExProjectManagementWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExProjectManagement.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
