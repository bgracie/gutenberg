defmodule Gutenberg.Books.BookSubject do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "book_subjects" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :subject, Gutenberg.Books.Subject

    timestamps(type: :utc_datetime)
  end
end
