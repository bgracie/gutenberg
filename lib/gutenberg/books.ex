defmodule Gutenberg.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Gutenberg.Repo

  alias Gutenberg.Books.Schemas.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list()
      [%Book{}, ...]

  """
  def list do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get!(123)
      %Book{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Book{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end
end
