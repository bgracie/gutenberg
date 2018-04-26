defmodule Gutenberg.Books.BookLanguage do
  use Ecto.Schema
  import Ecto.Changeset


  schema "book_languages" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :language, Gutenberg.Languages.Language

    timestamps(type: :utc_datetime)
  end
end