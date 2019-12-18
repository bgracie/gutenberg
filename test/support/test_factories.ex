defmodule Gutenberg.TestFactories do
  alias Gutenberg.Repo
  alias Gutenberg.Books

  def create_book(context) do
    book = Repo.insert!(%Books.Book{title: "A Book"})
    author = Repo.insert!(%Books.Author{name: "Bob Jones"})
    subject = Repo.insert!(%Books.Subject{name: "The life of bob jones"})

    Repo.insert!(%Books.BookAuthor{book_id: book.id, author_id: author.id})
    Repo.insert!(%Books.BookSubject{book_id: book.id, subject_id: subject.id})

    Map.merge(context, %{
      book: book,
      author: author,
      subject: subject
    })
  end
end
