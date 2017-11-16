defmodule ExProjectManagementWeb.SessionController do
  use ExProjectManagementWeb, :controller

  alias ExProjectManagement.Accounts
  alias ExProjectManagement.Accounts.Session

  action_fallback ExProjectManagementWeb.FallbackController

  def create(conn, %{"session" => session_params}) do
    with {:ok, %Session{} = session} <- Accounts.create_session(session_params) do
      conn
      |> put_status(:created)
      |> render("show.json", session: session)
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Accounts.get_session!(id)
    with {:ok, %Session{}} <- Accounts.delete_session(session) do
      send_resp(conn, :no_content, "")
    end
  end
end
