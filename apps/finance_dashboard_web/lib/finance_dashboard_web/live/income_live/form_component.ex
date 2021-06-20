defmodule FinanceDashboardWeb.IncomeLive.FormComponent do
  use FinanceDashboardWeb, :live_component

  alias FinanceDashboard.Accounts

  @impl true
  def update(%{income: income} = assigns, socket) do
    changeset = Accounts.change_income(income)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"income" => income_params}, socket) do
    income_params = assign_user(income_params, socket)

    changeset =
      socket.assigns.income
      |> Accounts.change_income(income_params)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:changeset, changeset)}
  end

  def handle_event("save", %{"income" => income_params}, socket) do
    save_income(socket, socket.assigns.action, income_params)
  end

  defp save_income(socket, :edit, income_params) do
    income_params = assign_user(income_params, socket)

    case Accounts.update_income(socket.assigns.income, income_params) do
      {:ok, _income} ->
        {:noreply,
         socket
         |> put_flash(:info, "Income updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_income(socket, :new, income_params) do
    income_params = assign_user(income_params, socket)

    case Accounts.create_income(income_params) do
      {:ok, _income} ->
        {:noreply,
         socket
         |> put_flash(:info, "Income created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp assign_user(income_params, socket) do
    Map.put(income_params, "user_id", socket.assigns.user_id)
  end
end
