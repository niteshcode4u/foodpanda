# General application configuration
import Config

config :foodpanda, Foodpanda.ContentAPI,
  base_url: System.get_env("BASE_URL", "https://cdn.contentful.com"),
  spaces: System.get_env("SPACES", "kk2bw5ojx476"),
  environments: System.get_env("ENVIRONMENTS", "master"),
  access_token:
    System.get_env(
      "ACCESS_TOKEN",
      "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
    ),
  content_type: System.get_env("CONTENT_TYPE", "recipe")

# Configures the endpoint
config :foodpanda, FoodpandaWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: FoodpandaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Foodpanda.PubSub,
  live_view: [signing_salt: "6PgM/bXE"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
