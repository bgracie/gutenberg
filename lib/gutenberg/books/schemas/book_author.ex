defmodule Gutenberg.Books.BookAuthor do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "book_authors" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :author, Gutenberg.Books.Author

    timestamps(type: :utc_datetime)
  end
end
