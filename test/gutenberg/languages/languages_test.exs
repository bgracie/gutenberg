defmodule Gutenberg.LanguagesTest do
  use Gutenberg.DataCase

  alias Gutenberg.Languages

  describe "languages" do
    @valid_attrs %{code: "some code"}

    def language_fixture(attrs \\ %{}) do
      {:ok, language} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Languages.create_language()

      language
    end

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Languages.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Languages.get_language!(language.id) == language
    end
  end
end
