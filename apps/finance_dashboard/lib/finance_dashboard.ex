defmodule FinanceDashboard do
  @moduledoc """
  FinanceDashboard keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def bills_within_next_two_weeks_from_pay_date?(bills, pay_date) do
    bills
    |> Enum.map(fn bill ->
      difference = Date.diff(bill.date, pay_date)
      {:ok, bill, difference >= 0 and difference <= 14}
    end)
  end

  def bills_after_next_two_weeks_from_pay_date?(bills, pay_date) do
    bills
    |> Enum.map(fn bill ->
      difference = Date.diff(bill.date, pay_date)
      {:ok, bill, difference <= 24 and difference > 14}
    end)
  end
end
