defmodule Gutenberg.Util.Pipe do
  @doc """
  Helper to facilitate using anonymous functions and captures in pipes.
  It reduces the parenthesis noise compared to |> (&somefn(first, &1)).()
  """
  def to(piped, function) do
    function.(piped)
  end
end
