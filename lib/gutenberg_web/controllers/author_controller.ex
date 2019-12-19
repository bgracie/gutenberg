defmodule GutenbergWeb.AuthorController do
  use GutenbergWeb, :controller
  use Gutenberg.Library

  def show(conn, %{"id" => id}) do
    author = Db.Author |> Repo.get!(id) |> Repo.preload([:books])

    render(conn, "show.html", author: author)
  end
end
