defmodule Gutenberg.Repo.Migrations.CreateFormats do
  use Ecto.Migration

  def change do
    create table(:formats) do
      add :mime_type, :string

      timestamps()
    end

  end
end
