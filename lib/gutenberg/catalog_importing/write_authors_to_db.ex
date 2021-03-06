defmodule Gutenberg.CatalogImporting.WriteAuthorsToDb do
  alias Gutenberg.CatalogImporting
  use Gutenberg.Library

  def _(books_from_json) do
    books_from_json
    |> Enum.map(&get_author/1)
    |> Enum.filter(&present?/1)
    |> Enum.map(&CatalogImporting.Helpers.reverse_author_name/1)
    |> Enum.uniq()
    |> Enum.map(&build_author/1)
    |> Pipe.to(&Repo.chunked_insert_all(Db.Author, &1))
  end

  defp get_author(book_from_json), do: Map.get(book_from_json, "author")

  defp present?(author), do: !is_nil(author)

  defp build_author(author_name) do
    Map.merge(%{name: author_name}, Repo.now_timestamps())
  end
end
