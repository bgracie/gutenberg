defmodule Gutenberg.Books.Schemas.BookSubject do
  use Ecto.Schema

  schema "book_subjects" do
    belongs_to :book, Gutenberg.Books.Schemas.Book
    belongs_to :subject, Gutenberg.Books.Schemas.Subject

    timestamps(type: :utc_datetime)
  end
end