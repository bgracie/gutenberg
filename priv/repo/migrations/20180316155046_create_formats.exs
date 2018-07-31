defmodule Gutenberg.Repo.Migrations.CreateFormats do
  use Ecto.Migration

  def change do
    create table(:formats, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :mime_type, :string, null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:formats, [:mime_type])

  end
end
