defmodule GutenbergWeb.AuthorControllerTest do
  use GutenbergWeb.ConnCase

  describe "index" do
    test "lists all authors", %{conn: conn} do
      conn = get conn, author_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Authors"
    end
  end
end
