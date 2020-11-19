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
config :whatever,
  ecto_repos: [Whatever.Repo]

config :whatever_web,
  ecto_repos: [Whatever.Repo],
  generators: [context_app: :whatever]

# Configures the endpoint
config :whatever_web, WhateverWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9vE8H0xGxTwJu7VTIG9n8UL9actgvGcVlyoJe1c+hOE5vFvfHCCJnyTh0E4tu38M",
  render_errors: [view: WhateverWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Whatever.PubSub,
  live_view: [signing_salt: "985Tk0EN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
