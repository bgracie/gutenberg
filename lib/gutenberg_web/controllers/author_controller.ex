defmodule GutenbergWeb.AuthorController do
  use GutenbergWeb, :controller

  def index(conn, _params) do
    authors = Gutenberg.Books.Authors.list()
    render(conn, "index.html", authors: authors)
  end

  def show(conn, %{"id" => id}) do
    author = Gutenberg.Books.Authors.get!(id)
      |> Gutenberg.Repo.preload([:books])
    render(conn, "show.html", author: author)
  end
end
