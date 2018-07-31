defmodule Gutenberg.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

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

  def author_name(%Gutenberg.Books.Book{authors: [first | _rest]}), do: first.name
  def author_name(%Gutenberg.Books.Book{authors: []}), do: ""

  def search(query, term) when is_binary(term) do
    where(query, [b], ilike(b.title, ^"%#{term}%"))
  end

  def order_by_title_length(query) do
    order_by(query, [b], fragment("char_length(?)", b.title))
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
