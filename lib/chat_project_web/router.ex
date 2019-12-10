defmodule ChatProjectWeb.Router do
  use ChatProjectWeb, :router

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

  scope "/", ChatProjectWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController

    resources "/sessions", SessionController, only: [:new, :create, :delete],
      singleton: true
  end

  scope "/chat", ChatProjectWeb do
    pipe_through :browser

    resources "/messages", MessageController
  end
end
