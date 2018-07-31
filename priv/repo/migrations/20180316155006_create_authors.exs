defmodule Gutenberg.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :string, null: false
      add :year_of_birth, :integer
      add :year_of_death, :integer

      timestamps(type: :timestamptz)
    end

    create unique_index(:authors, [:name])

  end
end
