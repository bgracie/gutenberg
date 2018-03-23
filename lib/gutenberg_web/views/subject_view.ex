defmodule GutenbergWeb.SubjectView do
  use GutenbergWeb, :view

  def author(book) do
    Enum.at(book.authors, 0)
  end
end
