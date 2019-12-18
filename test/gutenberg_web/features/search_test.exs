defmodule GutenbergWeb.SearchTest do
  use Gutenberg.FeatureCase
  alias Gutenberg.Repo
  alias Gutenberg.Books

  import Wallaby.Query, only: [css: 2, css: 1, text_field: 1, link: 1]

  setup do
    %{
      matching_book: Repo.insert!(%Books.Book{title: "Matching"}),
      matching_author: Repo.insert!(%Books.Author{name: "Matching"}),
      matching_subject: Repo.insert!(%Books.Subject{name: "Matching"})
    }
  end

  test "can search from the homepage", %{session: session} do
    session
    |> visit("/")
    |> find(css("#_front__search_form"), fn form ->
      fill_in(form, text_field("_front__search_term"), with: "Matching")
      |> find(css("#_front__search_term"))
      |> send_keys([:enter])
    end)
    |> assert_has(css("._result_card", text: "Matching"))
    |> click(link("Authors"))
    |> assert_has(css("._result_card", text: "Matching"))
    |> click(link("Subjects"))
    |> assert_has(css("._result_card", text: "Matching"))
  end

  test "can search from the navbar", %{session: session} do
    session
    |> visit("/")
    |> resize_window(1000, 1000)
    |> find(css("#_navbar__search_term"), fn input ->
      input
      |> send_keys(["Matching", :enter])
    end)
    |> assert_has(css("._result_card", text: "Matching"))
  end
end
