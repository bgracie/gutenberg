defmodule Gutenberg.Books.BookFormat do
  use Ecto.Schema

  schema "book_formats" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :format, Gutenberg.Books.Format
    field :url, :string

    timestamps(type: :utc_datetime)
  end
end