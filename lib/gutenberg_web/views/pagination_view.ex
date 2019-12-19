defmodule GutenbergWeb.Shared.PaginationView do
  use GutenbergWeb, :view

  @tail_ranges_length 2
  @middle_range_spread 2

  def page_classes(%{page_number: current_page}, this_page)
      when current_page == this_page,
      do: "page-item active"

  def page_classes(_, _), do: "page_item"

  def page_link(%{page_number: current_page}, this_page, _, _)
      when this_page == current_page,
      do: "#"

  def page_link(_, this_page, linkfn, conn), do: linkfn.(conn, this_page)

  def prev_classes(%{page_number: 1}), do: "page-item disabled"
  def prev_classes(_), do: "page-item"

  def next_classes(%{page_number: current_page, total_pages: total_pages})
      when current_page == total_pages,
      do: "page-item disabled"

  def next_classes(_), do: "page-item"

  def beginning_range(%{page_number: current_page}) do
    if middle_range_start(current_page) == 1 do
      []
    else
      1..@tail_ranges_length |> Enum.to_list()
    end
  end

  def middle_range(%{page_number: current_page, total_pages: total_pages}) do
    middle_range_start(current_page)..middle_range_end(
      current_page,
      total_pages
    )
    |> Enum.to_list()
  end

  def middle_range_start(current_page) do
    if current_page - @middle_range_spread <= @tail_ranges_length + 1 do
      1
    else
      current_page - @middle_range_spread
    end
  end

  def middle_range_end(current_page, total_pages) do
    if current_page + @middle_range_spread >= total_pages - @tail_ranges_length do
      total_pages
    else
      current_page + @middle_range_spread
    end
  end

  def end_range(%{page_number: current_page, total_pages: total_pages}) do
    if middle_range_end(current_page, total_pages) == total_pages do
      []
    else
      (total_pages - @tail_ranges_length + 1)..total_pages |> Enum.to_list()
    end
  end
end
