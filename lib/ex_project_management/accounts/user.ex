defmodule ExProjectManagement.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExProjectManagement.Accounts.User


  schema "user" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash, :username])
    |> validate_required([:name, :email, :password_hash, :username])
  end
end
