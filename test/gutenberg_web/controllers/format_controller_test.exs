defmodule GutenbergWeb.FormatControllerTest do
  use GutenbergWeb.ConnCase

  alias Gutenberg.Formats

  @create_attrs %{mime_type: "some mime_type"}
  @update_attrs %{mime_type: "some updated mime_type"}
  @invalid_attrs %{mime_type: nil}

  def fixture(:format) do
    {:ok, format} = Formats.create_format(@create_attrs)
    format
  end

  describe "index" do
    test "lists all formats", %{conn: conn} do
      conn = get conn, format_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Formats"
    end
  end

  describe "new format" do
    test "renders form", %{conn: conn} do
      conn = get conn, format_path(conn, :new)
      assert html_response(conn, 200) =~ "New Format"
    end
  end

  describe "create format" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, format_path(conn, :create), format: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == format_path(conn, :show, id)

      conn = get conn, format_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Format"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, format_path(conn, :create), format: @invalid_attrs
      assert html_response(conn, 200) =~ "New Format"
    end
  end

  describe "edit format" do
    setup [:create_format]

    test "renders form for editing chosen format", %{conn: conn, format: format} do
      conn = get conn, format_path(conn, :edit, format)
      assert html_response(conn, 200) =~ "Edit Format"
    end
  end

  describe "update format" do
    setup [:create_format]

    test "redirects when data is valid", %{conn: conn, format: format} do
      conn = put conn, format_path(conn, :update, format), format: @update_attrs
      assert redirected_to(conn) == format_path(conn, :show, format)

      conn = get conn, format_path(conn, :show, format)
      assert html_response(conn, 200) =~ "some updated mime_type"
    end

    test "renders errors when data is invalid", %{conn: conn, format: format} do
      conn = put conn, format_path(conn, :update, format), format: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Format"
    end
  end

  describe "delete format" do
    setup [:create_format]

    test "deletes chosen format", %{conn: conn, format: format} do
      conn = delete conn, format_path(conn, :delete, format)
      assert redirected_to(conn) == format_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, format_path(conn, :show, format)
      end
    end
  end

  defp create_format(_) do
    format = fixture(:format)
    {:ok, format: format}
  end
end
