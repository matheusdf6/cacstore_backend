defmodule Cacstore.Repo do
  use Ecto.Repo,
    otp_app: :cacstore_backend,
    adapter: Ecto.Adapters.Postgres
end
