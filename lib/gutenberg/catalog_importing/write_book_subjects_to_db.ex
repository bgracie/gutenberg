defmodule Gutenberg.CatalogImporting.WriteBookSubjectsToDb do
  use Gutenberg.Library
  alias Gutenberg.CatalogImporting

  def _(books_from_json, books_from_db, subjects_from_db) do
    books_from_json
    |> Enum.map(&build_book_subjects(&1, books_from_db, subjects_from_db))
    |> List.flatten()
    |> Pipe.to(&Repo.chunked_insert_all(Db.BookSubject, &1))
  end

  defp build_book_subjects(book_from_json, books_from_db, subjects_from_db) do
    Enum.map(
      book_from_json["subjects"],
      &build_book_subject(&1, book_from_json, books_from_db, subjects_from_db)
    )
  end

  defp build_book_subject(
         subject,
         book_from_json,
         books_from_db,
         subjects_from_db
       ) do
    book =
      CatalogImporting.Helpers.find_book_by_title(
        books_from_db,
        book_from_json["title"]
      )

    subject = Enum.find(subjects_from_db, &(&1.name == subject))

    Map.merge(
      %{book_id: book.id, subject_id: subject.id},
      Repo.now_timestamps()
    )
  end
end
