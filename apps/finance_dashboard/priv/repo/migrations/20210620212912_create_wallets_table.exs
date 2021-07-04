defmodule FinanceDashboard.Repo.Migrations.CreateWalletsTable do
  use Ecto.Migration

  def change do
    create table(:wallets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, :integer
      add :name, :string
      add :amount, :decimal

      timestamps()
    end

    create(unique_index(:wallets, [:id]))
  end
end
