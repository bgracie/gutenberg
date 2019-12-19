defmodule GutenbergWeb.BookController do
  use GutenbergWeb, :controller
  use Gutenberg.Library

  import Ecto.Query, warn: false

  def show(conn, %{"id" => id}) do
    book =
      Db.Book
      |> Repo.get!(id)
      |> Repo.preload(
        book_formats: [:format],
        authors: [],
        subjects: [],
        languages: []
      )

    render(conn, "show.html", book: book)
  end
end
