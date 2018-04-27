defmodule Gutenberg.FormatsTest do
  use Gutenberg.DataCase

  alias Gutenberg.Formats

  describe "formats" do
    @valid_attrs %{mime_type: "some mime_type"}

    def format_fixture(attrs \\ %{}) do
      {:ok, format} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Formats.create_format()

      format
    end

    test "list_formats/0 returns all formats" do
      format = format_fixture()
      assert Formats.list_formats() == [format]
    end

    test "get_format!/1 returns the format with given id" do
      format = format_fixture()
      assert Formats.get_format!(format.id) == format
    end
  end
end
