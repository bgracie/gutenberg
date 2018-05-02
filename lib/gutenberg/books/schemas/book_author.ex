defmodule Gutenberg.Books.BookAuthor do
  use Ecto.Schema

  schema "book_authors" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :author, Gutenberg.Books.Author

    timestamps(type: :utc_datetime)
  end
end
