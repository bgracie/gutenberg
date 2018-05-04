defmodule GutenbergWeb.BookView do
  use GutenbergWeb, :view

  @language_codes %{
    "en" => "English",
    "de" => "German",
    "es" => "Spanish",
    "fr" => "French"
  }

  def author(book) do
    Enum.at(book.authors, 0)
  end

  def language_labels(book) do
    book.languages
    |> Enum.map(&(&1.code))
    |> Enum.map(&Gutenberg.LanguageCodes.label/1)
    |> Gutenberg.List.to_sentence()
  end

  def online_format(book) do
    book.book_formats
    |> Enum.filter(&(String.contains?(&1.format.mime_type, "text/html")))
    |> Enum.at(0)
  end

  def kindle_format(book) do
    book.book_formats
    |> Enum.find(&(&1.format.mime_type == "application/x-mobipocket-ebook"))
  end

  def ereader_format(book) do
    book.book_formats
    |> Enum.find(&(&1.format.mime_type == "application/epub+zip"))
  end

  def formats_with_labels(book) do
    book.book_formats
    |> Enum.map(&{&1, mime_type_with_label(&1.format.mime_type)})
    |> Enum.sort_by(fn ({format, mime_type_label}) ->
      { String.contains?(mime_type_label, "Other"), mime_type_label }
    end)
  end

  def mime_type_with_label(mime_type) do
    "[#{mime_type_label(mime_type)}] #{mime_type}"
  end

  def mime_type_label(mime_type) do
    cond do
      String.contains?(mime_type, "text/html") -> "HTML"
      String.contains?(mime_type, "text/plain") -> "Plaintext"
      String.contains?(mime_type, "rtf") -> "Rich Text"
      String.contains?(mime_type, "audio") -> "Audio"
      String.contains?(mime_type, "video") -> "Video"
      String.contains?(mime_type, "video") -> "Image"
      mime_type == "application/epub+zip" -> "E-Pub"
      mime_type == "application/x-mobipocket-ebook" -> "Mobi"
      true -> "Other"
    end
  end
end
