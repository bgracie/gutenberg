defmodule Gutenberg.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Gutenberg.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import GutenbergWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Gutenberg.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Gutenberg.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Gutenberg.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
