defmodule Gutenberg.Books.Language do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "languages" do
    field :code, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:code])
    |> validate_required([:code])
    |> unique_constraint(:code)
  end
end
