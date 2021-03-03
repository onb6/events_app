use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :events_app, EventsAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :events_app, EventsApp.Repo,
  username: "postgres",
  password: "91145",
  database: "events_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
