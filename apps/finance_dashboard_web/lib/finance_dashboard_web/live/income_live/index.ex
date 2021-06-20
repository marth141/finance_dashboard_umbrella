defmodule FinanceDashboardWeb.IncomeLive.Index do
  use FinanceDashboardWeb, :live_view

  alias FinanceDashboard.Accounts
  alias FinanceDashboard.Accounts.Income

  @impl true
  def mount(_params, session, socket) do
    socket = assign_current_user(socket, session)

    {:ok,
     socket
     |> assign(
       :incomes,
       list_incomes_for_user(socket)
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Income")
    |> assign(:income, Accounts.get_income!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Income")
    |> assign(:income, %Income{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Income")
    |> assign(:income, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    income = Accounts.get_income!(id)
    {:ok, _} = Accounts.delete_income(income)

    {:noreply, assign(socket, :incomes, list_incomes_for_user(socket))}
  end

  defp list_incomes_for_user(socket) do
    user_id = socket.assigns.current_user.id

    Accounts.list_incomes_for_user(user_id)
  end
end
