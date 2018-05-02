defmodule Gutenberg.Books.Languages do
  @moduledoc """
  The Languages context.
  """

  import Ecto.Query, warn: false
  alias Gutenberg.Repo

  alias Gutenberg.Books.Language

  @doc """
  Returns the list of languages.

  ## Examples

      iex> list()
      [%Language{}, ...]

  """
  def list do
    Repo.all(Language)
  end

  @doc """
  Gets a single language.

  Raises `Ecto.NoResultsError` if the Language does not exist.

  ## Examples

      iex> get!(123)
      %Language{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Language, id)

  @doc """
  Creates a language.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Language{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Language{}
    |> Language.changeset(attrs)
    |> Repo.insert()
  end
end
