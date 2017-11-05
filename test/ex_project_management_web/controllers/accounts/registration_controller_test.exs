defmodule ExProjectManagementWeb.RegistrationControllerTest do
  use ExProjectManagementWeb.ConnCase

  @create_attrs %{email: "email@email.com", password: "123456", password_confirmation: "123456"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, accounts_registration_path(conn, :create), user: @create_attrs
      body = json_response(conn, 201)["data"]

      assert %{"id" => _} = body
      assert body["id"]
      assert body["email"]
      refute body["password"]
    end
  end
end
