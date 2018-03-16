defmodule Gutenberg.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :code, :string

      timestamps()
    end

  end
end
