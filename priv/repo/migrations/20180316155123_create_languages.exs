defmodule Gutenberg.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :code, :string, null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:languages, [:code])

  end
end
