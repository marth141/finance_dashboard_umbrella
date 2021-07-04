defmodule FinanceDashboard.Events.WalletAdded do
  @fields ~w(wallet_name amount wallet_id wallet_owner_id)a
  @enforce_keys @fields
  defstruct @fields
end
