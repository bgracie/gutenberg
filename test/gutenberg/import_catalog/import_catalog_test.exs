defmodule Gutenberg.ImportCatalogTest do
  use Gutenberg.DataCase

  alias Gutenberg.Repo

  describe "_/1" do
    test "seeds books, authors, formats, languages, and subjects from Gutenberg json file" do
      fixture_path = Path.join([fixtures_path(), "books.json"])

      Gutenberg.ImportCatalog._(fixture_path)

      saved_book =
        Gutenberg.Db.Book
        |> Repo.one!()
        |> Repo.preload([:authors, :formats, :languages, :subjects])

      assert saved_book.title == "The Declaration of Independence of the United States of America"

      assert Enum.find(saved_book.subjects, fn subject ->
               subject.name == "United States. Declaration of Independence"
             end)

      assert Enum.find(saved_book.subjects, fn subject ->
               subject.name == "United States -- History -- Revolution, 1775-1783 -- Sources"
             end)

      assert Enum.at(saved_book.authors, 0).name == "Thomas Jefferson"

      assert Enum.at(saved_book.languages, 0).code == "en"

      assert Enum.find(saved_book.formats, fn format ->
               format.mime_type == "text/html"
             end)

      assert Enum.find(saved_book.formats, fn format ->
               format.mime_type == "application/epub+zip"
             end)
    end
  end
end
