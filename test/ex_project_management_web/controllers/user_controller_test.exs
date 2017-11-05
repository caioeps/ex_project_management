defmodule ExProjectManagementWeb.Accounts.RegistrationControllerTest do
  use ExProjectManagementWeb.ConnCase

  alias ExProjectManagement.Accounts.User

  @update_attrs %{email: "updated.email@email.com", password: "123456", password_confirmation: "123456"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put conn, user_path(conn, :update, user), user: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete conn, user_path(conn, :delete, user)
      assert response(conn, 204)
    end
  end

  defp create_user(_) do
    user = insert(:user)
    {:ok, user: user}
  end
end
