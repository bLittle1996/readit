defmodule ReaditWeb.Controllers.AuthController do
  use ReaditWeb, :controller

  alias Readit.Accounts

  def authenticate(conn, %{"email" => email, "password" => password}) do
    do_authenticate(conn, Accounts.authenticate(email, password))
  end

  def authenticate(conn, _params) do
    conn |> put_status(400) |> json(%{error: "Please provide an `email` and `password`"})
  end

  defp do_authenticate(conn, {:ok, user}) do
    {:ok, token, _claims} = Readit.Auth.Guardian.encode_and_sign(user)

    conn |> put_status(200) |> json(%{token: token})
  end

  defp do_authenticate(conn, {:error, reason}) do
    conn |> put_status(400) |> json(%{error: reason})
  end
end
