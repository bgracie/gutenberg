defmodule GutenbergWeb.HomepageTest do
  use Gutenberg.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "can visit the homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".front__banner", text: "Gutenberg"))
  end

  test "can change locale", %{session: session} do
    session
    |> visit("/")
    |> click(css(".locale_dropdown_link", text: "en"))
    |> click(css(".locale_link", text: "fr"))
    |> assert_has(css(".front__search_button", text: "Chercher"))
  end
end