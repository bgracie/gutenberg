defmodule Gutenberg.Repo.Migrations.CreateFormats do
  use Ecto.Migration

  def change do
    create table(:formats) do
      add :mime_type, :string, null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:formats, [:mime_type])

  end
end
