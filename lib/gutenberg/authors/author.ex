defmodule Gutenberg.Authors.Author do
  use Ecto.Schema
  import Ecto.Changeset


  schema "authors" do
    field :name, :string
    field :year_of_birth, :integer
    field :year_of_death, :integer

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :year_of_birth, :year_of_death])
    |> validate_required([:name, :year_of_birth, :year_of_death])
    |> unique_constraint(:name)
  end
end
