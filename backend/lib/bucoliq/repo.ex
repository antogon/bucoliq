defmodule Bucoliq.Repo do
  use Ecto.Repo,
    otp_app: :bucoliq,
    adapter: Ecto.Adapters.Postgres
end
