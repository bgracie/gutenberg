defmodule GutenbergWeb.LanguageController do
  use GutenbergWeb, :controller

  alias Gutenberg.Books.Languages

  def index(conn, _params) do
    languages = Languages.list()
    render(conn, "index.html", languages: languages)
  end

  def show(conn, %{"id" => id}) do
    language = Languages.get!(id)
    render(conn, "show.html", language: language)
  end
end
