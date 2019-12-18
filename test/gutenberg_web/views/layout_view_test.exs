defmodule GutenbergWeb.LayoutViewTest do
  use GutenbergWeb.ConnCase, async: true

  test "correctly changes request paths" do
    assert GutenbergWeb.LayoutView.with_new_locale(
             %{request_path: "/en/books"},
             "fr"
           ) == "/fr/books"

    assert GutenbergWeb.LayoutView.with_new_locale(
             %{request_path: "/en"},
             "fr"
           ) == "/fr"
  end
end
