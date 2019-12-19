defmodule Gutenberg.Books.Seed do
  @moduledoc """
  Seeds books from JSON dump of entire Gutenberg catalog.

  Join records are inserted separately from their associations so that we can use
  bulk inserts.
  """

  alias Gutenberg.Repo
  alias Gutenberg.Books

  alias Gutenberg.Books.Seed.{
    ReadBooksFromJson,
    WriteBooksToDb,
    WriteFormatsToDb,
    WriteBookFormatsToDb,
    WriteSubjectsToDb,
    WriteBookSubjectsToDb,
    WriteLanguagesToDb,
    WriteBookLanguagesToDb,
    WriteAuthorsToDb,
    WriteBookAuthorsToDb
  }

  @books_json_path "priv/books.json"

  def exec(path \\ @books_json_path) do
    books_from_json = ReadBooksFromJson._(path)

    WriteBooksToDb._(books_from_json)
    books_from_db = Books.list()

    WriteFormatsToDb._(books_from_json)
    formats_from_db = Books.Formats.list()
    WriteBookFormatsToDb._(books_from_json, books_from_db, formats_from_db)

    WriteSubjectsToDb._(books_from_json)
    subjects_from_db = Books.Subjects.list()
    WriteBookSubjectsToDb._(books_from_json, books_from_db, subjects_from_db)

    WriteLanguagesToDb._(books_from_json)
    languages_from_db = Books.Languages.list()
    WriteBookLanguagesToDb._(books_from_json, books_from_db, languages_from_db)

    WriteAuthorsToDb._(books_from_json)
    authors_from_db = Books.Authors.list()
    WriteBookAuthorsToDb._(books_from_json, books_from_db, authors_from_db)
  end
end
