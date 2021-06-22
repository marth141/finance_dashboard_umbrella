defmodule FinanceDashboard.Repo.Migrations.CreateBillsTable do
  use Ecto.Migration

  def change do
    create table(:bills) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :initial_due_date, :date
      add :amount, :decimal
      add :paid, :boolean, default: false, null: false
      add :frequency, :string

      timestamps()
    end

  end
end
