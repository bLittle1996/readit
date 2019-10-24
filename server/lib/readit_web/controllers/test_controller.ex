defmodule ReaditWeb.Controllers.TestController do
  use ReaditWeb, :controller

  def hello(conn, _) do
    conn
    |> send_resp(200, "Hello!!!")
  end
end
