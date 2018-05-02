defmodule Gutenberg.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset


  schema "books" do
    field :title, :string

    many_to_many :authors,
      Gutenberg.Books.Author,
      join_through: Gutenberg.Books.BookAuthor

    many_to_many :formats,
      Gutenberg.Books.Format,
      join_through: Gutenberg.Books.BookFormat

    has_many :book_formats,
      Gutenberg.Books.BookFormat

    many_to_many :languages,
      Gutenberg.Books.Language,
      join_through: Gutenberg.Books.BookLanguage

    many_to_many :subjects,
      Gutenberg.Books.Subject,
      join_through: Gutenberg.Books.BookSubject

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
