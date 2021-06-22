defmodule FinanceDashboardWeb.Router do
  use FinanceDashboardWeb, :router

  import FinanceDashboardWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FinanceDashboardWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FinanceDashboardWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", FinanceDashboardWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/liveview/dashboard", metrics: FinanceDashboardWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", FinanceDashboardWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", FinanceDashboardWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    live "/bills", BillLive.Index, :index
    live "/bills/new", BillLive.Index, :new
    live "/bills/:id/edit", BillLive.Index, :edit

    live "/bills/:id", BillLive.Show, :show
    live "/bills/:id/show/edit", BillLive.Show, :edit

    live "/dashboard", DashboardLive.Index, :index
    live "/dashboard/bills/:id/edit", DashboardLive.Index, :edit

    live "/incomes", IncomeLive.Index, :index
    live "/incomes/new", IncomeLive.Index, :new
    live "/incomes/:id/edit", IncomeLive.Index, :edit

    live "/incomes/:id", IncomeLive.Show, :show
    live "/incomes/:id/show/edit", IncomeLive.Show, :edit

    live "/wallets", WalletLive.Index, :index
    live "/wallets/new", WalletLive.Index, :new
    live "/wallets/:id/edit", WalletLive.Index, :edit

    live "/wallets/:id", WalletLive.Show, :show
    live "/wallets/:id/show/edit", WalletLive.Show, :edit
  end

  scope "/", FinanceDashboardWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
