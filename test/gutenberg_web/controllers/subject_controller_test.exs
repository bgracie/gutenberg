defmodule GutenbergWeb.SubjectControllerTest do
  use GutenbergWeb.ConnCase

  describe "index" do
    test "lists all subjects", %{conn: conn} do
      conn = get conn, subject_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Subjects"
    end
  end
end
