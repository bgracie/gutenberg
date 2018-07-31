defmodule Gutenberg.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :string, null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:subjects, [:name])

  end
end
