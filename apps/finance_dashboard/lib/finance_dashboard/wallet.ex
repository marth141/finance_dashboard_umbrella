defmodule FinanceDashboard.Wallet do
  alias FinanceDashboard.Commands.{
    AddWallet
  }

  alias FinanceDashboard.Events.{
    WalletAdded
  }

  alias __MODULE__
  defstruct ~w(
    wallet_id
    amount
    name
    owner_id
  )a

  def execute(%Wallet{wallet_id: nil}, %AddWallet{initial_amount: initial_amount} = cmd)
      when initial_amount > 0 do
    %WalletAdded{
      wallet_id: cmd.wallet_id,
      amount: cmd.initial_amount,
      wallet_name: cmd.name,
      wallet_owner_id: cmd.wallet_owner_id
    }
  end

  def apply(%Wallet{} = wallet, %WalletAdded{} = event) do
    %Wallet{
      wallet
      | wallet_id: event.wallet_id,
        amount: event.amount,
        name: event.wallet_name,
        owner_id: event.wallet_owner_id
    }
  end
end
