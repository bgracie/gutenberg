defmodule GutenbergWeb.HomepageTest do
  use Gutenberg.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "can visit the homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("#_front__banner", text: "Gutenberg"))
    |> assert_has(css("._footer__link", text: "Volunteer"))
  end

  test "can change locale", %{session: session} do
    session
    |> visit("/")
    |> click(css("._locale_dropdown__toggle", text: "en"))
    |> click(css("._locale_dropdown__link", text: "fr"))
    |> assert_has(css("._footer__link", text: "Termes et conditions"))
  end
end