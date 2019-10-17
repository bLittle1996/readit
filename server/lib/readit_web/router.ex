defmodule ReaditWeb.Router do
  use ReaditWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReaditWeb do
    pipe_through :api
  end
end
