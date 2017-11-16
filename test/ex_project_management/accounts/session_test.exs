defmodule ExProjectManagement.SessionTest do
  use ExProjectManagement.DataCase

  alias ExProjectManagement.Accounts
  alias ExProjectManagement.Accounts.Registration
  alias ExProjectManagement.Accounts.Session

  @valid_attrs %{
    email: "email@email.com",
    password: "123456"
  }

  @invalid_attrs %{
    email: "email@email.com",
    password: "654321"
  }

  @user_attrs %{
    email: "email@email.com",
    password: "123456",
    password_confirmation: "123456"
  }

  describe "create_session" do
    setup [:create_user]

    test "creates a new session" do
    end
  end

  describe "change_session/1" do
    test "returns a session changeset" do
      session = build(:session)
      assert %Ecto.Changeset{} = Accounts.Session.change_session(session)
    end
  end

  defp create_user do
    Registration.sign_up(@user_attrs)
  end
end
