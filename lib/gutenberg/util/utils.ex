defmodule Gutenberg.Utils do
  def run_and_print(cmd) do
    cmd
    |> :os.cmd()
    |> IO.puts()
  end
end
