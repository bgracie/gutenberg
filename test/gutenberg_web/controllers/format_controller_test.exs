defmodule GutenbergWeb.FormatControllerTest do
  use GutenbergWeb.ConnCase

  describe "index" do
    test "lists all formats", %{conn: conn} do
      conn = get conn, format_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Formats"
    end
  end
end
