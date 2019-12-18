defmodule GutenbergWeb.SearchController do
  use GutenbergWeb, :controller

  import Ecto.Query, warn: false

  @results_per_page 8

  def search(conn, %{"search" => search_params}) do
    with collection when collection in ["books", "authors", "subjects"] <-
           search_params["collection"] || "books",
         term = search_params["term"],
         page = (search_params["page"] || 1) |> Gutenberg.Utils.ensure_int() do
      page =
        apply(
          GutenbergWeb.SearchController,
          String.to_atom(collection),
          [term, page]
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

  def books(term, page) when is_binary(term) do
    Gutenberg.Books.Book
    |> Gutenberg.Books.Book.search(term)
    |> Gutenberg.Books.Book.order_by_title_length()
    |> Ecto.Query.preload(:authors)
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end

  def authors(term, page) when is_binary(term) do
    Gutenberg.Books.Author
    |> Gutenberg.Books.Author.search(term)
    |> Gutenberg.Books.Author.order_by_name_length()
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end

  def subjects(term, page) when is_binary(term) do
    Gutenberg.Books.Subject
    |> Gutenberg.Books.Subject.search(term)
    |> Gutenberg.Books.Subject.order_by_name_length()
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end
end
