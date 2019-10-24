defmodule Readit.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Readit.Repo

      import Ecto
      import Ecto.Query
      import Readit.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Readit.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Readit.Repo, {:shared, self()})
    end

    :ok
  end
end
