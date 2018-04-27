defmodule GutenbergWeb.BookControllerTest do
  use GutenbergWeb.ConnCase

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get conn, book_path(conn, :index)
      assert html_response(conn, 200) =~ "Books"
    end
  end
end
