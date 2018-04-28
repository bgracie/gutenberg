defmodule Gutenberg.Books.FormatsTest do
  use Gutenberg.DataCase

  alias Gutenberg.Books.Formats

  describe "formats" do
    @valid_attrs %{mime_type: "some mime_type"}

    def format_fixture(attrs \\ %{}) do
      {:ok, format} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Formats.create()

      format
    end

    test "list/0 returns all formats" do
      format = format_fixture()
      assert Formats.list() == [format]
    end

    test "get!/1 returns the format with given id" do
      format = format_fixture()
      assert Formats.get!(format.id) == format
    end
  end
end
