defmodule FinanceDashboard.Accounts.Wallet do
  use Ecto.Schema
  import Ecto.Changeset
  alias FinanceDashboard.Accounts.{User}

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "wallets" do
    field :amount, :decimal
    field :name, :string

    belongs_to(:user, User, on_replace: :update, type: :integer)

    timestamps()
  end

  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:amount, :name, :user_id])
    |> validate_required([:amount, :name, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
