defmodule GutenbergWeb.LanguageController do
  use GutenbergWeb, :controller

  alias Gutenberg.Books.Languages

  def index(conn, _params) do
    languages = Languages.list()
    render(conn, "index.html", languages: languages)
  end
end
