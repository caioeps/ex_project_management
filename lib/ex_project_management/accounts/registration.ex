defmodule ExProjectManagement.Accounts.Registration do
  @moduledoc """
  Module intented for registering new accounts
  """

  import Ecto.Changeset
  use Ecto.Schema

  alias Ecto.Changeset
  alias ExProjectManagement.Repo
  alias ExProjectManagement.Accounts.User
  alias ExProjectManagement.Accounts.Registration

  @user_ignore_attrs [:password, :password_confirmation]

  embedded_schema do
    field :email, :string
    field :password, :string
    field :password_confirmation, :string
    field :password_hash, :string
  end

  @doc false
  def changeset(registration, attrs \\ %{}) do
    registration
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> hash_password
    |> remove_password_from_changeset
    |> unique_constraint(:email, name: :users_email_index)
  end

  def sign_up(registration) do
    changeset = changeset(%Registration{}, registration)

    case changeset do
      %{valid?: true} ->
        %User{}
        |> Map.merge(Changeset.apply_changes(changeset))
        |> Repo.insert
      %{valid?: false} -> {:error, changeset}
    end
  end

  defp hash_password(changeset) do
    case changeset do
      %Changeset{valid?: true, changes: %{password: password}} ->
        changeset
        |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  defp remove_password_from_changeset(changeset) do
    filtered_attrs = Map.drop(changeset.changes, @user_ignore_attrs)

    changeset
    |> Map.merge(%{data: filtered_attrs})
    |> Map.merge(%{changes: filtered_attrs})
  end
end

