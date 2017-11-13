defmodule ExProjectManagementWeb.UserController do
  use ExProjectManagementWeb, :controller

  alias ExProjectManagement.Accounts
  alias ExProjectManagement.Accounts.User

  action_fallback ExProjectManagementWeb.FallbackController

  def index(conn, _params) do
    user = Accounts.list_user()
    render(conn, "index.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Accounts.delete_user(Accounts.get_user!(id)) do
      send_resp(conn, :no_content, "")
    end
  end
end
