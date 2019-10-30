defmodule Readit.AuthTest do
  use ExUnit.Case, async: true

  alias Readit.Auth

  test "hash_password hashes the password" do
    supremely_secure_password = "p@$$vv0Rd"
    hashed_password = Auth.hash_password(supremely_secure_password)

    refute supremely_secure_password == hashed_password
  end

  test "verify_password returns true if the password matches the hash" do
    supremely_secure_password = "p@$$vv0Rd"
    hashed_password = Auth.hash_password(supremely_secure_password)

    assert Auth.verify_password(supremely_secure_password, hashed_password)
  end

  test "verify_password returns false if the password doesn't match the hash" do
    supremely_secure_password = "p@$$vv0Rd"
    hashed_password = Auth.hash_password(supremely_secure_password)

    refute Auth.verify_password("PASSWORD", hashed_password)
  end

  test "no_user_verify always returns false" do
    refute Auth.no_user_verify()
  end
end
