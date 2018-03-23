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

  def new(conn, _params) do
    changeset = Books.change_book(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case Books.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: book_path(conn, :show, book))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Books.get_book!(id)
      |> Repo.preload([:authors, :subjects, :languages])
      |> Repo.preload([book_formats: :format])

    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Books.get_book!(id)
    changeset = Books.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Books.get_book!(id)

    case Books.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: book_path(conn, :show, book))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Books.get_book!(id)
    {:ok, _book} = Books.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: book_path(conn, :index))
  end
end
