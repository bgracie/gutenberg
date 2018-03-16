defmodule Gutenberg.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string, null: false, size: 500

      timestamps()
    end

    create unique_index(:books, [:title])
  end
end
