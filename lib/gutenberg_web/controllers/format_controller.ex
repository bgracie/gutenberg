defmodule GutenbergWeb.FormatController do
  use GutenbergWeb, :controller

  alias Gutenberg.Formats
  alias Gutenberg.Formats.Format

  def index(conn, _params) do
    formats = Formats.list_formats()
    render(conn, "index.html", formats: formats)
  end

  def show(conn, %{"id" => id}) do
    format = Formats.get_format!(id)
    render(conn, "show.html", format: format)
  end
end
