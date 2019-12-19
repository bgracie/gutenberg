defmodule GutenbergWeb.FrontController do
  use GutenbergWeb, :controller

  def index(conn, _params) do
    render( conn, "index.html" )
  end
end
