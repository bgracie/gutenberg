defmodule Gutenberg.Db.Book do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "books" do
    field :title, :string

    many_to_many :authors,
                 Gutenberg.Db.Author,
                 join_through: Gutenberg.Db.BookAuthor

    many_to_many :formats,
                 Gutenberg.Db.Format,
                 join_through: Gutenberg.Db.BookFormat

    has_many :book_formats,
             Gutenberg.Db.BookFormat

    many_to_many :languages,
                 Gutenberg.Db.Language,
                 join_through: Gutenberg.Db.BookLanguage

    many_to_many :subjects,
                 Gutenberg.Db.Subject,
                 join_through: Gutenberg.Db.BookSubject

    timestamps(type: :utc_datetime)
  end

  def author_name(%Gutenberg.Db.Book{authors: [first | _rest]}), do: first.name
  def author_name(%Gutenberg.Db.Book{authors: []}), do: ""

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
