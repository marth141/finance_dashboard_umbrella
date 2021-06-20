defmodule FinanceDashboard.Accounts.Wallet do
  use Ecto.Schema
  import Ecto.Changeset
  alias FinanceDashboard.Accounts.{User}

  schema "wallets" do
    field :amount, :decimal
    field :name, :string

    belongs_to(:user, User, on_replace: :update)

    timestamps()
  end

  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:amount, :name, :user_id])
    |> validate_required([:amount, :name, :user_id])
  end
end
