defmodule GutenbergWeb.SearchView do
  use GutenbergWeb, :view

  def search_tab_classes(tab_collection, collection)
      when tab_collection == collection,
      do: "nav-link active"

  def search_tab_classes(_, _), do: "nav-link"

  def search_tab_link(tab_collection, collection, _, _)
      when tab_collection == collection,
      do: "#"

  def search_tab_link(tab_collection, _, search_params, conn) do
    new_search_params =
      search_params
      |> Map.drop(["page"])
      |> Map.put("collection", tab_collection)

    search_path(
      conn,
      :search,
      locale(),
      %{"search" => new_search_params}
    )
  end

  def fragments(search_term, result_label) do
    ~r/#{search_term}/i
    |> Regex.split(result_label, include_captures: true)
    |> Enum.map(&decorate_fragment_label(&1, search_term))
  end

  def decorate_fragment_label(fragment, search_term) do
    if String.downcase(fragment) == String.downcase(search_term) do
      {fragment, :match}
    else
      {fragment, :nomatch}
    end
  end
end
