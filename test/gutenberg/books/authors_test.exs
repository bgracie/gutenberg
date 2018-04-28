defmodule Gutenberg.Books.AuthorsTest do
  use Gutenberg.DataCase

  describe "authors" do
    @valid_attrs %{name: "some name", year_of_birth: 42, year_of_death: 42}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Gutenberg.Books.Authors.create()

      author
    end

    test "list/0 returns all authors" do
      author = author_fixture()
      assert Gutenberg.Books.Authors.list() == [author]
    end

    test "get!/1 returns the author with given id" do
      author = author_fixture()
      assert Gutenberg.Books.Authors.get!(author.id) == author
    end
  end
end
