defmodule GutenbergWeb.AuthorController do
  use GutenbergWeb, :controller

  def show(conn, %{"id" => id}) do
    author =
      Gutenberg.Books.Authors.get!(id)
      |> Gutenberg.Repo.preload([:books])

    render(conn, "show.html", author: author)
  end
end
