defmodule Gutenberg.Books.BookSubject do
  use Ecto.Schema

  schema "book_subjects" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :subject, Gutenberg.Books.Subject

    timestamps(type: :utc_datetime)
  end
end