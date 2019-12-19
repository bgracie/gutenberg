defmodule Gutenberg.TestFactories do
  alias Gutenberg.Repo
  alias Gutenberg.Db

  def create_book(context) do
    book = Repo.insert!(%Db.Book{title: "A Book"})
    author = Repo.insert!(%Db.Author{name: "Bob Jones"})
    subject = Repo.insert!(%Db.Subject{name: "The life of bob jones"})

    Repo.insert!(%Db.BookAuthor{book_id: book.id, author_id: author.id})
    Repo.insert!(%Db.BookSubject{book_id: book.id, subject_id: subject.id})

    Map.merge(context, %{
      book: book,
      author: author,
      subject: subject
    })
  end
end
