defmodule GutenbergWeb.AuthorTest do
  use Gutenberg.FeatureCase
  alias Wallaby.Query

  import Gutenberg.TestFactories

  setup [:create_book]

  test "can visit the page for a book", %{session: session, author: author} do
    session
    |> visit("/en/authors/#{author.id}")
    |> assert_has(Query.text("Bob Jones"))
    |> assert_has(Query.text("A Book"))
  end
end