defmodule Gutenberg.ImportCatalog.ReadBooksFromJson do
  use Gutenberg.Library

  def _(path) do
    path
    |> Gutenberg.ImportCatalog.ImportFromJson.exec()
    |> Enum.filter(&valid?/1)
  end

  defp valid?(book_from_json) do
    !is_nil(book_from_json["title"]) &&
      !is_nil(book_from_json["author"]) &&
      String.length(book_from_json["title"]) < 200
  end
end
