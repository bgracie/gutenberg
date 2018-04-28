defmodule Gutenberg.Books.Schemas.BookFormat do
  use Ecto.Schema

  schema "book_formats" do
    belongs_to :book, Gutenberg.Books.Schemas.Book
    belongs_to :format, Gutenberg.Books.Schemas.Format
    field :url, :string

    timestamps(type: :utc_datetime)
  end
end