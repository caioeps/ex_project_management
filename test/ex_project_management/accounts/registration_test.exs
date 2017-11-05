defmodule ExProjectManagement.RegistrationTest do
  use ExProjectManagement.DataCase

  alias ExProjectManagement.Repo
  alias ExProjectManagement.Accounts.Registration
  alias ExProjectManagement.Accounts.User

  @valid_attrs %{
    email: "email@email.com",
    password: "valid_password",
    password_confirmation: "valid_password"}

  describe "changeset" do
    test "with valid attributes" do
      changeset = Registration.changeset(%Registration{}, @valid_attrs)
      assert changeset.valid?
    end
  end

  describe "sign_up" do
    test "it creates a user" do
      build(:registration, @valid_attrs)
      |> Map.from_struct
      |> Registration.sign_up()

      refute Repo.all(User) == []
    end
  end
end

