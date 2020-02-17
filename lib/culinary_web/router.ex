defmodule CulinaryWeb.Router do
  use CulinaryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CulinaryWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CulinaryWeb do
    pipe_through :browser 

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/customers", CustomerController
  end

  scope "/api", CulinaryWeb.Api, as: :api do
    pipe_through :api

    #resources "/customers", CustomerController, except: [:new, :edit]
    resources "/shops", ShopController, except: [:new, :edit]
  end

  scope "/notfoodpanda", CulinaryWeb do
    pipe_through [:browser, :authenticate_customer]

    resources "/supplies", SupplyController
    resources "/transactions", TransactionController, only: [:index, :show, :new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", CulinaryWeb do
  #   pipe_through :api
  # end
end
