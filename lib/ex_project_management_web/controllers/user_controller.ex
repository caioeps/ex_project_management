defmodule ExProjectManagementWeb.UserController do
  use ExProjectManagementWeb, :controller

  alias ExProjectManagement.Accounts
  alias ExProjectManagement.Accounts.User
  alias ExProjectManagement.Accounts.Registration

  action_fallback ExProjectManagementWeb.FallbackController

  def index(conn, _params) do
    user = Accounts.list_user()
    render(conn, "index.json", user: user)
  end
end
