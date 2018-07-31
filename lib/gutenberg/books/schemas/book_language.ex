defmodule Gutenberg.Books.BookLanguage do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "book_languages" do
    belongs_to :book, Gutenberg.Books.Book
    belongs_to :language, Gutenberg.Books.Language

    timestamps(type: :utc_datetime)
  end
end