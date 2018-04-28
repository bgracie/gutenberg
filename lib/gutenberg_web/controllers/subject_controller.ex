defmodule GutenbergWeb.SubjectController do
  use GutenbergWeb, :controller

  alias Gutenberg.Books.Subjects

  def index(conn, _params) do
    subjects = Subjects.list()
    render(conn, "index.html", subjects: subjects)
  end

  def show(conn, %{"id" => id}) do
    subject = Subjects.get!(id)
      |> Gutenberg.Repo.preload([books: :authors])
    render(conn, "show.html", subject: subject)
  end
end
