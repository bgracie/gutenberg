defmodule Mix.Tasks.Gutenberg.CompilePlans do
  use Mix.Task

  def run(_args) do
    'mix domain_planner.compile priv/domain_plans/raw priv/domain_plans/compiled'
    |> :os.cmd()
    |> IO.puts()
  end
end
