import Config

# Configure Mix tasks and generators
config :badger_data,
  ecto_repos: [BadgerData.Repo]

config :badger_data, Oban,
  repo: BadgerData.Repo,
  queues: [default: 10, parallel: 10, serial: 1]

config :badger_data, FeedexData.Exporters.Influx,
  default_host: "influx_host",
  default_port: "8086",
  default_user: "admin",
  default_pass: "admin", 
  default_database: "badger_data"

config :badger_web,
  generators: [context_app: false],
  badger_tag: "Badger"

# Configure the endpoint
config :badger_web, BadgerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QT4EfpUZ5vHrbWF+6GGLI37kWRWKJgGq2cuN1nmKkhBQnZgpx8MJ9QosfHGlCVGe",
  render_errors: [view: BadgerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BadgerWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configure Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :badger_web, BadgerWeb.Endpoint, live_view: [signing_salt: "asdf"]

if Mix.env == :dev do
  config :mix_test_watch, clear: true
end
