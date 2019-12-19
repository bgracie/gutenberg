defmodule Gutenberg.ImportCatalog.WriteBookSubjectsToDb do
  use Gutenberg.Library
  alias Gutenberg.ImportCatalog

  def _(books_from_json, books_from_db, subjects_from_db) do
    books_from_json
    |> Enum.map(&build_book_subjects(&1, books_from_db, subjects_from_db))
    |> List.flatten()
    |> ImportCatalog.SharedFunctions.insert_all(Db.BookSubject)
  end

  defp build_book_subjects(book_from_json, books_from_db, subjects_from_db) do
    Enum.map(
      book_from_json["subjects"],
      &build_book_subject(&1, book_from_json, books_from_db, subjects_from_db)
    )
  end

  defp build_book_subject(subject, book_from_json, books_from_db, subjects_from_db) do
    Map.merge(
      %{
        book_id:
          ImportCatalog.SharedFunctions.find_book_by_title(books_from_db, book_from_json["title"]).id,
        subject_id: Enum.find(subjects_from_db, &(&1.name == subject)).id
      },
      Repo.now_timestamps()
    )
  end
end
