defmodule Mix.Tasks.Gutenberg.Reseed do
  use Mix.Task
  alias Gutenberg.Util

  def run(_args) do
    'mix ecto.drop' |> Util.Command.run_and_print()
    'mix ecto.create' |> Util.Command.run_and_print()
    'mix ecto.migrate' |> Util.Command.run_and_print()
    'mix run priv/repo/seeds.exs' |> Util.Command.run_and_print()
  end
end
