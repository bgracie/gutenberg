defmodule Gutenberg.Books.BookFormat do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "book_formats" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :format, Gutenberg.Books.Format
    field :url, :string

    timestamps(type: :utc_datetime)
  end
end