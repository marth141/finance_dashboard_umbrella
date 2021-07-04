defmodule FinanceDashboard.Projector do
  use Commanded.Projections.Ecto,
    application: FinanceDashboard.Commanded,
    repo: FinanceDashboard.Repo,
    name: "finance_dashboard_projections"

  alias FinanceDashboard.Events.{
    WalletAdded
  }

  alias FinanceDashboard.Accounts.Wallet

  project %WalletAdded{} = event, _meta, fn multi ->
    IO.inspect(event.wallet_owner_id, label: "wallet_owner_id")

    Ecto.Multi.insert(multi, :wallet, %Wallet{
      id: event.wallet_id,
      amount: event.amount,
      name: event.wallet_name,
      user_id: event.wallet_owner_id
    })
  end
end
