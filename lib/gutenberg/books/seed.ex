defmodule Gutenberg.Books.Seed do

  alias Gutenberg.Repo
  alias Gutenberg.Books

  def exec do
    imported_books = import_books()
    write_books(imported_books)
    stored_books_ = stored_books()
    write_formats(imported_books, stored_books_)
    write_subjects(imported_books, stored_books_)
    write_languages(imported_books, stored_books_)
    write_authors(imported_books, stored_books_)
  end

  defp import_books do
    Books.ImportFromJson.exec()
    |> Enum.filter(&(!is_nil(&1["title"]) && String.length(&1["title"]) < 200))
    |> Enum.filter(&(!is_nil(&1["author"])))
    |> Enum.uniq_by(&(&1["title"]))
  end

  defp write_books(imported_books) do
    imported_books
    |> Enum.map(&(Map.merge(%{title: &1["title"]}, Repo.now_timestamps())))
    |> (&(Repo.chunked_insert_all(Books.Schemas.Book, &1))).()
  end

  defp stored_books() do
    Books.list()
    |> Map.new(fn (book) -> { book.title, book.id } end)
  end

  defp write_formats(imported_books, stored_books) do
    imported_books
    |> Enum.map(&Map.get(&1, "formats"))
    |> Enum.map(&Map.keys/1)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(&(Map.merge(%{mime_type: &1}, Repo.now_timestamps())))
    |> (&(Repo.chunked_insert_all(Books.Schemas.Format, &1))).()

    stored_formats = Books.Formats.list()
      |> Map.new(fn (format) -> { format.mime_type, format.id } end)

    imported_books
      |> Enum.reduce([], fn (book, acc) ->
        book["formats"]
          |> Enum.map(fn ({mime_type, url}) ->
            Map.merge(%{
              book_id: stored_books[book["title"]],
              format_id: stored_formats[mime_type],
              url: url
            }, Repo.now_timestamps())
          end) |> Enum.concat(acc)
      end) |> (&(Repo.chunked_insert_all(Books.Schemas.BookFormat, &1))).()
  end

  defp write_subjects(imported_books, stored_books) do
    imported_books
    |> Enum.map(&Map.get(&1, "subjects"))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(&(Map.merge(%{name: &1}, Repo.now_timestamps())))
    |> (&(Repo.chunked_insert_all(Books.Schemas.Subject, &1))).()

    stored_subjects = Books.Subjects.list()
      |> Map.new(fn (subject) -> { subject.name, subject.id } end)

    imported_books
      |> Enum.reduce([], fn (book, acc) ->
        book["subjects"]
          |> Enum.map(&(
            Map.merge(%{
              book_id: stored_books[book["title"]],
              subject_id: stored_subjects[&1]
            }, Repo.now_timestamps())
          )) |> Enum.concat(acc)
      end) |> (&(Repo.chunked_insert_all(Books.Schemas.BookSubject, &1))).()
  end

  defp write_languages(imported_books, stored_books) do
    imported_books
    |> Enum.map(&Map.get(&1, "language"))
    |> Enum.filter(&(!is_nil(&1)))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(&(Map.merge(%{code: &1}, Repo.now_timestamps())))
    |> (&(Repo.chunked_insert_all(Books.Schemas.Language, &1))).()

    stored_languages = Books.Languages.list()
      |> Map.new(fn (language) -> { language.code, language.id } end)

    imported_books
      |> Enum.reduce([], fn (book, acc) ->
        book["language"]
          |> Enum.map(&(
            Map.merge(%{
              book_id: stored_books[book["title"]],
              language_id: stored_languages[&1]
            }, Repo.now_timestamps())
          )) |> Enum.concat(acc)
      end) |> (&(Repo.chunked_insert_all(Books.Schemas.BookLanguage, &1))).()
  end

  defp write_authors(imported_books, stored_books) do
    imported_books
    |> Enum.map(&Map.get(&1, "author"))
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.uniq()
    |> Enum.map(&(Map.merge(%{name: &1}, Repo.now_timestamps())))
    |> (&(Repo.chunked_insert_all(Books.Schemas.Author, &1))).()

    stored_authors = Books.Authors.list()
      |> Map.new(fn (author) -> { author.name, author.id } end)

    imported_books
      |> Enum.map(fn (book) ->
        Map.merge(%{
          book_id: stored_books[book["title"]],
          author_id: stored_authors[book["author"]]
        }, Repo.now_timestamps())
      end) |> (&(Repo.chunked_insert_all(Books.Schemas.BookAuthor, &1))).()
  end
end