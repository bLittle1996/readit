defmodule Readit.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :readit,
    error_handler: Readit.Auth.ErrorHandler,
    module: Readit.Auth.Guardian

  # If there's a session token, restrict it to access tokens
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there's an Authorization header, do the same as above
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # load the user if either of the above worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end
