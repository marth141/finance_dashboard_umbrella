defmodule FinanceDashboard.Router do
  alias FinanceDashboard.Commands.AddWallet
  alias FinanceDashboard.Wallet

  use Commanded.Commands.Router, application: FinanceDashboard.Commanded
  identify Wallet, by: :wallet_id

  dispatch [AddWallet], to: Wallet
end
