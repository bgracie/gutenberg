defmodule Gutenberg.Repo.Migrations.AddJoinTables do
  use Ecto.Migration

  def change do
    create table(:book_subjects, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :book_id, references("books", type: :uuid), null: false
      add :subject_id, references("subjects", type: :uuid), null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:book_subjects, [:book_id, :subject_id])

    create table(:book_authors, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :book_id, references("books", type: :uuid), null: false
      add :author_id, references("authors", type: :uuid), null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:book_authors, [:book_id, :author_id])

    create table(:book_languages, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :book_id, references("books", type: :uuid), null: false
      add :language_id, references("languages", type: :uuid), null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:book_languages, [:book_id, :language_id])

    create table(:book_formats, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :book_id, references("books", type: :uuid), null: false
      add :format_id, references("formats", type: :uuid), null: false
      add :url, :string, null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:book_formats, [:book_id, :format_id])
  end
end
