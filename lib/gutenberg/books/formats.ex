defmodule Gutenberg.Books.Formats do
  @moduledoc """
  The Formats context.
  """

  import Ecto.Query, warn: false
  alias Gutenberg.Repo

  alias Gutenberg.Books.Schemas.Format

  @doc """
  Returns the list of formats.

  ## Examples

      iex> list()
      [%Format{}, ...]

  """
  def list do
    Repo.all(Format)
  end

  @doc """
  Gets a single format.

  Raises `Ecto.NoResultsError` if the Format does not exist.

  ## Examples

      iex> get!(123)
      %Format{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Format, id)

  def create(attrs \\ %{}) do
    %Format{}
    |> Format.changeset(attrs)
    |> Repo.insert()
  end
end
