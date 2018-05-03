defmodule Gutenberg.Repo do
  use Ecto.Repo, otp_app: :gutenberg
  use Scrivener, page_size: 5

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def now_timestamps do
    %{
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    }
  end

  def chunked_insert_all(module, records)
    when is_atom(module) and is_list(records) do

    records
    |> Enum.chunk_every(1000)
    |> Enum.each(fn (chunk) -> insert_all(module, chunk) end)
  end
end
