defmodule Mix.Tasks.Gutenberg.Reseed do
  use Mix.Task
  alias Gutenberg.Utils

  def run(_args) do
    'mix ecto.drop' |> Utils.run_puts()
    'mix ecto.create' |> Utils.run_puts()
    'mix ecto.migrate' |> Utils.run_puts()
    'mix run priv/repo/seeds.exs' |> Utils.run_puts()
  end
end
