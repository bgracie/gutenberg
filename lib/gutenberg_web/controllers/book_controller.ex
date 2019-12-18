defmodule GutenbergWeb.BookController do
  use GutenbergWeb, :controller

  import Ecto.Query, warn: false
  alias Gutenberg.Books
  alias Gutenberg.Repo

  def show(conn, %{"id" => id}) do
    book =
      Books.get!(id)
      |> Repo.preload([:authors, :subjects, :languages])
      |> Repo.preload(book_formats: :format)

    render(conn, "show.html", book: book)
  end
end
