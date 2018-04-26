defmodule Gutenberg.Authors.Author do
  use Ecto.Schema
  import Ecto.Changeset


  schema "authors" do
    field :name, :string
    field :year_of_birth, :integer
    field :year_of_death, :integer

    many_to_many :books,
      Gutenberg.Books.Book,
      join_through: Gutenberg.Books.BookAuthor

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :year_of_birth, :year_of_death])
    |> validate_required([:name, :year_of_birth, :year_of_death])
    |> unique_constraint(:name)
  end
end
