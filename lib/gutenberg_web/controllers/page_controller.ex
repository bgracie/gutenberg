defmodule GutenbergWeb.PageController do
  use GutenbergWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/books")
  end
end
