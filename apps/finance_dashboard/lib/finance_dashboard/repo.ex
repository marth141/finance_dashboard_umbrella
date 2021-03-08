defmodule FinanceDashboard.Repo do
  use Ecto.Repo,
    otp_app: :finance_dashboard,
    adapter: Ecto.Adapters.Postgres
end
