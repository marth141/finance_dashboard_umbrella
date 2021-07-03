defmodule FinanceDashboardWeb.DashboardLive.Index do
  use FinanceDashboardWeb, :live_view

  alias FinanceDashboard.Accounts

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket = assign_current_user(socket, session)

    user_id = socket.assigns.current_user.id

    total_bills =
      Enum.reduce(list_bills_for_user(user_id), 0, fn bill, acc ->
        Decimal.sub(acc, bill.amount)
      end)

    total_income =
      Enum.reduce(list_incomes_for_user(user_id), 0, fn income, acc ->
        Decimal.add(acc, income.amount)
      end)

    total_wallet =
      Enum.reduce(list_wallets_for_user(user_id), 0, fn wallet, acc ->
        Decimal.add(acc, wallet.amount)
      end)

    {:ok,
     socket
     |> assign(:bills, list_bills_for_user(user_id))
     |> assign(:incomes, list_incomes_for_user(user_id))
     |> assign(:last_bill, list_bills_for_user(user_id) |> List.last())
     |> assign(:total_income, total_income)
     |> assign(:total_bills, total_bills)
     |> assign(:total_wallet, total_wallet)
     |> assign(:income_value_difference, get_difference(total_wallet, total_income, total_bills))
     |> handle_tick}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info(:tick, socket) do
    {:noreply, handle_tick(socket)}
  end

  def handle_tick(socket) do
    time = NaiveDateTime.local_now() |> NaiveDateTime.truncate(:second)
    assign(socket, :time, time)
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Paying Bill?")
    |> assign(:bill, Accounts.get_bill!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Finance Dashboard")
  end

  defp get_difference(total_wallet, total_income, total_bills) do
    Decimal.add(total_income, total_bills)
    |> Decimal.add(total_wallet)
  end

  defp list_bills_for_user(user_id) do
    Accounts.list_bills_for_user(user_id)
  end

  defp list_incomes_for_user(user_id) do
    Accounts.list_incomes_for_user(user_id)
  end

  defp list_wallets_for_user(user_id) do
    Accounts.list_wallets_for_user(user_id)
  end
end
