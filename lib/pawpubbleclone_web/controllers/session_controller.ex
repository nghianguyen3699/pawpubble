defmodule PawpubblecloneWeb.SessionController do
  use PawpubblecloneWeb, :controller

  alias Pawpubbleclone.Accounts
  alias PawpubblecloneWeb.Auth

  def new(conn, _params) do
    render(conn, "new.html")
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
        |> put_flash(:info, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
