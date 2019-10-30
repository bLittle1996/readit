defmodule Readit.Accounts do
  @moduledoc """
    The accounts context
  """

  alias Readit.Repo
  alias Readit.Accounts.User
  alias Readit.Auth

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

  def authenticate(email, password) do
    with %User{} = user <- user_by(email: email),
         true <- Auth.verify_password(password, user.password) do
      {:ok, user}
    else
      nil ->
        # runs the hashing function, prevents certain attacks that look at how long it takes for the response to be received.
        Auth.no_user_verify()
        {:error, :invalid_credentials}

      _error ->
        {:error, :invalid_credentials}
    end
  end
end
