defmodule Gutenberg.Books.LanguagesTest do
  use Gutenberg.DataCase

  alias Gutenberg.Books.Languages

  describe "languages" do
    @valid_attrs %{code: "some code"}

    def language_fixture(attrs \\ %{}) do
      {:ok, language} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Languages.create()

      language
    end

    test "list/0 returns all languages" do
      language = language_fixture()
      assert Languages.list() == [language]
    end

    test "get!/1 returns the language with given id" do
      language = language_fixture()
      assert Languages.get!(language.id) == language
    end
  end
end
