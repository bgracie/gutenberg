defmodule Gutenberg.Utils do
  def run_puts(cmd) do
    cmd
    |> :os.cmd()
    |> IO.puts()
  end

  def ensure_int(arg) when is_binary(arg), do: String.to_integer(arg)
  def ensure_int(arg) when is_integer(arg), do: arg
end
