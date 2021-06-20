defmodule FinanceDashboard.Repo.Migrations.CreateWalletsTable do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string
      add :amount, :decimal

      timestamps()
    end

  end
end
