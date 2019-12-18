# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gutenberg,
  ecto_repos: [Gutenberg.Repo]

config :phoenix, :json_library, Jason

# Configures the endpoint
config :gutenberg, GutenbergWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CgM0JUUQds4JUzDbUswAePWpCpWYoOHFumdp7tHtzZPe/P9c7/ibE9R8geEPd2kG",
  render_errors: [view: GutenbergWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gutenberg.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :gutenberg,
  GutenbergWeb.Gettext,
  default_locale: "en",
  locales: ~w(en fr)

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
