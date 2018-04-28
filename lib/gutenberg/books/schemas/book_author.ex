defmodule Gutenberg.Books.Schemas.BookAuthor do
  use Ecto.Schema

  schema "book_authors" do
    belongs_to :book, Gutenberg.Books.Schemas.Book
    belongs_to :author, Gutenberg.Books.Schemas.Author

    timestamps(type: :utc_datetime)
  end
end
