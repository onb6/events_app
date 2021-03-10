defmodule EventsAppWeb.Router do
  use EventsAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug EventsAppWeb.Plugs.FetchSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", EventsAppWeb do
    pipe_through :browser

    get "/users/photo/:id", UserController, :photo
    get "/", PageController, :index
    resources "/users", UserController
    resources "/events", EventController
    resources "/comments", CommentController
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
    resources "/updates", UpdateController

  end


end
