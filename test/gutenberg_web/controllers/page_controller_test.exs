defmodule GutenbergWeb.PageControllerTest do
  use GutenbergWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Gutenberg"
  end
end
