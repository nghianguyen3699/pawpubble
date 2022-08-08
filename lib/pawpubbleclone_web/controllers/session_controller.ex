defmodule PawpubblecloneWeb.SessionController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Accounts
  alias PawpubblecloneWeb.Auth

  def new(conn, _params) do
    render(conn, "new.html", authenticate: true)
  end

  def create(conn, %{ "session" => %{ "email" => email, "password" => password}} ) do
    case Accounts.authenticate_by_email_and_pass(email, password) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))
        # IO.inspect(conn)
      {:error, _reason} ->
        conn
        |> render("new.html", authenticate: false)
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
