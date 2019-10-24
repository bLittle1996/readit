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

  def changeset(%__MODULE__{} = user \\ %__MODULE__{}, %{} = attrs \\ %{}) do
    rfc_5332_email_regex =
      ~r<(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])>

    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_format(:email, rfc_5332_email_regex)
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
