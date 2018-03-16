defmodule Gutenberg.Books.BookAuthor do
  use Ecto.Schema
  import Ecto.Changeset


  schema "book_authors" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :author, Gutenberg.Authors.Author

    timestamps()
  end
end
