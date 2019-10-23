defmodule Readit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Readit.Auth

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  # So whenever a valid changeset is provided and the password is being altered in some fashion, we'll make it so that the password becomes hashed using Argon2!
  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    changeset
    |> change(password: Auth.hash_password(password))
  end

  # otherwise if it is invalid or the password did not change, we'll just not modify the changeset!
  defp put_password_hash(changeset), do: changeset
end
