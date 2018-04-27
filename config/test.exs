use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gutenberg, GutenbergWeb.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

config :gutenberg, :sql_sandbox, true

# Configure your database
config :gutenberg, Gutenberg.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gutenberg_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
