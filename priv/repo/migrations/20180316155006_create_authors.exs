defmodule Gutenberg.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :year_of_birth, :integer
      add :year_of_death, :integer

      timestamps()
    end

  end
end
