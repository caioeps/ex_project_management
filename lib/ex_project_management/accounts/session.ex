defmodule ExProjectManagement.Accounts.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExProjectManagement.Accounts.Session
  alias ExProjectManagement.Accounts.User

  schema "sessions" do
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Session{} = session, attrs) do
    session
    |> cast(attrs, [:token])
    |> validate_required([:token, :user_id])
  end

  @doc """
  Gets a single session.

  Raises `Ecto.NoResultsError` if the Session does not exist.

  ## Examples

      iex> get_session!(123)
      %Session{}

      iex> get_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_session!(%{"id" => id, "user_id" => user_id, "token" => token}) do
    Repo.get_by!(Session, id: id, user_id: user_id, token: token)
  end

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{field: value})
      {:ok, %Session{}}

      iex> create_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_session(%{"email" => email, "password" => password} = attrs) do
    user = Repo.get_by!(User, email: email)

    %Session{}
    |> Session.changeset(attrs)
    |> case do
         when %{valid?: true}
       end
    |> put_change(:token, SecureRandom.urlsafe_base64())
    |> put_change(:user_id, user.id)
    |> Repo.insert()
  end

  @doc """
  Deletes a Session.

  ## Examples

      iex> delete_session(session)
      {:ok, %Session{}}

      iex> delete_session(session)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Session{} = session) do
    Repo.delete(session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking session changes.

  ## Examples

      iex> change_session(session)
      %Ecto.Changeset{source: %Session{}}

  """
  def change_session(%Session{} = session) do
    Session.changeset(session, %{})
  end
end
