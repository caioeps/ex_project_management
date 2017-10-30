defmodule ExProjectManagement.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :username, :string

      timestamps()
    end

  end
end
