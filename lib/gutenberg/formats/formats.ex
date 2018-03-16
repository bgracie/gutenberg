defmodule Gutenberg.Formats do
  @moduledoc """
  The Formats context.
  """

  import Ecto.Query, warn: false
  alias Gutenberg.Repo

  alias Gutenberg.Formats.Format

  @doc """
  Returns the list of formats.

  ## Examples

      iex> list_formats()
      [%Format{}, ...]

  """
  def list_formats do
    Repo.all(Format)
  end

  @doc """
  Gets a single format.

  Raises `Ecto.NoResultsError` if the Format does not exist.

  ## Examples

      iex> get_format!(123)
      %Format{}

      iex> get_format!(456)
      ** (Ecto.NoResultsError)

  """
  def get_format!(id), do: Repo.get!(Format, id)

  @doc """
  Creates a format.

  ## Examples

      iex> create_format(%{field: value})
      {:ok, %Format{}}

      iex> create_format(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_format(attrs \\ %{}) do
    %Format{}
    |> Format.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a format.

  ## Examples

      iex> update_format(format, %{field: new_value})
      {:ok, %Format{}}

      iex> update_format(format, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_format(%Format{} = format, attrs) do
    format
    |> Format.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Format.

  ## Examples

      iex> delete_format(format)
      {:ok, %Format{}}

      iex> delete_format(format)
      {:error, %Ecto.Changeset{}}

  """
  def delete_format(%Format{} = format) do
    Repo.delete(format)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking format changes.

  ## Examples

      iex> change_format(format)
      %Ecto.Changeset{source: %Format{}}

  """
  def change_format(%Format{} = format) do
    Format.changeset(format, %{})
  end
end
