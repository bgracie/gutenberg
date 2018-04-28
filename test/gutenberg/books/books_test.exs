defmodule Gutenberg.Books.BooksTest do
  use Gutenberg.DataCase

  alias Gutenberg.Books

  describe "books" do
    @valid_attrs %{title: "some title"}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Books.create()

      book
    end

    test "list/0 returns all books" do
      book = book_fixture()
      assert Books.list() == [book]
    end

    test "get!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get!(book.id) == book
    end
  end
end
