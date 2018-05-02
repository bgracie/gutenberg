defmodule GutenbergWeb.PageController do
  use GutenbergWeb, :controller

  import Ecto.Query, warn: false

  def index(conn, _params) do
    render(
      conn,
      "index.html"
    )
  end

  def search(conn, params) do
    term = params["search"]["term"]

    books = (from b in Gutenberg.Books.Book,
      where: ilike(b.title, ^"%#{term}%"))
      |> Gutenberg.Repo.all()
      |> Enum.map(&(%{
        label: &1.title,
        link: book_path(conn, :show, &1),
        type: "book"
      }))

    authors = (from a in Gutenberg.Books.Author,
      where: ilike(a.name, ^"%#{term}%"))
      |> Gutenberg.Repo.all()
      |> Enum.map(&(%{
        label: &1.name,
        link: author_path(conn, :show, &1),
        type: "author"
      }))

    subjects = (from s in Gutenberg.Books.Subject,
      where: ilike(s.name, ^"%#{term}%"))
      |> Gutenberg.Repo.all()
      |> Enum.map(&(%{
        label: &1.name,
        link: subject_path(conn, :show, &1),
        type: "subject"
      }))

    results = books
      |> Enum.concat(authors)
      |> Enum.concat(subjects)
      |> Enum.sort_by(&(&1.label))

    render(
      conn,
      "search.html",
      results: results
    )
  end
end
