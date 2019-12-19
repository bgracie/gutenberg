defmodule Gutenberg.ImportCatalog.WriteBookAuthorsToDb do
  use Gutenberg.Library
  alias Gutenberg.ImportCatalog

  def _(books_from_json, books_from_db, authors_from_db) do
    books_from_json
    |> Enum.map(&build_book_author(&1, books_from_db, authors_from_db))
    |> Pipe.to(&Repo.chunked_insert_all(Db.BookAuthor, &1))
  end

  defp build_book_author(book_from_json, books_from_db, authors_from_db) do
    book = ImportCatalog.Helpers.find_book_by_title(books_from_db, book_from_json["title"])
    saved_author_name = ImportCatalog.Helpers.reverse_author_name(book_from_json["author"])
    author = Enum.find(authors_from_db, &(&1.name == saved_author_name))

    Map.merge(%{book_id: book.id, author_id: author.id}, Repo.now_timestamps())
  end
end
