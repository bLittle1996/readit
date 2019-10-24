defmodule Readit.AccountsTest do
  use ExUnit.Case
  use Readit.RepoCase

  alias Readit.Accounts
  alias Readit.Accounts.User

  test "create_user creates an {:ok, %User{}} tuple when passed valid data" do
    assert {:ok, %User{}} =
             Accounts.create_user(%{
               "email" => "test@fake.ca",
               "password" => "ungabunga",
               "username" => "chungus"
             })
  end

  test "create_user returns an {:error, %Ecto.Changeset} tuple when passed invalid data" do
    no_data = %{}
    empty_password = %{"email" => "test@fake.ca", "password" => "", "username" => "awefaewf"}
    empty_username = %{"email" => "test@fake.ca", "password" => "fewaffw", "username" => ""}
    empty_email = %{"email" => "", "password" => "abc", "username" => "yes"}
    malformed_email_1 = %{"email" => "yes", "password" => "abc", "username" => "yes"}
    malformed_email_2 = %{"email" => "    ", "password" => "abc", "username" => "yes"}
    malformed_password = %{"email" => "", "password" => "    ", "username" => "yes"}
    malformed_username = %{"email" => "", "password" => "awef", "username" => "     "}

    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(no_data)
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(empty_email)
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(empty_password)
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(empty_username)
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(malformed_email_1)
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(malformed_email_2)
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(malformed_password)
    assert {:error, %Ecto.Changeset{}} = Accounts.create_user(malformed_username)
  end

  test "authenticate returns an {:ok, %User{}} when provided an existing users email and password" do
    email = "test@fake.ca"
    password = "letmeinplskthx"

    Accounts.create_user(%{
      "email" => email,
      "password" => password,
      "username" => "chungus"
    })

    response = Accounts.authenticate(email, password)

    assert {:ok, %User{}} = response
    assert {:ok, %User{email: ^email}} = response
  end

  test "authenticate returns an {:error, :invalid_credentials} when provided a incorrect or non-existing email and password" do
    email = "test@fake.ca"
    password = "letmeinplskthx"

    Accounts.create_user(%{
      "email" => email,
      "password" => password,
      "username" => "chungus"
    })

    assert {:error, :invalid_credentials} = Accounts.authenticate(email, password <> "NO!")

    assert {:error, :invalid_credentials} =
             Accounts.authenticate("notinthedata@base.com", password)
  end
end
