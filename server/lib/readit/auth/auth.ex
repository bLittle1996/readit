defmodule Readit.Auth do
  alias Argon2
  alias Readit.Accounts
  alias Readit.Accounts.User

  def authenticate(email, password) do
    with %User{} = user <- Accounts.user_by(email: email) do
      verify_password(password, user.password)
    else
      error -> error
    end
  end

  def hash_password(password), do: Argon2.hash_pwd_salt(password)

  def verify_password(password, hashed_password),
    do: Argon2.verify_pass(password, hashed_password)
end
