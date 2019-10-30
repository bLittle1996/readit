defmodule Readit.Auth.Guardian do
  use Guardian, otp_app: :readit

  alias Readit.Accounts

  def subject_for_token(%Accounts.User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.user_by_id(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
