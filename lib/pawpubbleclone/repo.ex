defmodule Pawpubbleclone.Repo do
  use Ecto.Repo,
    otp_app: :pawpubbleclone,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
end
