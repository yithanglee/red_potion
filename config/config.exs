# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :web_acc,
  ecto_repos: [WebAcc.Repo]

# Configures the endpoint
config :web_acc, WebAccWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "p53R0ziRMkeFbmLKlNK/yqg7q1OmOFTbg4caLg3O3nFNguU04qsnCJrurEUE1Xm7",
  render_errors: [view: WebAccWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebAcc.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :red_potion, :project, %{name: "WebAcc", alias_name: "web_acc", vsn: "0.1.0"}

config :red_potion, :server, %{
  url: "139.162.29.108",
  username: "ubuntu",
  key: System.get_env("SERVER_KEY"),
  domain_name: "damienslab.ga"
}
