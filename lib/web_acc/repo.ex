defmodule WebAcc.Repo do
  use Ecto.Repo,
    otp_app: :web_acc,
    adapter: Ecto.Adapters.Postgres
end
