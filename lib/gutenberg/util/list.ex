defmodule Gutenberg.List do
  def to_sentence([]), do: ""
  def to_sentence([one]), do: one
  def to_sentence([one, two]), do: "#{one} and #{two}"
  def to_sentence([one, two, three]), do: "#{one}, #{two}, and #{three}"

  def to_sentence([first | rest]),
    do: "#{first}, #{to_sentence(rest)}"
end
