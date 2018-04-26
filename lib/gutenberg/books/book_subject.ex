defmodule Gutenberg.Books.BookSubject do
  use Ecto.Schema
  import Ecto.Changeset


  schema "book_subjects" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :subject, Gutenberg.Subjects.Subject

    timestamps(type: :utc_datetime)
  end
end