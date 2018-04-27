defmodule GutenbergWeb.AuthorController do
  use GutenbergWeb, :controller

  alias Gutenberg.Authors
  alias Gutenberg.Authors.Author

  def index(conn, _params) do
    authors = Authors.list_authors()
    render(conn, "index.html", authors: authors)
  end

  def show(conn, %{"id" => id}) do
    author = Authors.get_author!(id)
      |> Gutenberg.Repo.preload([:books])
    render(conn, "show.html", author: author)
  end
end
