defmodule GutenbergWeb.SubjectController do
  use GutenbergWeb, :controller

  use Gutenberg.Library

  def show(conn, %{"id" => id}) do
    subject = Db.Subject |> Repo.get!(id) |> Repo.preload(books: :authors)

    render(conn, "show.html", subject: subject)
  end
end
