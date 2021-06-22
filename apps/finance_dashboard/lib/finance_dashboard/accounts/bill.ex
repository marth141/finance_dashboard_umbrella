defmodule FinanceDashboard.Accounts.Bill do
  use Ecto.Schema
  import Ecto.Changeset
  alias FinanceDashboard.Accounts.{User}

  schema "bills" do
    field :amount, :decimal
    field :initial_due_date, :date
    field :name, :string
    field :paid, :boolean, default: false
    field :frequency, :string

    belongs_to(:user, User, on_replace: :update)

    timestamps()
  end

  @doc false
  def changeset(bill, attrs) do
    bill
    |> cast(attrs, [:name, :initial_due_date, :amount, :paid, :user_id, :frequency])
    |> validate_required([:name, :initial_due_date, :amount, :paid, :user_id, :frequency])
  end
end
