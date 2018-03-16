# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gutenberg.Repo.insert!(%Gutenberg.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Gutenberg.{Repo, ImportBooks}
alias Gutenberg.{Authors, Books, Languages, Subjects, Formats}

books = ImportBooks.exec()

# Seed FORMATS

books
|> Enum.map(&Map.get(&1, "formats"))
|> Enum.map(&Map.keys/1)
|> List.flatten()
|> Enum.uniq()
|> Enum.each(fn (mime_type) ->
    Repo.insert!(%Formats.Format{mime_type: mime_type})
  end)

# Seed SUBJECTS

books
|> Enum.map(&Map.get(&1, "subjects"))
|> List.flatten()
|> Enum.uniq()
|> Enum.each(fn (name) ->
    Repo.insert!(%Subjects.Subject{name: name})
  end)

# Seed LANGUAGES

books
|> Enum.map(&Map.get(&1, "language"))
|> Enum.filter(&(!is_nil(&1)))
|> List.flatten()
|> Enum.uniq()
|> Enum.each(fn (code) ->
    Repo.insert!(%Languages.Language{code: code})
  end)

# Seed AUTHORS

books
|> Enum.map(&Map.get(&1, "author"))
|> Enum.filter(&(!is_nil(&1)))
|> Enum.uniq()
|> Enum.each(fn (name) ->
    Repo.insert!(%Authors.Author{name: name})
  end)

# all uniq

# create books...find by