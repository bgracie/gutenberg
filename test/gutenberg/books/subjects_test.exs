defmodule Gutenberg.Books.SubjectsTest do
  use Gutenberg.DataCase

  alias Gutenberg.Books.Subjects

  describe "subjects" do
    @valid_attrs %{name: "some name"}

    def subject_fixture(attrs \\ %{}) do
      {:ok, subject} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Subjects.create()

      subject
    end

    test "list/0 returns all subjects" do
      subject = subject_fixture()
      assert Subjects.list() == [subject]
    end

    test "get!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert Subjects.get!(subject.id) == subject
    end
  end
end
