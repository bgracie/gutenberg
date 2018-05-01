defmodule GutenbergWeb.LayoutView do
  use GutenbergWeb, :view

  def other_locales do
    List.delete(locales(), locale())
  end

  def with_new_locale(conn, new_locale) do
    conn.request_path |> replace_locale(new_locale)
  end

  def replace_locale(old_path, new_locale) do
    old_path
    |> String.replace(~r/\A\/#{locale()}/, "/#{new_locale}")
  end
end
