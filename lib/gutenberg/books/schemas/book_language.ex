defmodule Gutenberg.Books.Schemas.BookLanguage do
  use Ecto.Schema

  schema "book_languages" do
    belongs_to :book, Gutenberg.Books.Schemas.Book
    belongs_to :language, Gutenberg.Books.Schemas.Language

    timestamps(type: :utc_datetime)
  end
end