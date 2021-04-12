defmodule FinanceDashboardWeb.DashboardLive.Index do
  use FinanceDashboardWeb, :live_view

  alias FinanceDashboard.Accounts

  @impl true
  def mount(_params, _session, socket) do
    total_bills = Enum.reduce(list_bills(), 0, fn bill, acc -> Decimal.sub(acc, bill.amount) end)

    {:ok,
     socket
     |> assign(:bills, list_bills())
     |> assign(:last_bill, list_bills() |> List.last())
     |> assign(:income_value, 0)
     |> assign(
       :total_bills,
       total_bills
     )
     |> assign(:income_value_difference, get_difference(total_bills, 0))
     |> assign(
       :income_changeset,
       FinanceDashboardWeb.DashboardLive.IncomeValue.changeset(
         FinanceDashboardWeb.DashboardLive.IncomeValue.__struct__(%{income_value: 0})
       )
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("income_change", %{"income_value" => income_value}, socket) do
    try do
      total_bills = socket.assigns.total_bills
      difference = get_difference(total_bills, income_value)
      {:noreply, assign(socket, :income_value_difference, difference)}
    rescue
      _ ->
        total_bills = socket.assigns.total_bills
        difference = get_difference(total_bills, 0)
        {:noreply, assign(socket, :income_value_difference, difference)}
    end
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Paying Bill?")
    |> assign(:bill, Accounts.get_bill!(id))
  end

  defp apply_action(socket, :index, %{"income_value" => income_value}) do
    try do
      {income_value, _} = Decimal.parse(income_value)

      total_bills = socket.assigns.total_bills

      difference = get_difference(total_bills, income_value)

      socket
      |> assign(:income_value, income_value)
      |> assign(
        :total_bills,
        total_bills
      )
      |> assign(:income_value_difference, difference)
    rescue
      _ ->
        total_bills = socket.assigns.total_bills
        difference = get_difference(total_bills, 0)

        socket
        |> assign(:income_value, 0)
        |> assign(
          :total_bills,
          total_bills
        )
        |> assign(:income_value_difference, difference)
    end
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bills")
    |> assign(:bill, nil)
  end

  defp get_difference(total_bills, income_value) do
    Decimal.add(income_value, total_bills)
  end

  defp list_bills do
    Accounts.list_bills()
  end
end
