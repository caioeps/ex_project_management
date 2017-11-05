defmodule ExProjectManagementWeb.Accounts.RegistrationController do
  use ExProjectManagementWeb, :controller

  alias ExProjectManagement.Accounts
  alias ExProjectManagement.Accounts.User
  alias ExProjectManagement.Accounts.Registration

  action_fallback ExProjectManagementWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Registration.sign_up(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
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
