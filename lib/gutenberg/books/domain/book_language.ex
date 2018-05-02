defmodule Gutenberg.Books.BookLanguage do
  use Ecto.Schema

  schema "book_languages" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :language, Gutenberg.Books.Language

    timestamps(type: :utc_datetime)
  end
end