defmodule Gutenberg.Books.Authors do
  @moduledoc """
  The Authors context.
  """

  import Ecto.Query, warn: false
  alias Gutenberg.Repo

  alias Gutenberg.Books.Author

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list()
      [%Author{}, ...]

  """
  def list do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get!(123)
      %Author{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Author, id)

  @doc """
  Creates a author.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Author{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end
end
