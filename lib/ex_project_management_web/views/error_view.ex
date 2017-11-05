defmodule ExProjectManagementWeb.ErrorView do
  use ExProjectManagementWeb, :view

  def render("401.json", _assigns) do
    %{
      error_code: 401,
      error_type: :unauthorized
    }
  end

  def render("404.json", _assigns) do
    %{
      error_code: 404,
      error_type: :not_found
    }
  end

  def render("500.json", _assigns) do
    %{
      error_code: 500,
      error_type: :internal_server_error
    }
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end

end
