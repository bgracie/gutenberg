defmodule Gutenberg.Library do
  @moduledoc """
  A set of default aliases for the whole app
  """

  defmacro __using__(_args) do
    quote do
      alias Gutenberg.Db
      alias Gutenberg.Repo
      alias Gutenberg.Util
    end
  end
end
