defmodule GutenbergWeb.PageView do
  use GutenbergWeb, :view

  def search_tab_classes(tab_collection, collection)
    when tab_collection == collection,
    do: "nav-link active"
  def search_tab_classes(_, _), do: "nav-link"

  def search_tab_link(tab_collection, collection, _, _)
    when tab_collection == collection,
    do: "#"
  def search_tab_link(tab_collection, _, search_params, conn) do
    new_search_params = search_params
      |> Map.drop(["page"])
      |> Map.put("collection", tab_collection)

    page_path(
      conn,
      :search,
      locale(),
      %{"search" => new_search_params}
    )
  end


end
