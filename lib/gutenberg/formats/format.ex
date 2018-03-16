defmodule Gutenberg.Formats.Format do
  use Ecto.Schema
  import Ecto.Changeset


  schema "formats" do
    field :mime_type, :string

    timestamps()
  end

  @doc false
  def changeset(format, attrs) do
    format
    |> cast(attrs, [:mime_type])
    |> validate_required([:mime_type])
    |> unique_constraint(:mime_type)
  end
end
