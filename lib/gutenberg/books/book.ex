defmodule Gutenberg.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset


  schema "books" do
    field :title, :string

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
