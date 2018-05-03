defmodule Gutenberg.Repo.Migrations.AddLowercaseIndices do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION pg_trgm;"
    execute "CREATE INDEX books_title_tg_index ON books USING gin (title gin_trgm_ops);"
    execute "CREATE INDEX authors_name_tg_index ON authors USING gin (name gin_trgm_ops);"
    execute "CREATE INDEX subjects_name_tg_index ON subjects USING gin (name gin_trgm_ops);"
  end
end
