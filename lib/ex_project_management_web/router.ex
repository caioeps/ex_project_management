defmodule ExProjectManagementWeb.Router do
  use ExProjectManagementWeb, :router

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

  scope "/", ExProjectManagementWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ExProjectManagementWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]

    scope "/accounts", as: :accounts do
      resources "/registration", Accounts.RegistrationController, only: [:create, :show, :update, :delete]
    end
  end
end
