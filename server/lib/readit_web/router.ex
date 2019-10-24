defmodule ReaditWeb.Router do
  use ReaditWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # the user may or not be logged in, but this pipeline will load the user data for us if available.
  pipeline :auth do
    plug Readit.Auth.Pipeline
  end

  # will make sure the user is logged in before allowing access to route. Must be called after :auth as that loads the data.
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", ReaditWeb do
    pipe_through [:api, :auth]

    get "/", Controllers.TestController, :hello

    post "/token", Controllers.AuthController, :authenticate
  end

  # restricted routes
  scope "/api", ReaditWeb do
    pipe_through [:api, :auth, :ensure_auth]

    get "/hidden", Controllers.TestController, :hello
  end
end
