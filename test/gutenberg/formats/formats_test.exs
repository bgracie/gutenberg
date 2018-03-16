defmodule Gutenberg.FormatsTest do
  use Gutenberg.DataCase

  alias Gutenberg.Formats

  describe "formats" do
    alias Gutenberg.Formats.Format

    @valid_attrs %{mime_type: "some mime_type"}
    @update_attrs %{mime_type: "some updated mime_type"}
    @invalid_attrs %{mime_type: nil}

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

    test "create_format/1 with valid data creates a format" do
      assert {:ok, %Format{} = format} = Formats.create_format(@valid_attrs)
      assert format.mime_type == "some mime_type"
    end

    test "create_format/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Formats.create_format(@invalid_attrs)
    end

    test "update_format/2 with valid data updates the format" do
      format = format_fixture()
      assert {:ok, format} = Formats.update_format(format, @update_attrs)
      assert %Format{} = format
      assert format.mime_type == "some updated mime_type"
    end

    test "update_format/2 with invalid data returns error changeset" do
      format = format_fixture()
      assert {:error, %Ecto.Changeset{}} = Formats.update_format(format, @invalid_attrs)
      assert format == Formats.get_format!(format.id)
    end

    test "delete_format/1 deletes the format" do
      format = format_fixture()
      assert {:ok, %Format{}} = Formats.delete_format(format)
      assert_raise Ecto.NoResultsError, fn -> Formats.get_format!(format.id) end
    end

    test "change_format/1 returns a format changeset" do
      format = format_fixture()
      assert %Ecto.Changeset{} = Formats.change_format(format)
    end
  end
end
