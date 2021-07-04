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

  def figure_next_due(
        %{
          "amount" => _amount,
          "initial_due_date" => initial_due_date,
          "name" => _name,
          "paid" => _paid,
          "frequency" => frequency,
          "user_id" => _user_id
        } = attrs
      ) do
    %{"day" => day, "month" => month, "year" => year} = initial_due_date

    {day, _} = Integer.parse(day)

    {month, _} = Integer.parse(month)

    {year, _} = Integer.parse(year)

    next_due_date = Date.new!(year, month, day)

    days_in_month = Date.days_in_month(next_due_date)

    case frequency do
      "Monthly" ->
        Map.put(attrs, "next_due_date", Date.add(next_due_date, days_in_month))

      "Bi-Weekly" ->
        Map.put(attrs, "next_due_date", Date.add(next_due_date, 15))
    end
  end

  def figure_next_due(
        %{
          "amount" => _amount,
          "initial_pay_date" => initial_pay_date,
          "name" => _name,
          "frequency" => frequency,
          "user_id" => _user_id
        } = attrs
      ) do
    %{"day" => day, "month" => month, "year" => year} = initial_pay_date

    {day, _} = Integer.parse(day)

    {month, _} = Integer.parse(month)

    {year, _} = Integer.parse(year)

    next_due_date = Date.new!(year, month, day)

    days_in_month = Date.days_in_month(next_due_date)

    case frequency do
      "Monthly" ->
        Map.put(attrs, "next_pay_date", Date.add(next_due_date, days_in_month))

      "Bi-Weekly" ->
        Map.put(attrs, "next_pay_date", Date.add(next_due_date, 15))
    end
  end
end
