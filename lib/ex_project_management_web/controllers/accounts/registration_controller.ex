defmodule ExProjectManagementWeb.Accounts.RegistrationController do
  use ExProjectManagementWeb, :controller

  alias ExProjectManagement.Accounts.User
  alias ExProjectManagement.Accounts.Registration

  action_fallback ExProjectManagementWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Registration.sign_up(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
