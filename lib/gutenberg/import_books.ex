defmodule Gutenberg.ImportBooks do
  def exec do
    "priv/books.json"
    |> File.read!()
    |> Poison.decode!()
    |> Map.values()
  end

  @doc """
  ## Examples

      iex(9)> Gutenberg.ImportBooks.fields(Gutenberg.ImportBooks.exec())
      ["LCC", "author", "authoryearofbirth", "authoryearofdeath",
      "downloads", "formats", "id", "language", "subjects",
      "title", "type"]

  """
  def fields(books) do
    books
    |> Enum.map(&Map.keys/1)
    |> List.flatten()
    |> Enum.uniq
  end

  def subjects(books) do
    books
    |> Enum.map(&(Map.get(&1, "subjects", [])))
    |> List.flatten()
    |> Enum.uniq()
  end

  def authors(books) do
    books
    |> Enum.map(&(Map.get(&1, "author", [])))
    |> List.flatten()
    |> Enum.uniq()
  end

  def typeof(self) do
    cond do
      is_float(self)    -> "float"
      is_number(self)   -> "number"
      is_nil(self)      -> "nil"
      is_atom(self)     -> "atom"
      is_boolean(self)  -> "boolean"
      is_map(self)      -> "map"
      is_binary(self)   -> "binary"
      is_function(self) -> "function"
      is_list(self)     -> "list"
      is_tuple(self)    -> "tuple"
      true              -> "idunno"
    end
  end

  @doc """
  ## Examples

      iex(14)> Gutenberg.ImportBooks.fields_types(Gutenberg.ImportBooks.exec())
      %{
        "LCC" => ["list"],
        "author" => ["binary", "nil"],
        "authoryearofbirth" => ["number", "nil"],
        "authoryearofdeath" => ["number", "nil"],
        "downloads" => ["number", "nil"],
        "formats" => ["map"],
        "id" => ["number"],
        "language" => ["list", "nil"],
        "subjects" => ["list"],
        "title" => ["binary", "nil"],
        "type" => ["binary"]
      }

  """
  def fields_types(books) do
    fields(books)
    |> Map.new(&field_types(&1, books))
  end

  def field_types(field, books) do
    books
    |> Enum.map(&Map.get(&1, field))
    |> Enum.map(&typeof/1)
    |> Enum.uniq
    |> (fn(types) -> { field, types } end).()
  end
end