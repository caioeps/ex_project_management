defmodule ExProjectManagement.Factory do
  use ExMachina.Ecto, repo: ExProjectManagement.Repo

  alias ExProjectManagement.Accounts

  def user_factory do
    %Accounts.User{
      name: "John Doe",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: "hashed_password"
    }
  end

  def registration_factory do
    %Accounts.Registration{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "123456789",
      password_confirmation: "123456789"
    }
  end

  def session_factory do
    %Accounts.Session{
      user: build(:user),
      token: '123456789'
    }
  end
end

