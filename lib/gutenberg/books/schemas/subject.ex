defmodule Gutenberg.Books.Schemas.Subject do
  use Ecto.Schema
  import Ecto.Changeset


  schema "subjects" do
    field :name, :string

    many_to_many :books,
      Gutenberg.Books.Schemas.Book,
      join_through: Gutenberg.Books.Schemas.BookSubject

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
