# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cacstore_backend,
  ecto_repos: [Cacstore.Repo]

# Configures the endpoint
config :cacstore_backend, CacstoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fCEZGQQgQ1baBtwQc7SIglxz4vtdnRA4YTKNtFiuppmyDw8Pnpe/I0H7+Po28BDE",
  render_errors: [view: CacstoreWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Cacstore.PubSub,
  live_view: [signing_salt: "y9RxJuYJ"]

config :cacstore_backend, Cacstore.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :cacstore_backend,
  product_repository: Cacstore.Data.Repositories.ProductRepository,
  coupon_repository: Cacstore.Data.Repositories.CouponRepository

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
