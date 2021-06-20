defmodule FinanceDashboard.Repo.Migrations.CreateIncomesTable do
  use Ecto.Migration

  def change do
    create table(:incomes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :initial_pay_date, :date
      add :amount, :decimal

      timestamps()
    end

  end
end
