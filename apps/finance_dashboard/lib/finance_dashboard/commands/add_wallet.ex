defmodule FinanceDashboard.Commands.AddWallet do
  @fields ~w(name initial_amount wallet_id wallet_owner_id)a
  @enforce_keys @fields
  defstruct @fields

  def new(owner_id, wallet_params) do
    wallet_id = Ecto.UUID.generate()

    cmd = struct(__MODULE__, Map.merge(wallet_params, %{wallet_owner_id: owner_id, wallet_id: wallet_id}))
    {:ok, cmd}
  end
end
