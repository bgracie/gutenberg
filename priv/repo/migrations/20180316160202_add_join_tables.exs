defmodule Gutenberg.Repo.Migrations.AddJoinTables do
  use Ecto.Migration

  def change do
    create table(:book_subjects) do
      add :book_id, references("books")
      add :subject_id, references("authors")

      timestamps()
    end

    create table(:book_authors) do
      add :book_id, references("books")
      add :author_id, references("authors")

      timestamps()
    end

    create table(:book_languages) do
      add :book_id, references("books")
      add :language_id, references("languages")

      timestamps()
    end

    create table(:book_formats) do
      add :book_id, references("books")
      add :format_id, references("formats")
      add :url, :string

      timestamps()
    end
  end
end
