defmodule GutenbergWeb.BookController do
  use GutenbergWeb, :controller
  use Gutenberg.Library

  import Ecto.Query, warn: false

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", book: fetch_book(id))
  end

  defp fetch_book(id) do
    Db.Book
    |> Repo.get!(id)
    |> Repo.preload(
      book_formats: [:format],
      authors: [],
      subjects: [],
      languages: []
    )
  end
end
