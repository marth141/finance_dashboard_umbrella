defmodule FinanceDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FinanceDashboard.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: FinanceDashboard.PubSub}
      # Start a worker by calling: FinanceDashboard.Worker.start_link(arg)
      # {FinanceDashboard.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: FinanceDashboard.Supervisor)
  end
end
