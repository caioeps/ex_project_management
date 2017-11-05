defmodule ExProjectManagementWeb.Accounts.RegistrationView do
  use ExProjectManagementWeb, :view
  alias ExProjectManagementWeb.Accounts.RegistrationView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, RegistrationView, "registration.json", as: :user)}
  end

  def render("registration.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      password_hash: user.password_hash,
      username: user.username}
  end
end
