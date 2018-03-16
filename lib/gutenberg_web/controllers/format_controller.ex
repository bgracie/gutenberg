defmodule GutenbergWeb.FormatController do
  use GutenbergWeb, :controller

  alias Gutenberg.Formats
  alias Gutenberg.Formats.Format

  def index(conn, _params) do
    formats = Formats.list_formats()
    render(conn, "index.html", formats: formats)
  end

  def new(conn, _params) do
    changeset = Formats.change_format(%Format{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"format" => format_params}) do
    case Formats.create_format(format_params) do
      {:ok, format} ->
        conn
        |> put_flash(:info, "Format created successfully.")
        |> redirect(to: format_path(conn, :show, format))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    format = Formats.get_format!(id)
    render(conn, "show.html", format: format)
  end

  def edit(conn, %{"id" => id}) do
    format = Formats.get_format!(id)
    changeset = Formats.change_format(format)
    render(conn, "edit.html", format: format, changeset: changeset)
  end

  def update(conn, %{"id" => id, "format" => format_params}) do
    format = Formats.get_format!(id)

    case Formats.update_format(format, format_params) do
      {:ok, format} ->
        conn
        |> put_flash(:info, "Format updated successfully.")
        |> redirect(to: format_path(conn, :show, format))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", format: format, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    format = Formats.get_format!(id)
    {:ok, _format} = Formats.delete_format(format)

    conn
    |> put_flash(:info, "Format deleted successfully.")
    |> redirect(to: format_path(conn, :index))
  end
end
