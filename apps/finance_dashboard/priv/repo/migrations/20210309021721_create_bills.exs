defmodule FinanceDashboard.Repo.Migrations.CreateBills do
  use Ecto.Migration

  def change do
    create table(:bills) do
      add :name, :string
      add :initial_due_date, :utc_datetime
      add :amount, :decimal
      add :paid, :boolean, default: false, null: false

      timestamps()
    end

  end
end
