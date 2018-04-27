defmodule GutenbergWeb.SubjectController do
  use GutenbergWeb, :controller

  alias Gutenberg.Subjects
  alias Gutenberg.Subjects.Subject

  def index(conn, _params) do
    subjects = Subjects.list_subjects()
    render(conn, "index.html", subjects: subjects)
  end

  def show(conn, %{"id" => id}) do
    subject = Subjects.get_subject!(id)
      |> Gutenberg.Repo.preload([books: :authors])
    render(conn, "show.html", subject: subject)
  end
end
