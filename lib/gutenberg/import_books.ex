defmodule Gutenberg.ImportBooks do
  def exec do
    "priv/books.json"
    |> File.read!()
    |> Poison.decode!()
  end

  @doc """
  ## Examples

      iex(9)> Gutenberg.ImportBooks.fields
      ["LCC", "author", "authoryearofbirth", "authoryearofdeath",
      "downloads", "formats", "id", "language", "subjects",
      "title", "type"]

  """
  def fields do
    exec()
    |> Map.values()
    |> Enum.map(&Map.keys/1)
    |> List.flatten()
    |> Enum.uniq
  end
end