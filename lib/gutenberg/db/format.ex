defmodule Gutenberg.Db.Format do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Phoenix.Param, key: :id}

  schema "formats" do
    field :mime_type, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(format, attrs) do
    format
    |> cast(attrs, [:mime_type])
    |> validate_required([:mime_type])
    |> unique_constraint(:mime_type)
  end
end
