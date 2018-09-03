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

  scope "/", FawkesWeb do
    pipe_through :browser # Use the default browser stack
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

  end

  scope "/signup", FawkesWeb.Signup, as: :signup do
    pipe_through :browser

    resources "/", UserController, only: [:new, :create]
  end

  scope "/login", FawkesWeb.Auth, as: :auth do
    pipe_through :browser

    resources "/", UserController, only: [:new, :create]
  end
  # Other scopes may use custom stacks.
  # scope "/api", FawkesWeb do
  #   pipe_through :api
  # end
end
