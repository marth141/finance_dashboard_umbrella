defmodule FinanceDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      FinanceDashboard.Repo,
      {Phoenix.PubSub, name: FinanceDashboard.PubSub},
      {FinanceDashboard.Commanded, []},
      FinanceDashboard.Projector,
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: FinanceDashboard.Supervisor)
  end
end
