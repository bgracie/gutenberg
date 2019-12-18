defmodule Gutenberg.ListTest do
  use ExUnit.Case, async: true

  describe "Gutenberg.List.to_sentence/1" do
    test "no members" do
      assert Gutenberg.List.to_sentence([]) == ""
    end

    test "one member" do
      assert Gutenberg.List.to_sentence(["one"]) == "one"
    end

    test "two members" do
      assert Gutenberg.List.to_sentence(["one", "two"]) == "one and two"
    end

    test "three members" do
      assert Gutenberg.List.to_sentence(["one", "two", "three"]) == "one, two, and three"
    end

    test "four members" do
      assert Gutenberg.List.to_sentence(["one", "two", "three", "four"]) ==
               "one, two, three, and four"
    end

    test "five members" do
      assert Gutenberg.List.to_sentence(["one", "two", "three", "four", "five"]) ==
               "one, two, three, four, and five"
    end
  end
end
