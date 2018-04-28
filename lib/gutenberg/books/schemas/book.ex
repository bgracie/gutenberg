defmodule Gutenberg.Books.Schemas.Book do
  use Ecto.Schema
  import Ecto.Changeset


  schema "books" do
    field :title, :string

    many_to_many :authors,
      Gutenberg.Books.Schemas.Author,
      join_through: Gutenberg.Books.Schemas.BookAuthor

    many_to_many :formats,
      Gutenberg.Books.Schemas.Format,
      join_through: Gutenberg.Books.Schemas.BookFormat

    has_many :book_formats,
      Gutenberg.Books.Schemas.BookFormat

    many_to_many :languages,
      Gutenberg.Books.Schemas.Language,
      join_through: Gutenberg.Books.Schemas.BookLanguage

    many_to_many :subjects,
      Gutenberg.Books.Schemas.Subject,
      join_through: Gutenberg.Books.Schemas.BookSubject

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
