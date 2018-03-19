defmodule Gutenberg.Repo.Migrations.AddJoinTables do
  use Ecto.Migration

  def change do
    create table(:book_subjects) do
      add :book_id, references("books"), null: false
      add :subject_id, references("subjects"), null: false

      timestamps()
    end

    create unique_index(:book_subjects, [:book_id, :subject_id])

    create table(:book_authors) do
      add :book_id, references("books"), null: false
      add :author_id, references("authors"), null: false

      timestamps()
    end

    create unique_index(:book_authors, [:book_id, :author_id])

    create table(:book_languages) do
      add :book_id, references("books"), null: false
      add :language_id, references("languages"), null: false

      timestamps()
    end

    create unique_index(:book_languages, [:book_id, :language_id])

    create table(:book_formats) do
      add :book_id, references("books"), null: false
      add :format_id, references("formats"), null: false
      add :url, :string, null: false

      timestamps()
    end

    create unique_index(:book_formats, [:book_id, :format_id])
  end
end
