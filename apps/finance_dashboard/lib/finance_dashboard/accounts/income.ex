defmodule FinanceDashboard.Accounts.Income do
  use Ecto.Schema
  import Ecto.Changeset
  alias FinanceDashboard.Accounts.{User}

  schema "incomes" do
    field :amount, :decimal
    field :initial_pay_date, :date
    field :name, :string
    field :frequency, :string

    belongs_to(:user, User, on_replace: :update)

    timestamps()
  end

  def changeset(income, attrs) do
    income
    |> cast(attrs, [:amount, :initial_pay_date, :name, :user_id, :frequency])
    |> validate_required([:amount, :initial_pay_date, :name, :user_id, :frequency])
    |> foreign_key_constraint(:user_id)
  end
end
