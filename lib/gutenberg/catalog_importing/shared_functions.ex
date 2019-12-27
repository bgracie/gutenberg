defmodule Gutenberg.CatalogImporting.Helpers do
  use Gutenberg.Library

  def find_book_by_title(books_from_db, title) do
    Enum.find(books_from_db, &(&1.title == title))
  end

  def reverse_author_name(name) do
    name
    |> String.split(", ")
    |> Enum.reverse()
    |> Enum.join(" ")
  end
end
