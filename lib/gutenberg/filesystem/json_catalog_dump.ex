defmodule Gutenberg.FileSystem.JsonCatalogDump do
  @moduledoc """
  The JSON catalog dump is the JSON version of the XML Catalog Dump taken
  from the Project Gutenberg site.

  The XML version can be found here:
  https://www.gutenberg.org/wiki/Gutenberg:Feeds

  The JSON version was created using `bin/parse_xml_dumpfile.py`
  """

  @path "priv/books.json"

  def path, do: @path

  def read(path \\ @path) do
    path
    |> File.read!()
    |> Jason.decode!()
    |> Map.values()
  end

  def fields(dump) do
    dump
    |> Enum.map(&Map.keys/1)
    |> List.flatten()
    |> Enum.uniq()
  end

  def subjects(dump) do
    dump
    |> Enum.map(&Map.get(&1, "subjects", []))
    |> List.flatten()
    |> Enum.uniq()
  end

  def authors(dump) do
    dump
    |> Enum.map(&Map.get(&1, "author", []))
    |> List.flatten()
    |> Enum.uniq()
  end

  def fields_types(books) do
    books
    |> fields()
    |> Map.new(&{&1, field_types(&1, books)})
  end

  def field_types(field, books) do
    books
    |> Enum.map(&Map.get(&1, field))
    |> Enum.map(&typeof/1)
    |> Enum.uniq()
  end

  defp typeof(value) do
    cond do
      is_float(value) -> "float"
      is_number(value) -> "number"
      is_nil(value) -> "nil"
      is_atom(value) -> "atom"
      is_boolean(value) -> "boolean"
      is_map(value) -> "map"
      is_binary(value) -> "binary"
      is_function(value) -> "function"
      is_list(value) -> "list"
      is_tuple(value) -> "tuple"
      true -> "idunno"
    end
  end
end
