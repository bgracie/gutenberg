defmodule Gutenberg.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\" WITH SCHEMA public;"

    create table(:books, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :title, :string, null: false, size: 500

      timestamps(type: :timestamptz)
    end

    create unique_index(:books, [:title])
  end
end
