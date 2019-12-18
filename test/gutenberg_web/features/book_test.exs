defmodule GutenbergWeb.BookTest do
  use Gutenberg.FeatureCase
  alias Wallaby.Query

  import Gutenberg.TestFactories

  setup [:create_book]

  test "can visit the page for a book", %{session: session, book: book} do
    session
    |> visit("/en/books/#{book.id}")
    |> assert_has(Query.text("A Book"))
    |> assert_has(Query.text("Bob Jones"))
    |> assert_has(Query.text("The life of bob jones"))
  end
end
