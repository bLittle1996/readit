# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :readit,
  ecto_repos: [Readit.Repo]

# Configures the endpoint
config :readit, ReaditWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lijWPf2Y3YoLoRK7wLyOqBUzJTM7orV14cG9Px/Dg7qpmav/qE1oc6pDVcBz01fv",
  render_errors: [view: ReaditWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Readit.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian secret
config :readit, Readit.Auth.Guardian,
  issuer: "readit",
  secret_key: "+fQkcWvDie/ySv9StHKnNJkuOZy32G+xcd9tqGPcmldJk1BnEbyHgGDhlckpT0xw"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
