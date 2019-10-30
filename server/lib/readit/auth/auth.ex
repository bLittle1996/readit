defmodule Readit.Auth do
  alias Argon2

  def hash_password(password), do: Argon2.hash_pwd_salt(password)

  def verify_password(password, hashed_password),
    do: Argon2.verify_pass(password, hashed_password)

  def no_user_verify(), do: Argon2.no_user_verify()
end
