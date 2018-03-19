defmodule Gutenberg.Books.BookFormat do
  use Ecto.Schema
  import Ecto.Changeset


  schema "book_formats" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :format, Gutenberg.Formats.Format
    field :url, :string

    timestamps()
  end
end