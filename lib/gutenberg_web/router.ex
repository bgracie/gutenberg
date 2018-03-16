defmodule GutenbergWeb.Router do
  use GutenbergWeb, :router

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

  scope "/", GutenbergWeb do
    pipe_through :browser # Use the default browser stack

    resources "/books", BookController
    resources "/authors", AuthorController
    resources "/formats", FormatController
    resources "/languages", LanguageController
    resources "/subjects", SubjectController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GutenbergWeb do
  #   pipe_through :api
  # end
end
