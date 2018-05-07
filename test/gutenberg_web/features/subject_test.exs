defmodule GutenbergWeb.SubjectTest do
  use Gutenberg.FeatureCase
  alias Wallaby.Query

  import Gutenberg.TestFactories

  setup [:create_book]

  test "can visit the page for a book", %{session: session, subject: subject} do
    session
    |> visit("/en/subjects/#{subject.id}")
    |> assert_has(Query.text("The life of bob jones"))
    |> assert_has(Query.text("A Book"))
    |> assert_has(Query.text("Bob Jones"))
  end
end