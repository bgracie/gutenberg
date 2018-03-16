defmodule Gutenberg.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset


  schema "books" do
    field :title, :string

    many_to_many :authors,
      Gutenberg.Authors.Author,
      join_through: Gutenberg.Books.BookAuthor,
      on_delete: :delete_all

    many_to_many :formats,
      Gutenberg.Formats.Format,
      join_through: Gutenberg.Books.BookFormat,
      on_delete: :delete_all

    many_to_many :languages,
      Gutenberg.Languages.Language,
      join_through: Gutenberg.Books.BookLanguage,
      on_delete: :delete_all

    many_to_many :subjects,
      Gutenberg.Subjects.Subject,
      join_through: Gutenberg.Books.BookSubject,
      on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
