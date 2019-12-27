defmodule Gutenberg.CatalogImporting.WriteSubjectsToDb do
  use Gutenberg.Library

  def _(books_from_json) do
    books_from_json
    |> Enum.map(&get_subjects/1)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(&build_subject_record/1)
    |> Pipe.to(&Repo.chunked_insert_all(Db.Subject, &1))
  end

  defp get_subjects(book_from_json), do: Map.fetch!(book_from_json, "subjects")

  defp build_subject_record(subject) do
    Map.merge(%{name: subject}, Repo.now_timestamps())
  end
end
