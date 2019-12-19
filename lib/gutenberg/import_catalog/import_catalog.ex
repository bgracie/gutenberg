defmodule Gutenberg.ImportCatalog do
  @moduledoc """
  Seeds books from JSON dump of entire Gutenberg catalog.

  Join records are inserted separately from their associations so that we can use
  bulk inserts.
  """

  use Gutenberg.Library

  alias Gutenberg.ImportCatalog.{
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

  @books_json_path Gutenberg.FileSystem.JsonCatalogDump.path()

  def _(path \\ @books_json_path) do
    books_from_json = ReadBooksFromJson._(path)

    WriteBooksToDb._(books_from_json)
    books_from_db = Repo.all(Db.Book)

    WriteFormatsToDb._(books_from_json)
    formats_from_db = Repo.all(Db.Format)
    WriteBookFormatsToDb._(books_from_json, books_from_db, formats_from_db)

    WriteSubjectsToDb._(books_from_json)
    subjects_from_db = Repo.all(Db.Subject)
    WriteBookSubjectsToDb._(books_from_json, books_from_db, subjects_from_db)

    WriteLanguagesToDb._(books_from_json)
    languages_from_db = Repo.all(Db.Language)
    WriteBookLanguagesToDb._(books_from_json, books_from_db, languages_from_db)

    WriteAuthorsToDb._(books_from_json)
    authors_from_db = Repo.all(Db.Author)
    WriteBookAuthorsToDb._(books_from_json, books_from_db, authors_from_db)
  end
end
