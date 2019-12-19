defmodule Gutenberg.Books.Seed.ReadBooksFromJson do
  alias Gutenberg.Books

  def _(path) do
    path
    |> Books.ImportFromJson.exec()
    |> Enum.filter(&valid?/1)
  end

  defp valid?(book_from_json) do
    !is_nil(book_from_json["title"]) &&
      !is_nil(book_from_json["author"]) &&
      String.length(book_from_json["title"]) < 200
  end
end
