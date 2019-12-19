defmodule Gutenberg.ImportCatalog.WriteFormatsToDb do
  use Gutenberg.Library

  def _(books_from_json) do
    books_from_json
    |> Enum.map(&get_formats/1)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(&build_format_record/1)
    |> Pipe.to(&Repo.chunked_insert_all(Db.Format, &1))
  end

  defp get_formats(book_from_json) do
    book_from_json
    |> Map.fetch!("formats")
    |> Map.keys()
  end

  defp build_format_record(mime_type) do
    Map.merge(%{mime_type: mime_type}, Repo.now_timestamps())
  end
end
