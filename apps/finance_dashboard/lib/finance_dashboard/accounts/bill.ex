defmodule FinanceDashboard.Accounts.Bill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bills" do
    field :amount, :decimal
    field :initial_due_date, :utc_datetime
    field :name, :string
    field :paid, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(bill, attrs) do
    bill
    |> cast(attrs, [:name, :initial_due_date, :amount, :paid])
    |> validate_required([:name, :initial_due_date, :amount, :paid])
  end
end
