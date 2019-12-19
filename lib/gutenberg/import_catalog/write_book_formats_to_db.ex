defmodule Gutenberg.ImportCatalog.WriteBookFormatsToDb do
  use Gutenberg.Library
  alias Gutenberg.ImportCatalog.SharedFunctions

  def _(books_from_json, books_from_db, formats_from_db) do
    books_from_json
    |> Enum.map(&build_book_formats(&1, books_from_db, formats_from_db))
    |> List.flatten()
    |> SharedFunctions.insert_all(Db.BookFormat)
  end

  defp build_book_formats(book_from_json, books_from_db, formats_from_db) do
    Enum.map(
      book_from_json["formats"],
      &build_book_format(&1, book_from_json, books_from_db, formats_from_db)
    )
  end

  defp build_book_format({mime_type, url}, book_from_json, books_from_db, formats_from_db) do
    Map.merge(
      %{
        book_id: SharedFunctions.find_book_by_title(books_from_db, book_from_json["title"]).id,
        format_id: Enum.find(formats_from_db, &(&1.mime_type == mime_type)).id,
        url: url
      },
      Repo.now_timestamps()
    )
  end
end
