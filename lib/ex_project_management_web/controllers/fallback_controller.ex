defmodule ExProjectManagementWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ExProjectManagementWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ExProjectManagementWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ExProjectManagementWeb.ErrorView, :"404.json")
  end

  def call(conn, nil) do
    conn
    |> put_status(404)
    |> render(ExProjectManagementWeb.ErrorView, :"404.json")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(401)
    |> render(ExProjectManagementWeb.ErrorView, :"401.json")
  end
end
