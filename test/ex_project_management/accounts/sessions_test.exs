defmodule ExProjectManagement.AccountsTest do
  use ExProjectManagement.DataCase

  alias ExProjectManagement.Accounts.Registration
  alias ExProjectManagement.Accounts.Session

  describe "sessions" do
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

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Session.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      user = create_user

      assert {:ok, %Session{} = session} = Session.create_session(@valid_attrs)
      assert session.token
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Session.create_session(@invalid_attrs)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Accounts.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Accounts.change_session(session)
    end
  end

  defp create_user(_) do
    Registration.sign_up(@user_attrs)
  end
end
