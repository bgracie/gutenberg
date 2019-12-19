defmodule Gutenberg.Books.Seed.WriteAuthorsToDb do
  alias Gutenberg.Books
  alias Gutenberg.Repo

  def _(books_from_json) do
    books_from_json
    |> Enum.map(&get_author/1)
    |> Enum.filter(&present?/1)
    |> Enum.map(&Books.Seed.SharedFunctions.reverse_author_name/1)
    |> Enum.uniq()
    |> Enum.map(&build_author/1)
    |> Books.Seed.SharedFunctions.insert_all(Books.Author)
  end

  defp get_author(book_from_json), do: Map.get(book_from_json, "author")

  defp present?(author), do: !is_nil(author)

  defp build_author(author_name) do
    Map.merge(%{name: author_name}, Repo.now_timestamps())
  end
end
