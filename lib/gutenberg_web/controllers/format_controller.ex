defmodule GutenbergWeb.FormatController do
  use GutenbergWeb, :controller

  alias Gutenberg.Books.Formats

  def index(conn, _params) do
    formats = Formats.list()
    render(conn, "index.html", formats: formats)
  end

  def show(conn, %{"id" => id}) do
    format = Formats.get!(id)
    render(conn, "show.html", format: format)
  end
end
