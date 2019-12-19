defmodule Gutenberg.Books.Seed.SharedFunctions do
  def find_book_by_title(books_from_db, title) do
    Enum.find(books_from_db, &(&1.title == title))
  end

  def insert_all(records, schema) do
    Gutenberg.Repo.chunked_insert_all(schema, records)
  end

  def reverse_author_name(name) do
    name
    |> String.split(", ")
    |> Enum.reverse()
    |> Enum.join(" ")
  end
end
