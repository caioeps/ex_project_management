defmodule ExProjectManagement.AccountsTest do
  use ExProjectManagement.DataCase

  alias ExProjectManagement.Accounts

  describe "user" do
    alias ExProjectManagement.Accounts.User

    @valid_attrs %{email: "some email", name: "some name", password_hash: "some password_hash", username: "some username"}
    @update_attrs %{email: "some updated email", name: "some updated name", password_hash: "some updated password_hash", username: "some updated username"}

    test "list_user/0 returns all user" do
      user = insert(:user, @valid_attrs)
      assert Accounts.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user, @valid_attrs)
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
      assert user.username == "some username"
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user, @valid_attrs)

      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
      assert user.username == "some updated username"
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user, @valid_attrs)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = build(:user, @valid_attrs)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "sessions" do
    alias ExProjectManagement.Accounts.Session

    @valid_attrs %{token: "some token"}
    @update_attrs %{token: "some updated token"}
    @invalid_attrs %{token: nil}

    def session_fixture(attrs \\ %{}) do
      {:ok, session} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_session()

      session
    end

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Accounts.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Accounts.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      assert {:ok, %Session{} = session} = Accounts.create_session(@valid_attrs)
      assert session.token == "some token"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      assert {:ok, session} = Accounts.update_session(session, @update_attrs)
      assert %Session{} = session
      assert session.token == "some updated token"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_session(session, @invalid_attrs)
      assert session == Accounts.get_session!(session.id)
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
end
