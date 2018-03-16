defmodule Gutenberg.Utils do
  def run_puts(cmd) do
    cmd
    |> :os.cmd()
    |> IO.puts()
  end
end