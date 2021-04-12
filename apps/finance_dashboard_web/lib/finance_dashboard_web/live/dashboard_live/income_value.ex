defmodule FinanceDashboardWeb.DashboardLive.IncomeValue do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:income_value, :decimal)
  end

  def changeset(income, params \\ %{}) do
    income
    |> cast(params, [:income_value])
  end
end
