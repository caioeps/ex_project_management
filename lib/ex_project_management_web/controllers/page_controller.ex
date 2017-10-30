defmodule ExProjectManagementWeb.PageController do
  use ExProjectManagementWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
