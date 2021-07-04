defmodule FinanceDashboardWeb.WalletLive.FormComponent do
  use FinanceDashboardWeb, :live_component

  alias FinanceDashboard.Accounts

  @impl true
  def update(%{wallet: wallet} = assigns, socket) do
    changeset = Accounts.change_wallet(wallet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"wallet" => wallet_params}, socket) do
    changeset =
      socket.assigns.wallet
      |> Accounts.change_wallet(wallet_params, socket.assigns.current_user)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:changeset, changeset)}
  end

  def handle_event("save", %{"wallet" => wallet_params}, socket) do
    save_wallet(socket, socket.assigns.action, wallet_params)
  end

  defp save_wallet(socket, :edit, wallet_params) do
    case Accounts.update_wallet(socket.assigns.wallet, wallet_params, socket.assigns.current_user) do
      {:ok, _wallet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Wallet updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_wallet(socket, :new, wallet_params) do
    case Accounts.create_wallet(wallet_params, socket.assigns.current_user) do
      {:ok, _wallet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Wallet created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
