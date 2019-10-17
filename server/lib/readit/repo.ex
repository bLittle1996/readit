defmodule Readit.Repo do
  use Ecto.Repo,
    otp_app: :readit,
    adapter: Ecto.Adapters.Postgres
end
