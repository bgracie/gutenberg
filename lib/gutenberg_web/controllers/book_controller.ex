defmodule GutenbergWeb.BookController do
  use GutenbergWeb, :controller

  import Ecto.Query, warn: false
  alias Gutenberg.Books
  alias Gutenberg.Books.Book
  alias Gutenberg.Repo

  def index(conn, params) do
    results_per_page = 10

    current_page = (params["page"] && String.to_integer(params["page"])) || 1
    total_pages = (Repo.one(from b in Book, select: count(b.id)) / results_per_page)
      |> Float.ceil
      |> round()

    books = (from b in Book,
      select: [:id, :title],
      offset: ^((current_page - 1) * results_per_page),
      order_by: b.title,
      limit: 10,
      preload: [:authors]
    ) |> Repo.all

    render(
      conn,
      "index.html",
      books: books,
      current_page: current_page,
      total_pages: total_pages
    )
  end

  def show(conn, %{"id" => id}) do
    book = Books.get_book!(id)
      |> Repo.preload([:authors, :subjects, :languages])
      |> Repo.preload([book_formats: :format])

    render(conn, "show.html", book: book)
  end
end
