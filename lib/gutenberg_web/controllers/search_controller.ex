defmodule GutenbergWeb.SearchController do
  use GutenbergWeb, :controller

  import Ecto.Query, warn: false

  @results_per_page 8

  def search(conn, %{"search" => search_params}) do
    with collection = get_collection(search_params),
         term = search_params["term"],
         page = Ecto.Type.cast(:integer, search_params["page"] || 1) do
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

  defp get_collection(params) do
    case params["collection"] do
      param when param in ["books", "authors", "subjects"] -> param
      _ -> "books"
    end
  end

  def books(term, page) do
    Gutenberg.Db.Book
    |> Gutenberg.Db.Book.search(term)
    |> Gutenberg.Db.Book.order_by_title_length()
    |> Ecto.Query.preload(:authors)
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end

  def authors(term, page) do
    Gutenberg.Db.Author
    |> Gutenberg.Db.Author.search(term)
    |> Gutenberg.Db.Author.order_by_name_length()
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end

  def subjects(term, page) do
    Gutenberg.Db.Subject
    |> Gutenberg.Db.Subject.search(term)
    |> Gutenberg.Db.Subject.order_by_name_length()
    |> Gutenberg.Repo.paginate(page: page, page_size: @results_per_page)
  end
end
