defmodule GutenbergWeb.LanguageControllerTest do
  use GutenbergWeb.ConnCase

  describe "index" do
    test "lists all languages", %{conn: conn} do
      conn = get conn, language_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Languages"
    end
  end
end
