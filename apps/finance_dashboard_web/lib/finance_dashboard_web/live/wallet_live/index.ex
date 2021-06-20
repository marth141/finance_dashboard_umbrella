defmodule FinanceDashboardWeb.WalletLive.Index do
  use FinanceDashboardWeb, :live_view

  alias FinanceDashboard.Accounts
  alias FinanceDashboard.Accounts.Wallet

  @impl true
  def mount(_params, session, socket) do
    socket = assign_current_user(socket, session)

    {:ok,
     socket
     |> assign(
       :wallets,
       list_wallets_for_user(socket)
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Wallet")
    |> assign(:wallet, Accounts.get_wallet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Wallet")
    |> assign(:wallet, %Wallet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Wallet")
    |> assign(:wallet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    wallet = Accounts.get_wallet!(id)
    {:ok, _} = Accounts.delete_wallet(wallet)

    {:noreply, assign(socket, :wallets, list_wallets_for_user(socket))}
  end

  defp list_wallets_for_user(socket) do
    user_id = socket.assigns.current_user.id

    Accounts.list_wallets_for_user(user_id)
  end
end
