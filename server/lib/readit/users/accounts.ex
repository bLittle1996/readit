defmodule Readit.Accounts do
  @moduledoc """
    The accounts context
  """

  alias Readit.Repo
  alias Readit.Accounts.User

  def list_users() do
    Repo.all(User)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def user_by_id(id, opts \\ []) do
    Repo.get(User, id, opts)
  end

  def user_by(params, opts \\ []) do
    Repo.get_by(User, params, opts)
  end

  def user_by!(params, opts \\ []) do
    Repo.get_by!(User, params, opts)
  end
end
