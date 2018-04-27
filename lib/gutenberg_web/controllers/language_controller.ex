defmodule GutenbergWeb.LanguageController do
  use GutenbergWeb, :controller

  alias Gutenberg.Languages
  alias Gutenberg.Languages.Language

  def index(conn, _params) do
    languages = Languages.list_languages()
    render(conn, "index.html", languages: languages)
  end

  def show(conn, %{"id" => id}) do
    language = Languages.get_language!(id)
    render(conn, "show.html", language: language)
  end
end
