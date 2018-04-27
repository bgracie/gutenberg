defmodule Gutenberg.AuthorsTest do
  use Gutenberg.DataCase

  alias Gutenberg.Authors

  describe "authors" do
    @valid_attrs %{name: "some name", year_of_birth: 42, year_of_death: 42}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authors.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Authors.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Authors.get_author!(author.id) == author
    end
  end
end
