defmodule ReaditWeb.Controllers.UserController do
  use ReaditWeb, :controller

  alias Readit.Accounts

  def show(conn, %{"id" => id}) do
    try do
      Accounts.user_by_id(id)
      |> do_show(conn)
    rescue
      # A cast error may occur if you give it an id that can't be converted to a binary_id (abddef, 123, etc), in such situations treat it as if no user was returned :)
      Ecto.Query.CastError -> do_show(nil, conn)
    end
  end

  defp do_show(%Accounts.User{} = user, conn) do
    conn
    |> put_status(200)
    |> json(user)
  end

  defp do_show(nil, conn) do
    conn
    |> put_status(404)
    |> json(%{error: "No user matching id"})
  end
end
