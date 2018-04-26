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
import Ecto.Query, warn: false

# Seed books

books = ImportBooks.exec()
  |> Enum.filter(&(!is_nil(&1["title"]) && String.length(&1["title"]) < 200))
  |> Enum.filter(&(!is_nil(&1["author"])))
  |> Enum.uniq_by(&(&1["title"]))

books
  |> Enum.map(&(Map.merge(%{title: &1["title"]}, Repo.now_timestamps())))
  |> (&(Repo.chunked_insert_all(Books.Book, &1))).()

stored_books = Books.list_books()
  |> Map.new(fn (book) -> { book.title, book.id } end)

# Seed FORMATS

books
|> Enum.map(&Map.get(&1, "formats"))
|> Enum.map(&Map.keys/1)
|> List.flatten()
|> Enum.uniq()
|> Enum.map(&(Map.merge(%{mime_type: &1}, Repo.now_timestamps())))
|> (&(Repo.chunked_insert_all(Formats.Format, &1))).()

stored_formats = Formats.list_formats()
  |> Map.new(fn (format) -> { format.mime_type, format.id } end)

books
  |> Enum.reduce([], fn (book, acc) ->
    book["formats"]
      |> Enum.map(fn ({mime_type, url}) ->
        Map.merge(%{
          book_id: stored_books[book["title"]],
          format_id: stored_formats[mime_type],
          url: url
        }, Repo.now_timestamps())
      end) |> Enum.concat(acc)
  end) |> (&(Repo.chunked_insert_all(Books.BookFormat, &1))).()

# Seed SUBJECTS

books
|> Enum.map(&Map.get(&1, "subjects"))
|> List.flatten()
|> Enum.uniq()
|> Enum.map(&(Map.merge(%{name: &1}, Repo.now_timestamps())))
|> (&(Repo.chunked_insert_all(Subjects.Subject, &1))).()

stored_subjects = Subjects.list_subjects()
  |> Map.new(fn (subject) -> { subject.name, subject.id } end)

books
  |> Enum.reduce([], fn (book, acc) ->
    book["subjects"]
      |> Enum.map(&(
        Map.merge(%{
          book_id: stored_books[book["title"]],
          subject_id: stored_subjects[&1]
        }, Repo.now_timestamps())
      )) |> Enum.concat(acc)
  end) |> (&(Repo.chunked_insert_all(Books.BookSubject, &1))).()

# Seed LANGUAGES

books
|> Enum.map(&Map.get(&1, "language"))
|> Enum.filter(&(!is_nil(&1)))
|> List.flatten()
|> Enum.uniq()
|> Enum.map(&(Map.merge(%{code: &1}, Repo.now_timestamps())))
|> (&(Repo.chunked_insert_all(Languages.Language, &1))).()

stored_languages = Languages.list_languages()
  |> Map.new(fn (language) -> { language.code, language.id } end)

books
  |> Enum.reduce([], fn (book, acc) ->
    book["language"]
      |> Enum.map(&(
        Map.merge(%{
          book_id: stored_books[book["title"]],
          language_id: stored_languages[&1]
        }, Repo.now_timestamps())
      )) |> Enum.concat(acc)
  end) |> (&(Repo.chunked_insert_all(Books.BookLanguage, &1))).()

# Seed AUTHORS

books
|> Enum.map(&Map.get(&1, "author"))
|> Enum.filter(&(!is_nil(&1)))
|> Enum.uniq()
|> Enum.map(&(Map.merge(%{name: &1}, Repo.now_timestamps())))
|> (&(Repo.chunked_insert_all(Authors.Author, &1))).()

stored_authors = Authors.list_authors()
  |> Map.new(fn (author) -> { author.name, author.id } end)

books
  |> Enum.map(fn (book) ->
    Map.merge(%{
      book_id: stored_books[book["title"]],
      author_id: stored_authors[book["author"]]
    }, Repo.now_timestamps())
  end) |> (&(Repo.chunked_insert_all(Books.BookAuthor, &1))).()