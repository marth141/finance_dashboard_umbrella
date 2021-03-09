defmodule FinanceDashboardWeb.BillLive.Index do
  use FinanceDashboardWeb, :live_view

  alias FinanceDashboard.Accounts
  alias FinanceDashboard.Accounts.Bill

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bills, list_bills())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bill")
    |> assign(:bill, Accounts.get_bill!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bill")
    |> assign(:bill, %Bill{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bills")
    |> assign(:bill, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bill = Accounts.get_bill!(id)
    {:ok, _} = Accounts.delete_bill(bill)

    {:noreply, assign(socket, :bills, list_bills())}
  end

  defp list_bills do
    Accounts.list_bills()
  end
end
