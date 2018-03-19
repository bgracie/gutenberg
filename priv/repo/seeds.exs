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
alias Ecto.Changeset
import Ecto.Query, warn: false

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

# Seed BOOKS

books
|> Enum.filter(&(!is_nil(&1["title"]) && String.length(&1["title"]) < 200))
|> Enum.uniq_by(&(&1["title"]))
|> Enum.take(2000)
|> Enum.each(fn(book) ->
    subjects = Repo.all(
      from subjects in Subjects.Subject,
      where: subjects.name in ^book["subjects"]
    )

    languages = Repo.all(
      from languages in Languages.Language,
      where: languages.code in ^(book["language"] || [])
    )

    authors = case book["author"] do
      nil -> []
      _ -> Repo.all(
        from authors in Authors.Author,
        where: authors.name == ^book["author"]
      )
    end



    db_book = %Books.Book{title: book["title"]}
    |> Repo.insert!

    db_book
    |> Repo.preload([:formats, :subjects, :languages, :authors])
    |> Ecto.Changeset.change()
    |> Changeset.put_assoc(:subjects, subjects)
    |> Changeset.put_assoc(:languages, languages)
    |> Changeset.put_assoc(:authors, authors)
    |> Repo.update!()


    Repo.all(
      from formats in Formats.Format,
      where: formats.mime_type in ^Map.keys(book["formats"])
    ) |> Enum.each(fn (format) ->
      %Books.BookFormat{
        book_id: db_book.id,
        format_id: format.id,
        url: book["formats"][format.mime_type]
      } |> Repo.insert!
    end)
  end)