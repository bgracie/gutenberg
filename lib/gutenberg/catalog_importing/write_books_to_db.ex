defmodule Gutenberg.CatalogImporting.WriteBooksToDb do
  use Gutenberg.Library

  def _(books_from_json) do
    books_from_json
    |> Enum.uniq_by(& &1["title"])
    |> Enum.map(&build_book_record/1)
    |> Pipe.to(&Repo.chunked_insert_all(Db.Book, &1))
  end

  defp build_book_record(book_from_json) do
    Map.merge(%{title: book_from_json["title"]}, Repo.now_timestamps())
  end
end
