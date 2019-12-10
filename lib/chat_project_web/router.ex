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
    pipe_through [:browser, :authenticate_user]

    resources "/messages", MessageController
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login Requried")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()

      user_id ->
        assign(conn, :current_user, ChatProject.Accounts.get_user!(user_id))
    end
  end
end
