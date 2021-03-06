defmodule GutenbergWeb.LayoutView do
  use GutenbergWeb, :view

  def other_locales do
    List.delete(locales(), locale())
  end

  def with_new_locale(%{request_path: request_path}, new_locale) do
    String.replace(request_path, ~r/\A\/#{locale()}/, "/#{new_locale}")
  end
end
