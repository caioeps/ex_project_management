defmodule ExProjectManagementWeb.RegistrationControllerTest do
  use ExProjectManagementWeb.ConnCase

  alias ExProjectManagement.Accounts
  alias ExProjectManagement.Accounts.User

  @create_attrs %{email: "email@email.com", password: "123456", password_confirmation: "123456"}
  @update_attrs %{email: "updated.email@email.com", password: "123456", password_confirmation: "123456"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, accounts_registration_path(conn, :create), user: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]
      assert %User{} = Accounts.get_user!(id)
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put conn, accounts_registration_path(conn, :update, user), user: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
      assert %User{email: "updated.email@email.com"} = Accounts.get_user!(id)
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete conn, accounts_registration_path(conn, :delete, user)
      assert response(conn, 204)
    end
  end

  defp create_user(_) do
    user = insert(:user)
    {:ok, user: user}
  end
end
