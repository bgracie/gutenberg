defmodule Gutenberg.Db.BookAuthor do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "book_authors" do
    belongs_to :book, Gutenberg.Db.Book
    belongs_to :author, Gutenberg.Db.Author

    timestamps(type: :utc_datetime)
  end
end
