defmodule Gutenberg.ImportCatalog.WriteBookAuthorsToDb do
  use Gutenberg.Library
  alias Gutenberg.ImportCatalog

  def _(books_from_json, books_from_db, authors_from_db) do
    books_from_json
    |> Enum.map(&build_book_author(&1, books_from_db, authors_from_db))
    |> ImportCatalog.SharedFunctions.insert_all(Db.BookAuthor)
  end

  defp build_book_author(book_from_json, books_from_db, authors_from_db) do
    Map.merge(
      %{
        book_id:
          ImportCatalog.SharedFunctions.find_book_by_title(books_from_db, book_from_json["title"]).id,
        author_id:
          Enum.find(
            authors_from_db,
            &(&1.name ==
                ImportCatalog.SharedFunctions.reverse_author_name(book_from_json["author"]))
          ).id
      },
      Repo.now_timestamps()
    )
  end
end
