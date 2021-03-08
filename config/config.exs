# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :finance_dashboard,
  ecto_repos: [FinanceDashboard.Repo]

config :finance_dashboard_web,
  ecto_repos: [FinanceDashboard.Repo],
  generators: [context_app: :finance_dashboard]

# Configures the endpoint
config :finance_dashboard_web, FinanceDashboardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WpZqR5qsPk3ha5AMxlLkZpBWZyhcKMKvnR7C/OZqCm/zpuv5EWVtC/6aZJ9S/c85",
  render_errors: [view: FinanceDashboardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FinanceDashboard.PubSub,
  live_view: [signing_salt: "OmDcAddt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
