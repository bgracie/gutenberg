defmodule Gutenberg.Db.Subject do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "subjects" do
    field :name, :string

    many_to_many :books,
                 Gutenberg.Db.Book,
                 join_through: Gutenberg.Db.BookSubject

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def search(query, term) when is_binary(term) do
    where(query, [b], ilike(b.name, ^"%#{term}%"))
  end

  def order_by_name_length(query) do
    order_by(query, [s], fragment("char_length(?)", s.name))
  end
end
