defmodule GutenbergWeb.Router do
  use GutenbergWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SetLocale,
      gettext: GutenbergWeb.Gettext,
      default_locale: "en",
      cookie_key: "project_locale"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GutenbergWeb do
    pipe_through :browser

    # Will never be called, since locale prefix is always set
    get "/", PageController, :noop
  end


  scope "/:locale", GutenbergWeb do
    pipe_through :browser

    resources "/books", BookController, only: [:show]
    resources "/authors", AuthorController, only: [:show]
    resources "/subjects", SubjectController, only: [:show]

    post "/search", SearchController, :search
    get "/search", SearchController, :search
    get "/", FrontController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GutenbergWeb do
  #   pipe_through :api
  # end
end
