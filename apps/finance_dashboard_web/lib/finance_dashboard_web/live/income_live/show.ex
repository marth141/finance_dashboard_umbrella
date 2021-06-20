defmodule FinanceDashboardWeb.IncomeLive.Show do
  use FinanceDashboardWeb, :live_view

  alias FinanceDashboard.Accounts

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_current_user(session)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:income, Accounts.get_income!(id))}
  end

  defp page_title(:show), do: "Show Income"
  defp page_title(:edit), do: "Edit Income"
end
