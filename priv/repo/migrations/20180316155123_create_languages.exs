defmodule Gutenberg.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :code, :string, null: false

      timestamps()
    end

    create unique_index(:languages, [:code])

  end
end
