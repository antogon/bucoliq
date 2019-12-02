defmodule Bucoliq.Repo do
  use Ecto.Repo,
    otp_app: :bucoliq,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
