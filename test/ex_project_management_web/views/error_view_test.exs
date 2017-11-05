defmodule ExProjectManagementWeb.ErrorViewTest do
  use ExProjectManagementWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  describe "when no assigns are passed" do
    test "renders 401.json" do
      assert render_to_string(ExProjectManagementWeb.ErrorView, "401.json", []) ==
        "{\"error_type\":\"unauthorized\",\"error_code\":401}"
    end

    test "renders 404.json" do
      assert render_to_string(ExProjectManagementWeb.ErrorView, "404.json", []) ==
        "{\"error_type\":\"not_found\",\"error_code\":404}"
    end

    test "render 500.json" do
      assert render_to_string(ExProjectManagementWeb.ErrorView, "500.json", []) ==
        "{\"error_type\":\"internal_server_error\",\"error_code\":500}"
    end

    test "render any other" do
      assert render_to_string(ExProjectManagementWeb.ErrorView, "505.json", []) ==
        "{\"error_type\":\"internal_server_error\",\"error_code\":500}"
    end
  end
end
