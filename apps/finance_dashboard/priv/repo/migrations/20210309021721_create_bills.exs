defmodule FinanceDashboard.Repo.Migrations.CreateBills do
  use Ecto.Migration

  def change do
    create table(:bills) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :initial_due_date, :date
      add :amount, :decimal
      add :paid, :boolean, default: false, null: false

      timestamps()
    end

  end
end
