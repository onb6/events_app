use Mix.Config

config :events_app, EventsApp.Endpoint, 
  env: "test"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :events_app, EventsAppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :events_app, EventsApp.Repo,
  username: "events_apps",
  password: "91145",
  database: "events_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
