defmodule FawkesWeb.Router do
  use FawkesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :guardian do
    plug FawkesWeb.Guardian.Plug
    plug FawkesWeb.Guardian.CurrentUserPlug
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", FawkesWeb do
    pipe_through [:browser, :guardian, :ensure_auth]
    post("/logout", Auth.UserController, :delete)
  end

  scope "/", FawkesWeb do
    pipe_through [:browser, :guardian]
    get "/about", PageController, :about

    get "/", PageController, :index
    get "/categories/new", CategoryController, :new
    post "/categories", CategoryController, :create
    get "/categories/:id", CategoryController, :show
    delete "/categories/:id", CategoryController, :delete
    get "/categories", CategoryController, :index

    resources "/audiences", AudienceController
    resources "/schedule_slots", SlotController
    resources "/talks", TalkController
    resources "/speakers", SpeakerController
    resources("/member", ProfileController, only: [:index, :show])

  end

  scope "/signup", FawkesWeb.Signup, as: :signup do
    pipe_through [:browser, :guardian]

    resources "/", UserController, only: [:new, :create]
  end

  scope "/login", FawkesWeb.Auth, as: :auth do
    pipe_through [:browser, :guardian]

    resources "/", UserController, only: [:new, :create]
  end

  scope "/", FawkesWeb, as: :membership do
    pipe_through [:browser, :guardian, :ensure_auth]

    resources("/profile", ProfileController, only: [:edit, :update], singleton: true)
  end

  scope "/api", FawkesWeb do
    pipe_through [:api]

    resources "/users_talks", UserTalkController, except: [:new, :edit]
  end
end
