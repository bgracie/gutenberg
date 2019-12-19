defmodule Gutenberg.ImportCatalog.WriteLanguagesToDb do
  use Gutenberg.Library
  alias Gutenberg.ImportCatalog

  def _(books_from_json) do
    books_from_json
    |> Enum.map(&Map.get(&1, "language"))
    |> Enum.filter(&(!is_nil(&1)))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(&build_language/1)
    |> ImportCatalog.SharedFunctions.insert_all(Db.Language)
  end

  defp build_language(code) do
    Map.merge(%{code: code}, Repo.now_timestamps())
  end
end
