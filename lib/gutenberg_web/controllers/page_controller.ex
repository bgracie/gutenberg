defmodule GutenbergWeb.PageController do
  use GutenbergWeb, :controller

  import Ecto.Query, warn: false

  @results_per_page 10

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
      results = apply(
        GutenbergWeb.PageController,
        String.to_atom(collection),
        [term, conn, page]
      )

      render(
        conn,
        "search.html",
        results: results,
        collection: collection
      )
    end
  end

  def books(term, conn, page) when is_binary(term) do
    Gutenberg.Books.Book
    |> Gutenberg.Books.Book.search(term)
    |> Ecto.Query.preload(:authors)
    |> Gutenberg.Repo.all()
  end

  def authors(term, conn) when is_binary(term) do
    (from a in Gutenberg.Books.Author,
      where: ilike(a.name, ^"%#{term}%"))
      |> Gutenberg.Repo.all()
      |> Enum.map(&(%{
        label: &1.name,
        link: author_path(conn, :show, &1, locale()),
        type: "author"
      }))
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
