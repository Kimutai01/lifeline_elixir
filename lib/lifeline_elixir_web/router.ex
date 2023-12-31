defmodule LifelineElixirWeb.Router do
  use LifelineElixirWeb, :router

  import LifelineElixirWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LifelineElixirWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LifelineElixirWeb do
    pipe_through :browser

    # get "/", PageController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", LifelineElixirWeb do
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

      live_dashboard "/dashboard", metrics: LifelineElixirWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", LifelineElixirWeb do
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

  scope "/", LifelineElixirWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    live "/", PatientLive.Index, :index
    live "/patients/new", PatientLive.Index, :new
    live "/patients/:id/edit", PatientLive.Index, :edit

    live "/patients/:id", PatientLive.Show, :show
    live "/patients/:id/show/edit", PatientLive.Show, :edit

    live "/patients/:id/add_allergy", PatientLive.Show, :add_allergy
    live "/patients/:id/add_allergy/:allergy_id/edit", PatientLive.Show, :edit_allergy

    live "/patients/:id/add_food_allergy", PatientLive.Show, :add_food_allergy

    live "/patients/:id/add_food_allergy/:food_allergy_id/edit", PatientLive.Show, :edit_food_allergy
    live "/patients/:id/next_of_kin", PatientLive.Show, :add_next_of_kin
    live "/patients/:id/next_of_kin/:next_of_kin_id/edit", PatientLive.Show, :edit_next_of_kin




    live "/drugallergies", DrugallergyLive.Index, :index
    live "/drugallergies/new", DrugallergyLive.Index, :new
    live "/drugallergies/:id/edit", DrugallergyLive.Index, :edit

    live "/drugallergies/:id", DrugallergyLive.Show, :show
    live "/drugallergies/:id/show/edit", DrugallergyLive.Show, :edit


  end

  scope "/", LifelineElixirWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
