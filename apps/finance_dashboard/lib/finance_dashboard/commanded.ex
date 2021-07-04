defmodule FinanceDashboard.Commanded do
  use Commanded.Application,
    otp_app: :finance_dashboard,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: FinanceDashboard.EventStore
    ],
    pub_sub: :local,
    registry: :local

  router(FinanceDashboard.Router)
end
