defmodule GutenbergWeb.HomepageTest do
  use Gutenberg.FeatureCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "can visit the homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css(".front__banner", text: "Gutenberg"))
  end
end