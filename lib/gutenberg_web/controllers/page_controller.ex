defmodule GutenbergWeb.PageController do
  use GutenbergWeb, :controller

  import Ecto.Query, warn: false

  @results_per_page 8

  def index(conn, _params) do
    render(
      conn,
      "index.html"
    )
  end

  def search(conn, %{"search" => search_params })do
    with collection when collection in ["books", "authors", "subjects"]
      <- (search_params["collection"] || "books"),
      term = search_params["term"],
      page = (search_params["page"] || 1) |> Gutenberg.Utils.ensure_int()
    do
      page = apply(
        GutenbergWeb.PageController,
        String.to_atom(collection),
        [term, conn, page]
      )

      render(
        conn,
        "search.html",
        page: page,
        collection: collection,
        search_params: search_params
      )
    end
  end

  def books(term, conn, page) when is_binary(term) do
    Gutenberg.Books.Book
    |> Gutenberg.Books.Book.search(term)
    |> Ecto.Query.preload(:authors)
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end

  def authors(term, conn, page) when is_binary(term) do
    Gutenberg.Books.Author
    |> Gutenberg.Books.Author.search(term)
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end

  def subjects(term, conn) when is_binary(term) do
    (from s in Gutenberg.Books.Subject,
      where: ilike(s.name, ^"%#{term}%"))
      |> Gutenberg.Repo.all()
      |> Enum.map(&(%{
        label: &1.name,
        link: subject_path(conn, :show, &1, locale()),
        type: "subject"
      }))
  end
end
