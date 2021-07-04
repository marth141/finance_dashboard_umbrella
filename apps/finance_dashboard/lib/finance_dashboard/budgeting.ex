defmodule FinanceDashboard.Budgeting do
  alias FinanceDashboard.Accounts.User
  alias FinanceDashboard.Router
  alias FinanceDashboard.Repo
  alias FinanceDashboard.Commands.{
    AddWallet,
  }

  def add_wallet(%User{} = current_user, wallet_params \\ %{}) do
    # build command struct
    # give command struct to commanded router
    # commanded router uses command to setup new aggregate
    # new aggregate consumes command and inserts event to event store

    with {:ok, %AddWallet{} = cmd} <- AddWallet.new(current_user.id, wallet_params) do
      IO.inspect(cmd, label: "cmd")
      Router.dispatch(cmd)
    end
  end

end
