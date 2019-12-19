defmodule Gutenberg.ImportCatalog.WriteBookLanguagesToDb do
  use Gutenberg.Library

  alias Gutenberg.ImportCatalog

  def _(books_from_json, books_from_db, languages_from_db) do
    books_from_json
    |> Enum.map(&build_book_languages(&1, books_from_db, languages_from_db))
    |> List.flatten()
    |> Pipe.to(&Repo.chunked_insert_all(Db.BookLanguage, &1))
  end

  defp build_book_languages(book_from_json, books_from_db, languages_from_db) do
    book_from_json
    |> Map.fetch!("language")
    |> Enum.map(&build_book_language(&1, book_from_json, books_from_db, languages_from_db))
  end

  defp build_book_language(language_code, book_from_json, books_from_db, languages_from_db) do
    book = ImportCatalog.Helpers.find_book_by_title(books_from_db, book_from_json["title"])
    language = Enum.find(languages_from_db, &(&1.code == language_code))

    Map.merge(%{book_id: book.id, language_id: language.id}, Repo.now_timestamps())
  end
end
